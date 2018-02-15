Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2266PzaG5dV67yzimmaVlpPi1azhwKVGh2+JwcR4ArxpSrGqXBuUU2Opp+0zoUygE2xO7YXc
ARC-Seal: i=1; a=rsa-sha256; t=1518709595; cv=none;
        d=google.com; s=arc-20160816;
        b=us077z7/1hNFtFCb8Qu1u1S9axh8EPkILvQqja7LaiPtRqduxzZlKydZaaiein23ZB
         QkebuMva21ofyowegzUeUAfnRkC7cSHaMKkVgg3BMgQ4AsWWBUkRfgiuGmUKnejSz/Rf
         nz1BRCmsYFu9wpSdm13DJkVrUgVcxzP70HVEFwLr9kl2ZUe6nbbiEQ/UiCwENEy6Vcub
         4I2q+ojZDyxlxYn+ZBn1IXrTxn2EtIo6n906tEE+KzGpG2vfSHfLXM0BmZYsCsXO3HFo
         DTSa+qqUNRLVAp4JYd8MoIW456Ecux0DiB+ccgez3317E6L/GZolT9xONCxiRUEImKsn
         lisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Bm8TCIP8hTsKD6GLYWf9+isdbfvIjJNA5AtJEjIKesE=;
        b=G24GFf6jzVgafrf/9AR9UZl1SvnCKZX12Adja6fhdEOrtWyDjFOfVkVlx+O7/SBd2S
         16nBzJbNBZAzw0Sryi+w13yZVWHqE3FDw1va/0k1LexJh2xMtjfZr+ayLuzq4OYEJuhd
         hEjndU6b2Eaps1VJNN3FEU2pQvfmXW9oDsJzJ0+fBtfMM+JfIT9BJQx8IGeFRMYwY5rx
         NeNxJPqJI6gXOvabj83AaV+bB7dqLveHdJHtRheh/gjsDVHHgf6Zl2H111LRqk3kLtqK
         A/gZnwXSfPrV5FimSMfFW28efSf3I4zTl435Pzc+0IAuK3uXCGXZWtNdvc458QO1SifB
         CM9w==
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
Subject: [PATCH 4.15 174/202] EDAC, octeon: Fix an uninitialized variable warning
Date: Thu, 15 Feb 2018 16:17:54 +0100
Message-Id: <20180215151721.968525779@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480775002082254?=
X-GMAIL-MSGID: =?utf-8?q?1592482433357820852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
