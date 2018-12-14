Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1539C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CC820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790460;
	bh=0pgjI2BkBtqotSlXIAUsbtHj5oZgxE2aJUxKuImszho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oy5hQZhTdkO7/pZHwxkj+e4p8s5auH0VBQ+fdiEYRbg62BSUjNRJmkrRKWj3MLh4/
	 eRzsF8Ip8Ex4kl7r3a3heUxzAm/AKphLJ6Vm2CFKrqbbVZ1uWUJzhIPKQXcegU+7Eb
	 Mn3/ZnueXHwACU4FYbY2Rl2ytZ51ykkVXNn/fpgo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CC820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeLNMLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:11:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbeLNMLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 840402133F;
        Fri, 14 Dec 2018 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789477;
        bh=0pgjI2BkBtqotSlXIAUsbtHj5oZgxE2aJUxKuImszho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I83DTDBjNSksJv9rTyAOkE6rgzTHvOi7DL8kRR1yUwjnWFr0Mwk8nQfOiF0Q6z52F
         eXSVS5lwZAf1dHAiEJvahYaUimFejno2wE11NW07Cpkw9YFskhH7IWFjMICVR1rv0J
         upb4Wzu4TNA1FfSZiyFwu2fk3xrjkAmPbkesNoeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 4.14 86/89] staging: speakup: Replace strncpy with memcpy
Date:   Fri, 14 Dec 2018 13:00:39 +0100
Message-Id: <20181214115733.941693560@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit fd29edc7232bc19f969e8f463138afc5472b3d5f upstream.

gcc 8.1.0 generates the following warnings.

drivers/staging/speakup/kobjects.c: In function 'punc_store':
drivers/staging/speakup/kobjects.c:522:2: warning:
	'strncpy' output truncated before terminating nul
	copying as many bytes from a string as its length
drivers/staging/speakup/kobjects.c:504:6: note: length computed here

drivers/staging/speakup/kobjects.c: In function 'synth_store':
drivers/staging/speakup/kobjects.c:391:2: warning:
	'strncpy' output truncated before terminating nul
	copying as many bytes from a string as its length
drivers/staging/speakup/kobjects.c:388:8: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/speakup/kobjects.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -387,7 +387,7 @@ static ssize_t synth_store(struct kobjec
 	len = strlen(buf);
 	if (len < 2 || len > 9)
 		return -EINVAL;
-	strncpy(new_synth_name, buf, len);
+	memcpy(new_synth_name, buf, len);
 	if (new_synth_name[len - 1] == '\n')
 		len--;
 	new_synth_name[len] = '\0';
@@ -518,7 +518,7 @@ static ssize_t punc_store(struct kobject
 		return -EINVAL;
 	}
 
-	strncpy(punc_buf, buf, x);
+	memcpy(punc_buf, buf, x);
 
 	while (x && punc_buf[x - 1] == '\n')
 		x--;


