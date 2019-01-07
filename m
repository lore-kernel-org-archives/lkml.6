Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F647C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DFD20449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865178;
	bh=aolziLPkeACCygLg2EefYrfWfLRdVreB0xP0aJA0FD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MbuXtQQyfUvb7K6xmIb1+C+t5Df0EOUQp5F/mnpm4aGb8z0G32Lb9M+pX2Z2Ifi9N
	 KtWzIPWDdxxOMf5C46WH6/RoEbKHbHWn3wqHSez0KUgJIyOAORgsWLoh4uET+VVsDh
	 HHchPdx20S2BiYh8zgkGrw6a07nCVjqKbMRTgbHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfAGMqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbfAGMoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:44:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34212147C;
        Mon,  7 Jan 2019 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865048;
        bh=aolziLPkeACCygLg2EefYrfWfLRdVreB0xP0aJA0FD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DglFW6zPfd+0vqbUFdi8Tsd57VOC3vcs06f9uv3UI537pQq5bLMN0/JvITK+GQNZ/
         WqBfWW723pG4rTDFDGW5JrJ6IsZJ7T0DMuKXWqKMxCZslvUO89LW51odgIt4J683Jc
         AWuL9pdWWV3U+CTT2VA8oZfoYqV/RIFYQxGoFhIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Aurich <paul@darkrain42.org>,
        Yves-Alexis Perez <corsac@corsac.net>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.20 128/145] smb3: fix large reads on encrypted connections
Date:   Mon,  7 Jan 2019 13:32:45 +0100
Message-Id: <20190107104453.903389171@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Aurich <paul@darkrain42.org>

commit 6d2f84eee098540ae857998fe32f29b9e2cd9613 upstream.

When passing a large read to receive_encrypted_read(), ensure that the
demultiplex_thread knows that a MID was processed.  Without this, those
operations never complete.

This is a similar issue/fix to lease break handling:
commit 7af929d6d05ba5564139718e30d5bc96bdbc716a
("smb3: fix lease break problem introduced by compounding")

CC: Stable <stable@vger.kernel.org> # 4.19+
Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Signed-off-by: Paul Aurich <paul@darkrain42.org>
Tested-by: Yves-Alexis Perez <corsac@corsac.net>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3384,8 +3384,10 @@ smb3_receive_transform(struct TCP_Server
 	}
 
 	/* TODO: add support for compounds containing READ. */
-	if (pdu_length > CIFSMaxBufSize + MAX_HEADER_SIZE(server))
+	if (pdu_length > CIFSMaxBufSize + MAX_HEADER_SIZE(server)) {
+		*num_mids = 1;
 		return receive_encrypted_read(server, &mids[0]);
+	}
 
 	return receive_encrypted_standard(server, mids, bufs, num_mids);
 }


