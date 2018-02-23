Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411095-2-8823209545388212667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411094; b=UxXfHn8rV5Qr3L21Zli/nec8zljLJnlDlCD4xIhg5DZrHsy
    YDqqh+GLQQKYrPcifVoIzwVZNkeL47Z8T+lr+Pvt4RLaXTxhOMdheN/hLjIOLpZ0
    zoiBiM6aQ2i1nGIs995uc40lNv6CUtdfsokjQ6Ag4khpobcaL/zutYadBeBoGFeq
    WhHOhoxeb5Nei9lYVkg3MFg4OM7S/YU6ADqObfvcvDh0b7kvLmsckxhyJGmlpztd
    SiVW8sBrY0+cduG0/uCy43WJJvg5+Pw5v/vYFF9I0yUAoA8yU703WABAdcW2M5b8
    UasCHxiz6SsdvzhX95Bc4fphM5wWzJA2JiNNCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411094; bh=EribfEtsgEYx/uGeIQ4T3mpLYq
    e5c20F8XWyyzYwDVU=; b=ZzFtfcKXecVtMaUuWwtnBnVfUo64vGIufgJ/Ag7he0
    Umhp3vXkRB0+HFvBWaCNXmwSqUd7z5O3S3sx++x+jpQMZAjkmJF5G87YM266qwUr
    q2/bZvQMtufPp8dtVDJVvCcIYzsMxKDkxHFDIGcHhOQoactwEs1rs24gVLMvUzVf
    17MWeoitjDP6V+WR7ygIntfpA9FjtPqGEzGUAMrENYpGRNrPf8b3kI69gW8RB0KZ
    pqMwKHez4uvC1dZwjWZ/dTsS5wCH1IuVqdbllL6AYozaZGu/Vfwdjln2Fq+pc9A9
    F4jZPw174SLg3siAHfEH6LhdXl0Q0mvlbf+5lNthz0iw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbeBWSiL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:38:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbeBWSiI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:38:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 079/193] ALSA: hda/ca0132 - fix possible NULL pointer use
Date: Fri, 23 Feb 2018 19:25:12 +0100
Message-Id: <20180223170338.418889960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 46a049dae771b95e77ac6c823330f4a60f600236 upstream.

gcc-7 caught what it considers a NULL pointer dereference:

sound/pci/hda/patch_ca0132.c: In function 'dspio_scp.constprop':
sound/pci/hda/patch_ca0132.c:1487:4: error: argument 1 null where non-null expected [-Werror=nonnull]

This is plausible from looking at the function, as we compare 'reply'
to NULL earlier in it. I have not tried to analyze if there are constraints
that make it impossible to hit the bug, but adding another NULL check in
the end kills the warning and makes the function more robust.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1482,6 +1482,9 @@ static int dspio_scp(struct hda_codec *c
 		} else if (ret_size != reply_data_size) {
 			codec_dbg(codec, "RetLen and HdrLen .NE.\n");
 			return -EINVAL;
+		} else if (!reply) {
+			codec_dbg(codec, "NULL reply\n");
+			return -EINVAL;
 		} else {
 			*reply_len = ret_size*sizeof(unsigned int);
 			memcpy(reply, scp_reply.data, *reply_len);
