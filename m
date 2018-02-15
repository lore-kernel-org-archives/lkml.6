Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224pAEGWP2QdlJKitMw/ngIRX//9qqi3yFi0ERkfyK5u8wMZ3VQ18YoPpGOdwyMMOJd/OOFM
ARC-Seal: i=1; a=rsa-sha256; t=1518709040; cv=none;
        d=google.com; s=arc-20160816;
        b=Um7+ZFAHliG4fVBR6TL79+IXaIz+di6cK/O1yQToQcSpG2xe1GPbeFsQuq/DIIRQTY
         V7x42JioT+cy+9UpfzSkkiJu/NQqstf83h4h5MBza6LFBMLdTAhSxop5PfY4J4DGEw00
         SGOs4sSKw93P6LFXvlzNSk7McZM2gmOfo7rU2ah8G4Peqg5Bnhdg3dLKLA+W7HLFn8uR
         uteSaGHgeUD4SPFjKMqUwwIITkq2AV4QqJ4qo+LGFmliMLvD+1SaPz3VFyQvDOfNIej6
         T3DraQand4fYpYjlUKqND4S7D6GkY5KVWQhMYP4VWqdtS1fgXwVZlRPo/UrNpcpJ7PBh
         RPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dYbrupOe1kgEzNw9YG7qOn2dYSJ6atdtzqK5B6JPhF4=;
        b=scnnGDOunEelNqCviCOlAf4P+/LGadbgc+7AkSBwc0oSW0uID3Obcy1wUip/YkWqSB
         JYcK3ImSFHiKgGJH6dIKfbO1V46DZLy431zU1bHdLJ/Jvdlr6NLPYNPiQ8bmudLaus1A
         ZoKMG0KOu1xdiaKO+DI94R/dpQfEhTj8M15/f/hYvdgpGYOXxJHWQIyYTmi8gfcRxsTQ
         VbaLZEQokpb+SjG+w1r1x2Zw60C9MCSsSqZ5iZ+TYyq7gdPIgHcuhGWgIC5eli1vY2oR
         y/N5A0/dcJI1tkwZ1DsOc5d018/D5IUuaTI9LK8CpDE7kaqGmCM3quaOjRZFpBPsDi6L
         5Zww==
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
Subject: [PATCH 4.14 170/195] EDAC, octeon: Fix an uninitialized variable warning
Date: Thu, 15 Feb 2018 16:17:41 +0100
Message-Id: <20180215151714.523018323@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480775002082254?=
X-GMAIL-MSGID: =?utf-8?q?1592481850777845587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -78,6 +78,7 @@ static void octeon_lmc_edac_poll_o2(stru
 	if (!pvt->inject)
 		int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
 	else {
+		int_reg.u64 = 0;
 		if (pvt->error_type == 1)
 			int_reg.s.sec_err = 1;
 		if (pvt->error_type == 2)
