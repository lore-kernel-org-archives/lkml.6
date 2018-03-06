Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuCjbg2FpFSE3cYD7Pr3rUtNJsWKq4ZHrMpyUJG7O3HBCet6f6J/Is3ldnjYKNl8FeUIW6m
ARC-Seal: i=1; a=rsa-sha256; t=1520295991; cv=none;
        d=google.com; s=arc-20160816;
        b=b9by92rc+ayGVWH8AjT/5wSQSR68WEV9GJH8snFTO8QaMTfWsMjvxU6YXP1pCUGvMa
         034KmyTOUuKhOU/tDsBOGBtXKlyFBexUiUKCDQWJ/Bu8+FOQLiYT/ougklUN3/iOW2PI
         BJZfAWu2hc6aqcIFKkWSBxW6UTZkP9rZr5KB1R4Od4+boPutno2A5MZMDEBgfqJ0AILu
         9k2oUzik9HFF0UQn1eq8X/8vvJX2dNMpezzE8Oba5Ntc6/+e7pGWrvk6ZXQfM8bkBsFy
         xgeup8nYPitdGg0SqTO0y1fcWCinAH1a/SXMDkeaFRbJ/F1o6xKJIDW9MFpYsE2pR8Mv
         ADPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=2O1xfmJwhi/+CQ7ENmIpGf9ibOdS52oSJ4RPYQeZhQo=;
        b=rG4nEQh3jXhlWaA66ziNgRxnrfydXIg8nlmXWy1KNgrQhEkrcWwp7UVbC4FxvElPjZ
         VoOTCWQbxGtsAKB35lZ7VFtjWUYYjN6FOnz4M45WvaCsP9eDid8Te5i8PP2GGO/XWwwa
         UK18LxHhgRiSFnLe9gAjjcp6J3oQvh0ShT/2TyXdS0PyCsd6rcwTxakEjnPNq0/GRXUM
         g4I6S8ngBmF90p7agY++ElMEhOFmf95B4WRBv+Okhki3HADCYaWkwTFbzuf8MCkmxrKq
         oAlqx+gg0OvfZ2fIqxpVatIWg1CqOe3O8r1WQIznWqWpqgV/kZiwObmjZGiQjgrmdYpA
         /qAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sqTQMKlZ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sqTQMKlZ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 34/65] kaiser: ENOMEM if kaiser_pagetable_walk() NULL
Date: Mon,  5 Mar 2018 19:25:07 -0500
Message-Id: <20180306002538.1761-35-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=835
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145888946905946?=
X-GMAIL-MSGID: =?utf-8?q?1594145888946905946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

kaiser_add_user_map() took no notice when kaiser_pagetable_walk() failed.
And avoid its might_sleep() when atomic (though atomic at present unused).

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 407c3ff6a24c7cb418b77a124d17e282f9622037)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/mm/kaiser.c
---
 arch/x86/mm/kaiser.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index df7f6591d5aa..058d0886086b 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -99,11 +99,11 @@ static pte_t *kaiser_pagetable_walk(unsigned long address, bool is_atomic)
 	pgd_t *pgd = native_get_shadow_pgd(pgd_offset_k(address));
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 
-	might_sleep();
 	if (is_atomic) {
 		gfp &= ~GFP_KERNEL;
 		gfp |= __GFP_HIGH;
-	}
+	} else
+		might_sleep();
 
 	if (pgd_none(*pgd)) {
 		WARN_ONCE(1, "All shadow pgds should have been populated");
@@ -160,13 +160,17 @@ int kaiser_add_user_map(const void *__start_addr, unsigned long size,
 	unsigned long end_addr = PAGE_ALIGN(start_addr + size);
 	unsigned long target_address;
 
-	for (;address < end_addr; address += PAGE_SIZE) {
+	for (; address < end_addr; address += PAGE_SIZE) {
 		target_address = get_pa_from_mapping(address);
 		if (target_address == -1) {
 			ret = -EIO;
 			break;
 		}
 		pte = kaiser_pagetable_walk(address, false);
+		if (!pte) {
+			ret = -ENOMEM;
+			break;
+		}
 		if (pte_none(*pte)) {
 			set_pte(pte, __pte(flags | target_address));
 		} else {
-- 
2.16.2
