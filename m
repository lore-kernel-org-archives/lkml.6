Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoEqhVcGpMglFPc9wp5L5ACSe72ZGtfDvca4oVGUvD+dE9OETpUgXjS7CevDCXrQExjc0c
ARC-Seal: i=1; a=rsa-sha256; t=1520451804; cv=none;
        d=google.com; s=arc-20160816;
        b=U73CHsSCunU7ZC5eb9ys4RJ/CkgioUC4FKz0+GVUCDbetxuFBhiNLzagOd/t5RB8w9
         xvP4JvF3oXgPRz0IdQ/9LmJAU5eMUmwFf3bpcl+Czb/m+zStHfkECYSVpOHKvyY0++ZA
         x2lCUBf5/V8JZVvLnRMTY9paa+Yj4b0MGoQR16axRv8JqXznhoIMccPf/l8FlVhwdX70
         GQgv2x8aqvmvci4M2eM3psn/zNKqlWNndu5ppV61hIs1sLpWy5Si/Ag4/Kddz25Q4ZfK
         ynAICm9rrQkSHWxqZRYXtu8Ou1N+Ba3JeZeJDKRlOTVUSnZc1Y8FSkOeaSqL0ozCb06q
         qloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TR3vbmIfRFS0WQodX+PQGNrmnvzRGLgvVbWejijQ79o=;
        b=iU50y3vye70Eix6NSYYwDm0hK2K50R2ApuEotH8U29ywZT5ZB6+NrRxTJ6TeddoaY9
         3Nx1r356vZ4GzrEuXsrntQIHfqNJ2v0Y56iKtyAXSKoCaA6NYZPcrgCJk4GQ8dg3512r
         UgaozEtGY16YMGttvajK+0Xi5VR28VEHBxwYCDto4BQ8uZM3D121FZe29oSm0cPQivXB
         P3wiuBlhvk67ruF9yXq6UtkzDbUqV+nB2lnECE/dSW+YrO5sFFf2noSGEU86RfA2k/fQ
         G5QxOXmapKazqSn86FCh02K4RknlOQKYmPdxaQwfw7pW0wGBvNOEoB27pFao49UZWeNh
         z3aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Anna Karbownik <anna.karbownik@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	jim.m.snow@intel.com,
	krzysztof.paliswiat@intel.com,
	lukasz.odzioba@intel.com,
	qiuxu.zhuo@intel.com,
	linux-edac <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.15 100/122] EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL
Date: Wed,  7 Mar 2018 11:38:32 -0800
Message-Id: <20180307191743.848319164@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309271673449358?=
X-GMAIL-MSGID: =?utf-8?q?1594309271673449358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna Karbownik <anna.karbownik@intel.com>

commit bf8486709ac7fad99e4040dea73fe466c57a4ae1 upstream.

Commit

  3286d3eb906c ("EDAC, sb_edac: Drop NUM_CHANNELS from 8 back to 4")

decreased NUM_CHANNELS from 8 to 4, but this is not enough for Knights
Landing which supports up to 6 channels.

This caused out-of-bounds writes to pvt->mirror_mode and pvt->tolm
variables which don't pay critical role on KNL code path, so the memory
corruption wasn't causing any visible driver failures.

The easiest way of fixing it is to change NUM_CHANNELS to 6. Do that.

An alternative solution would be to restructure the KNL part of the
driver to 2MC/3channel representation.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anna Karbownik <anna.karbownik@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: jim.m.snow@intel.com
Cc: krzysztof.paliswiat@intel.com
Cc: lukasz.odzioba@intel.com
Cc: qiuxu.zhuo@intel.com
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Fixes: 3286d3eb906c ("EDAC, sb_edac: Drop NUM_CHANNELS from 8 back to 4")
Link: http://lkml.kernel.org/r/1519312693-4789-1-git-send-email-anna.karbownik@intel.com
[ Massage commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/sb_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -279,7 +279,7 @@ static const u32 correrrthrsld[] = {
  * sbridge structs
  */
 
-#define NUM_CHANNELS		4	/* Max channels per MC */
+#define NUM_CHANNELS		6	/* Max channels per MC */
 #define MAX_DIMMS		3	/* Max DIMMS per channel */
 #define KNL_MAX_CHAS		38	/* KNL max num. of Cache Home Agents */
 #define KNL_MAX_CHANNELS	6	/* KNL max num. of PCI channels */
