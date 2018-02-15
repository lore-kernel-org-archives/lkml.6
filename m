Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226bm4434+aKxn0XhRMc8t7psp1rtxtp0LNh5+2anPtPOnsPLEIrzRtOo9TdNh+GsjUjr2DS
ARC-Seal: i=1; a=rsa-sha256; t=1518708531; cv=none;
        d=google.com; s=arc-20160816;
        b=sEIy6ofMd4h95t8MsaFWHJszPjiqVezchxFUa0RpJdPtFlTOZ4TrmrrI8zRKUOWHRp
         Cbp7KFUR3T26kVB01YxMrwwBb8Jx0ZuVwST1pG93RQtorCnkAaY8/ISg0BHDjqLHR7oT
         wupmZoAvbOt841H0YchHUD7b9dcQvmeoofVTyu35BOmukyHQf3XYuttGKffTKSG8Dyol
         a1Ur3bcnEomTYkd5aaJrvIv5BrlGJSJYFhPk2m5FStYlZ5vyVOuwmPSNCfIRZRRXL8tZ
         3Rbu4ddB9+tEOZjjiiR25XrYMsKKWjZ2Xo7nLSTYAcjnCTchkv8t+enWpFWMdagHUOrJ
         creg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rGUVvII661eYj9iiEIlXaubBCV8wDMpDmIqCs6gToPw=;
        b=uDU+zBw4O7O5O4TQxmTifEyT1qtJzgPIKvlTjpUE0sNRhhBr8pzqRavcOjXVbq3xSy
         lDSRtfyUrhzL+VcUTnfMZgOYXHz1COfH9k0SBXfXyVRtRUB6ZEoWiclrJ5Hvme2kh3PO
         sNYsbf2cRjC0YT9BMTzaIVA/w0Jfni4dP6hBTNgOo8MakRr3+oc8Bo7nA6o7joYMPwMB
         BrvJcF7LhpQbQdl7lwa3ytkhJl923Tg9az73tRPEvWmI2hfbFyUiS800IaWBiQnAVbVg
         HKonUtcCWXl9Pb6QCnfFD60GOSwhx6C3TvQOqypvBXX6iw9q4mi46DzC0yO4i1jO/9Hr
         nYuA==
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
Subject: [PATCH 4.9 76/88] EDAC, octeon: Fix an uninitialized variable warning
Date: Thu, 15 Feb 2018 16:17:43 +0100
Message-Id: <20180215151233.025520828@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480775002082254?=
X-GMAIL-MSGID: =?utf-8?q?1592481317798577687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
