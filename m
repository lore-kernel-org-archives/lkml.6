Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49q0gIyl4zf/kBszMgAq5FLwi5T/8VjreIv34OYJJv0WDxRfor+vUV0DULjXvw+Uvaf6xaE
ARC-Seal: i=1; a=rsa-sha256; t=1524406779; cv=none;
        d=google.com; s=arc-20160816;
        b=eaprkLtzEzGOTPYa8komB6B9jlsXqmIaTKlPjAWhyeFaZcXRMuLzys3AWPELbe5RFg
         bbaK0njmqikyR1mKHOSomyO5aeQV8VY8PQp+j1L7lYEUumkCFTR4wQv30cTCoM2a1psD
         FG0uKN3fYamOLnFaXRXIeVbr8eNh4ocga314LKPUJoc1ddVXgbuXkZ7NiHjvcrOl4M4K
         +0/mexODLAN/QxX2ZdxUZir0em0zPUCToSy5KcbsmG/6szwqPFWkRNe/3KN5CemI7hf2
         3Rkchk2lS/eGo0e3cenc4n5SfmY4gnkjDMy1JFcgdWM4cgtYE4NTdBNOvGTQ0gQk/DHw
         5f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OqgQDVycX9ZR4T2ZW601dqSyhygG6Qqe67Lw2vXwL1A=;
        b=stAqvxdw7cEVqb542zAogXSVSMwOsuLwJM6pCF/pnNdZ2q8g6VgpCoBU9lLHuqtngw
         W6TDrHOcm/4PYzR2g1QNVoKoEGlEsQ7vXSLoBHKgl9/zi2yz5Gk4QzaB/Un4CaONGOOg
         FGdpcxgCFd37V94iuejU8we+y6OzhJJVWJk4mCubtV7PLygSoRqKo78BO32lW1oV+evq
         bxLIS1CRnizfVzW2+AURE8LODsmN8sIAbh9yaes5qxg9Qqk1TJTdl3vx3xsoBkSYjhCX
         I627ktc/ofM3nuUL4/ypWmVneSCzmVbWjp9nE1jSIM4aNilZo7uSuQdnFW3ub43Equ/0
         dQxQ==
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
Subject: [PATCH 4.4 75/97] drm/radeon: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:53:53 +0200
Message-Id: <20180422135309.334765065@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455237200582440?=
X-GMAIL-MSGID: =?utf-8?q?1598456363728055389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5964,9 +5964,9 @@ static void si_set_pcie_lane_width_in_sm
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
