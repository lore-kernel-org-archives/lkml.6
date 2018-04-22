Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8BxAaMMLFLkRthWixlz9J9zTGlDUJ0QJCwCkDGumE8XQ4DmW2xsTYY+4JGUTAoNBA2MxX
ARC-Seal: i=1; a=rsa-sha256; t=1524406044; cv=none;
        d=google.com; s=arc-20160816;
        b=akpNylpypnDo5vHnu5QKS+9WNW6HQ2UeVRFjX/H3kIE7m9RwkH0Ig35e72VfU459Jj
         zsiOR8QNu4ukz4n8W31nWF60mnnGeqkx5E+a7088YYpizjY2M5RJ2rq2rQCGUWVURgGw
         0ThKbRktkT8JLCvRP89p/gf0aRyB41jQTEqtVmPTT5a1dgxki+wrjmc9IQIV/DnsGOx5
         mgKlXmu6XcV1koBTcoQHUo5aSyVfGPBAu2AY7BNFgULYcXSiUk2uyqyUoo66r0nmRTKI
         j5YHlSc25Dwjo+RZOZZl/10sL0fZdwhHmvwpi1gQqKsVBXQKMXfuxjrP0V4LofUalz3z
         Xk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f5UpkYa+yj0H3MkOHE72TWcSQolIKLGVBQ6wEjct05c=;
        b=PF860/45qyxV5YPXcE6qyB+R7kHjvfY4QyQJt7Sr7bmE7M3YKFbShJohOMT0VV2tEx
         U0ullTig/LJKRG/5hbJR++Sf91JGM9e6MCAQWBZcI3Rqp6RI9k5Z3tLn48fz5d0g7hM6
         1SPTbGD7Gea0IImyLjw/+7tmeDBIhMR5GfYzZFGlfXg9rSGRtMzWGtA6JPXi6/ExYWR8
         u0XDr1WA4aZYhquIcRLE9T6csMnn2dZhab09mh7optp+0eWaW8Ojs15wzIMA2buS1Nn6
         sq7BXV9f2v9ws+soTqUcT0JYHEjaX4LzfCOLeVKdYX/J13DnkvgZG7ge/Q+4nZ7tcWqY
         jRbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maxime Jayat <maxime.jayat@mobile-devices.fr>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4.14 092/164] dmaengine: at_xdmac: fix rare residue corruption
Date: Sun, 22 Apr 2018 15:52:39 +0200
Message-Id: <20180422135139.190008749@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455126397049965?=
X-GMAIL-MSGID: =?utf-8?q?1598455592710427932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Jayat <maxime.jayat@mobile-devices.fr>

commit c5637476bbf9bb86c7f0413b8f4822a73d8d2d07 upstream.

Despite the efforts made to correctly read the NDA and CUBC registers,
the order in which the registers are read could sometimes lead to an
inconsistent state.

Re-using the timeline from the comments, this following timing of
registers reads could lead to reading NDA with value "@desc2" and
CUBC with value "MAX desc1":

 INITD --------                    ------------
              |____________________|
       _______________________  _______________
 NDA       @desc2             \/   @desc3
       _______________________/\_______________
       __________  ___________  _______________
 CUBC       0    \/ MAX desc1 \/  MAX desc2
       __________/\___________/\_______________
        |  |          |  |
Events:(1)(2)        (3)(4)

(1) check_nda = @desc2
(2) initd = 1
(3) cur_ubc = MAX desc1
(4) cur_nda = @desc2

This is allowed by the condition ((check_nda == cur_nda) && initd),
despite cur_ubc and cur_nda being in the precise state we don't want.

This error leads to incorrect residue computation.

Fix it by inversing the order in which CUBC and INITD are read. This
makes sure that NDA and CUBC are always read together either _before_
INITD goes to 0 or _after_ it is back at 1.
The case where NDA is read before INITD is at 0 and CUBC is read after
INITD is back at 1 will be rejected by check_nda and cur_nda being
different.

Fixes: 53398f488821 ("dmaengine: at_xdmac: fix residue corruption")
Cc: stable@vger.kernel.org
Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/at_xdmac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1471,10 +1471,10 @@ at_xdmac_tx_status(struct dma_chan *chan
 	for (retry = 0; retry < AT_XDMAC_RESIDUE_MAX_RETRIES; retry++) {
 		check_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
 		rmb();
-		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
-		rmb();
 		cur_ubc = at_xdmac_chan_read(atchan, AT_XDMAC_CUBC);
 		rmb();
+		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
+		rmb();
 		cur_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
 		rmb();
 
