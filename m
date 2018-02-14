Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x226GDIR8+T9ITvoaKrfvRJHF1mTEnrKGm59VAKWhPxJKUGEztWz13QntOUGDD1J3agsxYjZs
ARC-Seal: i=1; a=rsa-sha256; t=1518592480; cv=none;
        d=google.com; s=arc-20160816;
        b=A6L0l3P7Ov9hC7GCFXxvG6oDUeDkhmkICueQXMmyh/DYA1EuqZ/+Opa8gLG/JlZeDE
         hHrkKLiWIkJXc23uNu3u8SxI+f+aiMMziPvD2Cn6QzTgL4DFLvKfNTNDXiypwo9DfBXy
         fydS581wmPhia/JeR91mqI4RpyS4/yr3OV4DcWGqzbL/iBl8KzWrfx1XAug6GLDv6YxJ
         DF7AcyaDarNfddsbQQWVp1EKOhyMjOWHmF9lCAsLk0ZsSR4ZmUnqyB19BRPs6XmWdfc1
         ch3ZAQMgogucCajm2AOs2BIzcDP+BEcLFrWdv9dAyQvhDf8za6EztSVirvIypVsQ4kD1
         +tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=C61Rs8u0I7KRkEh9FXF/HjmBoUm2buV3kSk8kpx9IVY=;
        b=cROwSNbDP9oP0Rvq89Ugvn0IUcrI5PlMZGltsCoQmwTefjxDF00RGjbkhChCghZI2O
         rJyQ9wWAerHI5YGuWzMsAjM4fFDLNgwHZHrZ2LpmRqWAaTAkyamEPYKu41UGIRTJ1GMf
         qMCv+27eO69eli20+fSAw3DSGnLfHWfc2rQfKtGq6J+PXyVNtc51YpcB+KX6qvnJpTpM
         FcYWDdMjJqIE2ghkslUGyAVSZkIXc52mz0U656uTkaSoNOHFo4JssBR3lgbB4daFVKaV
         LgrL8VmMsJE8j47DwUDPilERCxCT5tbgvXValgXUUCbOGjqnO+2NTEOd5CN2K9akmf/L
         PnYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=peCeNtwi;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=peCeNtwi;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 14 Feb 2018 10:14:17 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ingo Molnar <mingo@redhat.com>, KarimAllah Ahmed <karahmed@amazon.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/spectre: fix an error message
Message-ID: <20180214071416.GA26677@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140085
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592359628754640421?=
X-GMAIL-MSGID: =?utf-8?q?1592359628754640421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If i == ARRAY_SIZE(mitigation_options) then we accidentally print
garbage from one space beyond the end of the mitigation_options[] array.

Fixes: 9005c6834c0f ("x86/spectre: Simplify spectre_v2 command line parsing")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index debcdda88560..acee4ebec04f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -174,7 +174,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
