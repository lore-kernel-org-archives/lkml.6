Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49EGQfWvrfkACQSpnIY+3AtU7ebsNv+cL8m+Z8Y6bynS5mTFlJ6mAEPPohgPRRkIBnOvjXD
ARC-Seal: i=1; a=rsa-sha256; t=1524406659; cv=none;
        d=google.com; s=arc-20160816;
        b=cgPESJjZpKWQ+dWXRZc888v/I9S9yHylJdpNDMSyL5A5W4lGC3wJAdM0eUavjwyVGJ
         SExxK34ugly/az7uOc6Xhy7um84ZDeDp7LcHM0QWnHrBYQSXLfatFZoihyGy2GnHaC53
         jNp7byrCyUfO3IyhUIXOiroI0T4wKDznqWqGD+VSKM61c2Vg3dTMITwYg+VKd7Wzp6eh
         VClYLyaTeO+kyTGS/bYZqFxwMlUxK8PM0unvZQhWk2W7tePWDBwELUOo2ScY949Dpl40
         Ly9kz/BdfAVCX7GxBE4Bgr19b+L2iK3N7md35IV1GebVRTCguyGGKXQgY4Kxn9B2+rnA
         CSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MiMaMVSpPk9nVeebmqlytEG/j9TrDTNF+LipFp7GFfI=;
        b=XYaSjVcPm2qbh8CL8x5V5M73SzDNLtEJFUTXsMevQB+g+m5BaPL362Jx3nti1CgDTh
         LprMWIsHmJkOyNB1FdQJ+zo2R6z0sqoHUf1aPFMrYGfQn0lcK7FaGZaVnYvQG1BSvqcH
         HAVc0vvz0+cZYYYoV5CK3arzZCh0Ei2VReXACWp7yLXYfbznD+iPcjHIHyL5JZU5Vfcd
         Tezp1AGtzAU5Sh4AjYT7lYqVloDueAr8nV82v9CgiVtpDbanpZID67gY+QQu/uOcFQqt
         vQr+o1tR69wzyTHlZH1h9wIyPt54xyfGe67vn1tI99aY+WE55nWaho4eylOzt41tiRzt
         6MEg==
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
Subject: [PATCH 4.4 56/97] dmaengine: at_xdmac: fix rare residue corruption
Date: Sun, 22 Apr 2018 15:53:34 +0200
Message-Id: <20180422135308.405196681@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455126397049965?=
X-GMAIL-MSGID: =?utf-8?q?1598456237001472268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1473,10 +1473,10 @@ at_xdmac_tx_status(struct dma_chan *chan
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
 
