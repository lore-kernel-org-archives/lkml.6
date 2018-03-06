Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsDcSxmw1m3ZG5eGtNTTfCA8Cm4ByeSSAK6AYVzg2QiSaeXAfbyoOixcAkOYkiIPKx+Tgmb
ARC-Seal: i=1; a=rsa-sha256; t=1520296004; cv=none;
        d=google.com; s=arc-20160816;
        b=u6X4SdHsLi4IrQSBLLvFfybLAfYAuABadRKoFPNv4Z2n5ktZ4vQQesdL7b75km68Sq
         Qkr/hmc2u5rAZqsNo7VfKLy4g1stb3UtmyUF3egGn9KXfy6O3J/WGMI5g9Y60axbP2M7
         YZGqPIQPc0qIGGlHRL0XEbpnBnbnpYDdd+H54VXMOkqD0PBue0Kd1iSGvunpxFcPbqJt
         o5PUz5tKNbTkc05gtiF4WUrLTnDhXNh1THtY4TBn9sdkR4EJ5PNfmb9TcGCLBj2bFGcz
         K8dVUAmHUdJNkLFwg0cOpVbRfsGV8jtVyn8eCHB9u7xJK+SQuoCFjr4EFBnSJH/VRr8j
         anWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=vi0VZoGAFhCfrSxBvDY5GR8VcKgzmnREi6IaVyZOzIw=;
        b=GuBAeOh6ZiVJst+0HyToAGS6soB2FLeYU69dnEJgLPiAfwhin1FMO/ZuYdBI13b6nz
         n8OoE64EvnKZrKAr8gG2GafNpSq66Q8X8EkKysR/oYbnBrikpiD+FuCOdXYO2OldIZer
         X6dCKTi9TT9s6liTbrN6JpirxHBh+5Aj4FQw+ndwqTHZ58jGce6O5868wzlRrCUHPdOT
         U6o8BF9cRBWY5H2VX54qp7+qa+vr2FlR+fXbUH+aObPgJGppZu+chZMtVDiSk1aPVmH0
         UibonN3IuqDSUc+L7EiONGi2vNVmfNfZo7h7SIh3OgrbapLoaAFPfAilipF1FTIr88U6
         0mAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=RQRVqwyf;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=RQRVqwyf;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 48/65] kaiser: fix unlikely error in alloc_ldt_struct()
Date: Mon,  5 Mar 2018 19:25:21 -0500
Message-Id: <20180306002538.1761-49-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145902909786982?=
X-GMAIL-MSGID: =?utf-8?q?1594145902909786982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

An error from kaiser_add_mapping() here is not at all likely, but
Eric Biggers rightly points out that __free_ldt_struct() relies on
new_ldt->size being initialized: move that up.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 500943e57db8d3e298e98f595f835c5b613e843b)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/ldt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index c388247e0353..5797d437710d 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -78,11 +78,11 @@ static struct ldt_struct *alloc_ldt_struct(int size)
 
 	ret = kaiser_add_mapping((unsigned long)new_ldt->entries, alloc_size,
 				 __PAGE_KERNEL);
+	new_ldt->size = size;
 	if (ret) {
 		__free_ldt_struct(new_ldt);
 		return NULL;
 	}
-	new_ldt->size = size;
 	return new_ldt;
 }
 
-- 
2.16.2
