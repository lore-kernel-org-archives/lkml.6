Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TxmJF4EtmPGZRDiHgaFqR/aJg4azotBtdLO5W6E83+pqCoYgSdR9CA2dRP7kuppTMbfg8
ARC-Seal: i=1; a=rsa-sha256; t=1524405705; cv=none;
        d=google.com; s=arc-20160816;
        b=U3oU8z8aV8n3GzXC1ELpHCHRUZOUpHV7yWCK/wHmLv1buWKFNG7G4+cNnQt34AuY9s
         GyeVcO2UXM2tQU5lkRMzH6mThLtwJEQ9zMJjmn0VwYRjG7POmh1YESMF48aDt/jEZo2c
         i9vDct15xX6R4oy+CtjNPDegecfSEID7jXADRw4T/PGgmah+dmOygb0/RvzHvc40VRaD
         VViMzGTj5zgZmgkJMvQ5yKyZBTWyky0FGDyHxZpF5BwhlPK65M1LwRjwwTr0Mbe5csII
         SFe26Icams9BP14SAlG0ZPpOcQCWEHqR/eRHyBabHrl+ssTe9U/M0hA8Arx0vRgEJtGZ
         5kqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lVrMlD4JC5LSqmfemPA7Of0Ebqt+Kh3H+8bjNXOkP44=;
        b=w5mtHsgWxW4DBX1SMsRHQbhDsh/0kKURLqbQOn8DqKc4RmQMa8ViILuhHQoYiXp/q7
         SbIRCdL4CZ5rw+sWfmaHA6Nyo1pPn47QzLC5CeSK2OIuFkOI2Vbx2OtQgUTeQGlealA6
         jAd43FY524cDBUogohQHUxBONemovZCeFCe9yNsHUzLSvqr2JuwKumtOEmK4O3dMC1A7
         QUrQckFTDfDaBCXKx4NowFtDzNHyfen6cNst3lUwYi7KNMgo3HDPKtCbpl4zhokxsGBu
         p+loEOrGsNcDYHwR2LJkZS/EBTYyEtkTGEC4IHX0p85jufggDFe/q1CHH63bO0vMxPOQ
         TLaA==
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
Subject: [PATCH 4.16 157/196] drm/radeon: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:52:57 +0200
Message-Id: <20180422135112.354084289@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455237200582440?=
X-GMAIL-MSGID: =?utf-8?q?1598455237200582440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5912,9 +5912,9 @@ static void si_set_pcie_lane_width_in_sm
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
