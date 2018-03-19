Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELub/CP3CoNX7KdbxMVrF2OwdbwUNQ1Hw2y40Vlt/2fmcaGPO3Uk4PSJr/yfZr0QiUpj1E2w
ARC-Seal: i=1; a=rsa-sha256; t=1521483672; cv=none;
        d=google.com; s=arc-20160816;
        b=jg0Tp4SGf88sVqx+GGP0TifJLwizAB+tifbXZ77tO/Wm2a96ebt9CU4HEPyd+OV+TE
         oLhZkQgrT7x11SenSLx1522OsjhFP2gvdguLCKe9PBY30aYsNQQfbk35XlIK0RYnD729
         amweNpz335t7sp9iOaD9+A8mDWjmCLaFvHbfVNAP0BCwplnwLSt95ZtQBpA6g8X/V6b2
         pZwgV/I9IW4uOf6Nb7igIsSoQXGj89yIy3lbRuGhKSzf0dZ6yiMgcxat+rSSFDbZCjSa
         LHAE2AAeGv3VitNiBKcNFsImI38wvZnMUDG+PwhUo6h3jErIZMiyL8K/5o8ckeLqbs9O
         JORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/kZv9rNjqwFGPiPzk1R3hyGwxB1c895M4KfplsvTph4=;
        b=KKeTD+IPDFSEMVv3UvmorHWiW+kKvb+eKTVgzSq3m++/67OfxD79BB9pgh4AfWCIfO
         +yxJuGQsPT1AkL95a9UHM9e1XTTPEJ0uLsu9bu6VnG2xI35MZkJnWPvRiYqDZ78LSHMs
         jApw0/VJB42L4iMEvgk2k/1fizTciLZPDHziZlA979YCjY5cuc1mqmKjncXceJW7acwm
         j7lcTTZJEFlLne0HSPiYSNsBo3C5+yEovmKf2Oufx3tA7QBO318drqcpzWDtgGVNeiDd
         DrjtyXaSwXlOtmtx3bOb4Z7STDXV/Fv7wCnJzB7iZAwZyceEkPrNQlhJV4nqUj6v1ZVj
         d6hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 075/241] ALSA: firewire-lib: add a quirk of packet without valid EOH in CIP format
Date: Mon, 19 Mar 2018 19:05:40 +0100
Message-Id: <20180319180754.309225360@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391263239901083?=
X-GMAIL-MSGID: =?utf-8?q?1595391263239901083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>


[ Upstream commit 2128f78f75a36a34dfef0e127273c2f820c5c904 ]

In IEC 61883-1, when two quadlets CIP header is used, the most significant
bit in second CIP header stands. However, packets from units with MOTU
protocol version 3 have a quirk without this flag. Current packet streaming
layer handles this as protocol error.

This commit adds a new enumeration constant for this quirk, to handle MOTU
protocol version 3.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/amdtp-stream.c |    5 +++--
 sound/firewire/amdtp-stream.h |    3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -471,8 +471,9 @@ static int handle_in_packet(struct amdtp
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
 	 * For convenience, also check FMT field is AM824 or not.
 	 */
-	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
-	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH)) {
+	if ((((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
+	     ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH)) &&
+	    (!(s->flags & CIP_HEADER_WITHOUT_EOH))) {
 		dev_info_ratelimited(&s->unit->device,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -29,6 +29,8 @@
  * @CIP_JUMBO_PAYLOAD: Only for in-stream. The number of data blocks in an
  *	packet is larger than IEC 61883-6 defines. Current implementation
  *	allows 5 times as large as IEC 61883-6 defines.
+ * @CIP_HEADER_WITHOUT_EOH: Only for in-stream. CIP Header doesn't include
+ *	valid EOH.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -39,6 +41,7 @@ enum cip_flags {
 	CIP_SKIP_DBC_ZERO_CHECK	= 0x10,
 	CIP_EMPTY_HAS_WRONG_DBC	= 0x20,
 	CIP_JUMBO_PAYLOAD	= 0x40,
+	CIP_HEADER_WITHOUT_EOH	= 0x80,
 };
 
 /**
