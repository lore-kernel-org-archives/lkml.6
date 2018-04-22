Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/13HNrp05RsoDNSyFU9L+l4uA3dR/3D0FkeZH7AgwYZhh4Xsno3t1gAcbth5CJ5mDHkfXC
ARC-Seal: i=1; a=rsa-sha256; t=1524406139; cv=none;
        d=google.com; s=arc-20160816;
        b=t+GOopsXDPYj6ygrgbQ0SJOG5kLWQDKaFXCw9Z4sIAA1vBeMMbzFSo843laRN0nk09
         6qfg/O4jP0htjlA2wsJqPvD+KExhqMfiyhVY+PCsjFWeD2J2q942z4NZNor1ZZCZKTUT
         enLMxKYkHS8cWmkY17RNttYPvKiNLUUuvgjt/3r70tS113T/RD7+hkRH/1diC+d0xtQ2
         FYCgpst/gmxf7S/sPs/poD5DQPrDVtUx7S/3pI0edPN/VSV2hx3+RQgNStcyau12I+1t
         /xInMha345opkEEQOT9TYs2aNUj7iogi61zUzFnETnvPTDEqhV3yEUBVOmT9TaQQ/FiY
         nqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IIo4bAQ9N7PT24sSB0k99fZyCyfaDOsF7BxYDQCbADM=;
        b=O4qoLAK2Y85PmzsXiRyMsWIVKm3c1ajMaYR5K46OLAI1Rcizi13T4QjHnNvrr3SKpb
         g/vLu7wF1TvY/Vh++9lxkv8GEuUto3fv7jZiO8KwdG9BRJvxK8gwG9qDRHx6RQOPaDP+
         YZ5EERzusCfdpKXKTHKA5sK/X4wTGFYBfjQirqE7/+ZA1Np0pqILDd2ZAHxAUoOQWzXc
         WQ3dqbsB6PMKksqxL03HZoosinFPMrGyx9I/CPiNlv3WQ8XZSYSqkrX/dGjRNLmfHtt9
         4nPeml5QEQ8UbUKU0uktBU1+FyoNtxVYjfa17OgOJRwRpclP6AElX0LJKGvexqJbgGhN
         iH1Q==
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
Subject: [PATCH 4.14 127/164] drm/radeon: Fix PCIe lane width calculation
Date: Sun, 22 Apr 2018 15:53:14 +0200
Message-Id: <20180422135140.590145165@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455237200582440?=
X-GMAIL-MSGID: =?utf-8?q?1598455692191909719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
