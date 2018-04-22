Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Aa9ZVfXB3BCfLbYP6ukwt1lspqMXQOlQcNLKSGd2Qd6GWunVkcyd2vyvNvp8QGeMmN0HD
ARC-Seal: i=1; a=rsa-sha256; t=1524406432; cv=none;
        d=google.com; s=arc-20160816;
        b=V+qcRANJmBmk6udgxiAiIYkhUlQc0iuzic7nyBxGDse/IVKYoH6qKxKzUSmC5BPXKQ
         7FAHbXdPXGya4DLOrNB7ZsFtVL89SCeo0+9ZWVryfgE6S1wvVouUv2oXbqE6fMMgw2nb
         PngmxeGSn5dNeTUGeE7l9w1j1JSg1a0a1Lruv/5EoRco/3ZTeNPWed47Y+pRORQulJlG
         BdBEl2tJu9S6TGTNo7c0HnAwTCetHYzboijP9uhw2Av0xXv42snuOqKnwPz3YTjnTHrR
         trBhxYoNbSVOTvY3vv+TWIw6U5XVyeeusUsFaP+EDNTFIBw264tsoiBntOpWo1QcG07a
         y1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ayopnuq90BIAuNTbmMas2dIOTACGTG5NPywlIyoXWkI=;
        b=Khie/7vt6i8a+3KECnRVtnAgnp4mox+flOAN/0E4uxrI5gTONgdlXo6psFE2smy5h2
         IpKBWVtyyEz12foFNsKF1aBb+VDXzjs+OpTW5h6Fz84qOHSdU4oeIWZ4p2mfaaljNs1z
         k0XopqC83EbhZPlhquw2AD8VC2ceqqISka4tbrW8IAEICvlhURm+rjz94iPSJpNDSINd
         aIqC2P1L6aAPFeueBMzLSu43gJOabf3oHLD6PT9eLjXa/c520INe1tC2bA0ArPHpGFLM
         ExKro7D5JWFpzXOsravzO03JsFd9L5NGVxFQB6zSaBqHzUICTOUVoCedzOSvYsr2ahkx
         gWyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Chunming Zhou <david1.zhou@amd.com>,
	Paul Parsons <lost.distance@yahoo.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 70/95] drm/radeon: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:53:39 +0200
Message-Id: <20180422135213.294307081@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455237200582440?=
X-GMAIL-MSGID: =?utf-8?q?1598455999877807459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Parsons <lost.distance@yahoo.com>

commit 85e290d92b4b794d0c758c53007eb4248d385386 upstream.

Two years ago I tried an AMD Radeon E8860 embedded GPU with the drm driver.
The dmesg output included driver warnings about an invalid PCIe lane width.
Tracking the problem back led to si_set_pcie_lane_width_in_smc().
The calculation of the lane widths via ATOM_PPLIB_PCIE_LINK_WIDTH_MASK and
ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT macros did not increment the resulting
value, per the comment in pptable.h ("lanes - 1"), and per usage elsewhere.
Applying the increment silenced the warnings.
The code has not changed since, so either my analysis was incorrect or the
bug has gone unnoticed. Hence submitting this as an RFC.

Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Chunming Zhou <david1.zhou@amd.com>
Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/si_dpm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5969,9 +5969,9 @@ static void si_set_pcie_lane_width_in_sm
 {
 	u32 lane_width;
 	u32 new_lane_width =
-		(radeon_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
+		((radeon_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
 	u32 current_lane_width =
-		(radeon_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
+		((radeon_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
 
 	if (new_lane_width != current_lane_width) {
 		radeon_set_pcie_lanes(rdev, new_lane_width);
