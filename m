Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2258EW+mpOIKvLbOSi1GHIrrMN5lK77/+bpmP5l9EV4N+4JXsEUV9nLodxXRWak8BpqpWkgc
ARC-Seal: i=1; a=rsa-sha256; t=1518708297; cv=none;
        d=google.com; s=arc-20160816;
        b=0Ti/edJxbzdh1MiZnnc25ojU81EWMZVlU/0C3FitBO0NYGumF/sGF8VdxDqcjQ4/6s
         Pt4Kg4DbyH4lJLFZmG23SJ6KmTNeceRDIlQgJ0tG/sD3JD3W6f79LkkglRWsREN/AKkr
         BMI6PM2DBx7JmNjQTCxN2M1iM9+fwBq06mulgXU31YCm3T/AjoHs4222loMQxTkMYkIm
         LoDou97u7LVABeicM4uXxilgc3HfVFzlGpibyXfmByfcwBwgsYSdTPoMkk6hrfe+hBLr
         EyNhW8KEHOHmAmg+9E7bvvHQKaHNjLuX8m+QVbhr7hBINkQS4VnHTPv7Z9tZowcjMYYb
         pyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=slkwwMUKEk3BIRP8ReEv5VMce8QFkEr2ounLq/IOWhg=;
        b=Azz3sKnIJivbU5+IsGdoAHq1+m+MoQoqmPQtNP9f9gxSnRT8sbXik9EQ4XPPNIWhWR
         NbMnMNXHAQ2KUcGGvxPvW1BcKq21JPDcpi4IriClF3PoKKHceDN+03nzj3bGd5boQTDO
         llshlhf0wUIgHgz4cw9vtV/J+tFFr/3/c9XvIvurzZ2RxN/Sd2/m+cdDOwsO0uDxOAOO
         tES84luCZxspM0+LtiJCxzPym/kMxDM8Vl/m5HUS38aD3uyrtLFaT33t/HMywlSL5AXE
         ZC2Iy9QzkwzRoSjO1G/xSritiCUQBYUKiiqbJWcdut+rkiCX0d3YxJs/YzYP6iBYfEp7
         tTJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	David Daney <david.daney@cavium.com>,
	linux-edac <linux-edac@vger.kernel.org>,
	linux-mips@linux-mips.org,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.4 101/108] EDAC, octeon: Fix an uninitialized variable warning
Date: Thu, 15 Feb 2018 16:17:38 +0100
Message-Id: <20180215151236.402501789@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480775002082254?=
X-GMAIL-MSGID: =?utf-8?q?1592481071915640610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 544e92581a2ac44607d7cc602c6b54d18656f56d upstream.

Fix an uninitialized variable warning in the Octeon EDAC driver, as seen
in MIPS cavium_octeon_defconfig builds since v4.14 with Codescape GNU
Tools 2016.05-03:

  drivers/edac/octeon_edac-lmc.c In function ‘octeon_lmc_edac_poll_o2’:
  drivers/edac/octeon_edac-lmc.c:87:24: warning: ‘((long unsigned int*)&int_reg)[1]’ may \
    be used uninitialized in this function [-Wmaybe-uninitialized]
    if (int_reg.s.sec_err || int_reg.s.ded_err) {
                        ^
Iinitialise the whole int_reg variable to zero before the conditional
assignments in the error injection case.

Signed-off-by: James Hogan <jhogan@kernel.org>
Acked-by: David Daney <david.daney@cavium.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: linux-mips@linux-mips.org
Fixes: 1bc021e81565 ("EDAC: Octeon: Add error injection support")
Link: http://lkml.kernel.org/r/20171113161206.20990-1-james.hogan@mips.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/octeon_edac-lmc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -79,6 +79,7 @@ static void octeon_lmc_edac_poll_o2(stru
 	if (!pvt->inject)
 		int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
 	else {
+		int_reg.u64 = 0;
 		if (pvt->error_type == 1)
 			int_reg.s.sec_err = 1;
 		if (pvt->error_type == 2)
