Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227mgn8In9TYcaYJ59Vw01z1JGEZvFrcCkb1HSaMYigoAu+dt4/Y3H9JVrQrr4o63nui6gS/
ARC-Seal: i=1; a=rsa-sha256; t=1518708014; cv=none;
        d=google.com; s=arc-20160816;
        b=mpyYHl1jUQleUQC3bAQaFdsgVYiX/dTqJYf10NmjYVP4bsFcUPh1SkFFH4VYEnPNse
         RUkmyQpdd13Wlq5DOx/ZarAOy0Xu1JMBG9GOk4AhE9N4S8LDnoo5lXzbJFffNEyfcIWb
         zD8FHD1jvlHBdMgMV4h4eVbWJvhRWBgZfj/pOwxsA5JYakJgz/GSGXTRQRuGGvxPeOtn
         Y3PPwSvZpq8xq81fQfg5HPtmGWB3y/PI6aWLoezI3oDswW6RWHH76mysHoYPDK+eUetM
         vAV5nAhKVQzgy2Q/q4vDcfLsr3IIWXa9T5v5oPYVaNDB51HBVzfkeMLD+c596tXq2/M2
         LYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u7P4/QKABVYv9kGSxIgeUk8cWx3fBwdhAx+K77SmETg=;
        b=QnZG/yIMytP6nb7SU/xAdHVduKGvCULTW162D85CPAyPaFDV5LC8Vvo78Xc1QPsWJx
         spDxpAdUAo/euEWbzBVVIXXECALRMp8+BN1HDmOQZ5jfdoTdj0dwxtg5LRAz+tlAfPgH
         o8vurBofdJ8BK/YesNy5C+9uE2krytxIqwDruPr0A4qVx4V4hX2zRTrP81fn6PBnaBq8
         lReQa1dSjgJOebnCV1isTUrqxFKm3QD58f4x11cZ6J9+ZBxQzsSJCkKbmLXuWYK+2dLQ
         sZO6j82F5+ErRFk2D4J96ynO9YILXtjgkleas+/8HV+aZoA5L9+E1cOxurR+NBf3RQbo
         SLhQ==
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
Subject: [PATCH 3.18 42/45] EDAC, octeon: Fix an uninitialized variable warning
Date: Thu, 15 Feb 2018 16:17:33 +0100
Message-Id: <20180215144124.800102494@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480775002082254?=
X-GMAIL-MSGID: =?utf-8?q?1592480775002082254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
