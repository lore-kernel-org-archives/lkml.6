Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3049C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E3821486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Fp4Pb7s2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E3821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeIXTLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:11:16 -0400
Received: from mail-co1nam03on0055.outbound.protection.outlook.com ([104.47.40.55]:21076
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbeIXTLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIBv+ba+m4Ydg5j2c3y3Phf0+yM5iKKdW60vzkzNaf0=;
 b=Fp4Pb7s2WZ+wSytGHjAVK7RcFdAbC8o9zRPEPXMo86JPEZ1q9VbRyHjraquvMpFS8ovpYs0yM9M50F8bf6sIUU6Se1AbDEGHPlYg/cafSDX9MhTCkaISXzOmsgL1YVAFyPG1c1+UZCC4SVoI86eaikwHhK3dhJGpOm64266Wd5k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (95.104.175.50) by
 BYAPR07MB4375.namprd07.prod.outlook.com (2603:10b6:a02:c0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 24 Sep 2018 13:09:04 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH] mm: fix COW faults after mlock()
Date:   Mon, 24 Sep 2018 16:08:52 +0300
Message-Id: <20180924130852.12996-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.104.175.50]
X-ClientProxiedBy: HE1PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:7:16::18) To BYAPR07MB4375.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d0a902-f393-4481-0a64-08d6221ee7e4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4375;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;3:0yRPu1S1dDOKrvecBuJX8PowHbshfTnZRjDnvBlqg7Fr20cUxcaRbljw/hTcVRVQRQNPN3C1zjT1XqfYLGyRTSRe14NfgtPP7mH8WaaCC46PxvQrIX0JHnTy9GaG9mhc+XX587WJR2gfPLhjN88JHgSlcHfHcK9nlXJd/8LvQK090l1HjMRzlx/I3xZj960EvFXOkC4H44X0d9leMEx8RQFp3IvYN71BqF7wf4ErY5lbOSYYIKscBZpJGxRxQRrc;25:tQewrCNmvpQgMyevdsWw7Mx3xW2f5M8q2SNLv6A1chnNySbiqOlvs4IFIQ8sZaOmC4+LvrxnJtrefcpzgdguBlZ8IO6e3tsPHTZYP4YiOyjbxEHTa7yFTssNH35bcENcudPXPLt0nhyg78amzq6oDIO3+MOZORKscX+4mXHsFY34sMJKFwQuhagjRWs+Ectz75aDgrrPswV6/JerTRGc9DrxzPDAgLRii+Sr1Cp6R2hBWwmI3PPn55i/XSIglN/QgNjZrkB5Xm9gBixpYCVuw62KnkeGC/x9yriLe3aATwgGBZ6s4FCIng/pmRk1gMLCo9SkjJPrtf9/6Y8ViW7NIw==;31:7r+zj20zQglkC6rJZ4wKiw57J+5/dLKvPZjbCeRVvPg+2S1AOoHXq1eu0H+zYNvhYwJISRyHZSoqCuviGyhfjQNPeR1vdDaAUMajDHKOvFnWo/HmT0GkKOgq4iPuI9o2GIMTFEn18H2Wa7GRIVu3s+ITFgKnhBlS7aycQ68aV0hPaba9bZESDLAcjpa27aRysaLhsuBkUsdLj+6DcIAx8cljLzW840X4kSzO7/D7Dt4=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4375:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;20:asnogc1/g8n8dTsFV1OllQmAbxfJw8v9VEyYggPyJNAIU9xjzDnhm+w4sdv83tpOgSRJjG1/Lq1wdPZ6gZBkDtDbaek1+ANbX1fkh82BWGFXk1d7KDc1H1xU5jcQ2L6sfwF0m8q4fXCxUmdyYp0BRqEzUzuAoPZo6TrtT1kliO5RTKUTbVyeeXXizwNAHQn0HEKbMYrJAdgWjrXTf9WOUS1rk7/+E/TVcvje3jq52bh41r2uD7WSBVqdxlPyBX0J6M6P4JbzXJzUfGPgAk1VujdMIfChn7VNNx8E5LkDLnviqD6t+YulB0QFhIKLtUDKx4eZ0Q4yxaGODQHybSSdzRPcvC1AqNcqPB4Yw3kmD/Cp4Nl6rs6iXhurry7CluhNc2HLXZseaxp7+9iZhimXEADU3TtpUP4Xhiu5rkzeDXXjwyAElq0sVxpK11ji35csrkF4Myu91q0NNvbjRIvC/QpA9W7hPXI5UNtgDx51Gu/tKbxXYfRO6x0tP4q/GMknBP6HFJgJ4B8iTTCTe5IE21tXPVzpghCl0kqUeSKo3b3t4noI7aLEvn35kyDLdAEfZjASJTxyxjoxYNZYH9emGLm7reFtI5Od+Hb7wUatXl8=;4:NetUZPFJkwC2AGbv/k7MkViktumX2dBuQNMUMsz2uU51+RL7aQT4tayd3asV2iF32b5eEmaPnHDkHmzZhtciqU5ed93xJZnLrw2WrOYwUVCMSsf1MzCKJta9ZicOQ19szO2ytWPkVxCObw4wO0xLs3O4vDI1B9edsHU6BAGZicoOUfDH29kfHK9nxtI7iJdIXjwCK4k8a+5BILDycRMF+NMLnQXSIfAO4M3eTry/dUwy1509A4THQoyo36SxPGsgulxUibX9LT3VwfJCHIqfUPsO1jkWgAVKcZ3kMMr+hBXCfni5UCSaPdVufdE8wzTZ
X-Microsoft-Antispam-PRVS: <BYAPR07MB4375342B6CF3EAFED2F5A981E3170@BYAPR07MB4375.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(3002001)(10201501046)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:BYAPR07MB4375;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4375;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(6496006)(6116002)(51416003)(52116002)(8676002)(110136005)(4326008)(316002)(48376002)(16586007)(1076002)(50466002)(5660300001)(81156014)(81166006)(8936002)(39060400002)(107886003)(2906002)(68736007)(6666003)(3846002)(50226002)(305945005)(7736002)(76506005)(26005)(1857600001)(478600001)(186003)(16526019)(53936002)(97736004)(476003)(486006)(2616005)(47776003)(66066001)(42882007)(105586002)(106356001)(386003)(14444005)(7416002)(6486002)(25786009)(72206003)(36756003)(956004)(921003)(781001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4375;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4375;23:x3MreOLFrRumts4Iu8KLuuT+3/oDJ2zINGuksJABt?=
 =?us-ascii?Q?hYGhKJBGK/ls6uxOelbnZcQb+M8Ezb/Jj+AurhLnGoLwIGNxnbbZO16MqTBW?=
 =?us-ascii?Q?2k+IVAynq+Ra7VneBDYhb95G4rM0Bv0/exJFzvbAhqKfufZJiK/V4a1ea8L7?=
 =?us-ascii?Q?iSOylXCXIqUYKFw0WmMyRfNsxJKHjefwAohYG3SV5XS3S/VK53R0SnwkA+hW?=
 =?us-ascii?Q?35lrahwrlxDiab2zUO/nuqpEj6+D3UnDtiHVZUNksbGbAiMqebxtH1PYCi7a?=
 =?us-ascii?Q?TxT6JHqeFfsR/UcWZe8bmlUEmTMeJE0b4izZWUCjInafjj4zUU5liSSF5ChL?=
 =?us-ascii?Q?l89cWifX5Vu6fDByjAV81fq9a9VPVcatlr2Ihi+STRqWilzpmHN6qwq1wBu4?=
 =?us-ascii?Q?X9+p1Ts+BSWhJnA+J8+/BnDjAhAo0PdRE7OjpaHJx7119vQBwpUOgBtuQvyH?=
 =?us-ascii?Q?NJ/o4nWh6JrQbxuCl+vNfGKRUI45kJCUFVM8lW/nI5mMyV0z7lNFOF5XJGr+?=
 =?us-ascii?Q?+dYMHsQOiFjIjDFi3+Q1E9G5sU75v+f975zWh/6eYatr0pX6jnr8Pcinw7yO?=
 =?us-ascii?Q?+WvkwxGjNkHHDc0mw1q3qQmwYfQ+YqOtjKmC4RhqTxP/Cbm8nnbJnNpGJGO+?=
 =?us-ascii?Q?Ai0QlaGs2zmU21FDaCKZzBh2Svb+wrynuuPg/yUVn01WinzAwzo7Zkg+RV7t?=
 =?us-ascii?Q?M8heJq8krbSj92B+aKklfLriPki7hFntLZGVaiILo6Wdxv8R1lDjC2XOyWj7?=
 =?us-ascii?Q?lBeHdXHc59LpMlPgnxLTBwm9FrKbePszHhTLA6mgG92PJco3NdrExNgzn80+?=
 =?us-ascii?Q?ha0IU7lQA6XlMLbfj6XrHD4ZLf0wWg8f8R8aRLOxpEr6TMjafbRlVv92Jme0?=
 =?us-ascii?Q?Vs8ogSIysslNW0slvryWshQSPW6WKySOXWE+A/tM5dOXR9JBz6S2ZjicpFUb?=
 =?us-ascii?Q?XeYhFtw7ub6kJ1JPZIYvai2yUoQSFARMa1oebudpFQCa8HgBZzoAbq7rFQjZ?=
 =?us-ascii?Q?6hgoc0o0Q7oYDUvzxoYbt8tKMGHBOELTf4KMTs6j5i+K9Vrop4vCRQEOh3tD?=
 =?us-ascii?Q?/xsCu+PuOA7pVo2h9nGb0Nl2aNLYdrOy6QSXeCbenw7Ma2zoHIb/UIeYAf8L?=
 =?us-ascii?Q?7nVYyZMD3ItxNBIRXVbaQ4y4ZicJMz7ICSqHJL10gl5rDBs0SQQgrMlgg76F?=
 =?us-ascii?Q?CMxyRied4Sg6UBi/uUHx+LPPwcieXEHFEX8pvCXPRYJzN0S/K/UCQ771gQkp?=
 =?us-ascii?Q?aJr0J3wgQYxjnbBxpH0wMMOLbuRH7lerlxcZQFjlOT/bTPeUfLaTbQ3hP/JC?=
 =?us-ascii?Q?9EwWft21YiRAH053+1OJ0UTxgqClgU7uaWHXPKmviMc?=
X-Microsoft-Antispam-Message-Info: /MNeHZsmqAiSXoAC2CsNi6k18xR7gsAEKzyiHJgv0Cs+bwFU4MvIb2xCWQmYjsUwW7B3o/vP1l/v/8X/ciCfcL8Hl/nkurzNZJBQZAdKLaOGGdzntXwm+lyWrFhEpaLYVl0GvvJFyfkv9MvTgQYDO2xxPrxtdc8forY82BBtOMau4hxsK7R01KocOdFqvOlDwn8gptDq7PSD9NoJt1aHtcmIQQEROUbq3tYOogDshsJfVwCxKbdnsGyIzm+qcGlgDqO241A6ZWikmIdJ/KQ5RjXpy0SgwiFv+UBU0uGSNtPdI9C1Jm55UqRpTUqZHYjnotofaD1uv/EAKx+3v9HYhiVJ8amwRv52YHRaIAyfuxI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;6:3DdXJr7H8IQr/H7yMaK/6luDFQMRtd0loy1jkrMDL9a29THvkZht6x0BBmt/yXt8t2LsqbU5PIfv0akkGpWBhRWYpTgWNaODtZUE77DBZuwuKsv+8zd3+V4xdyRVVWlvn4nR8EgCXsWwz3RryZ+KdHJnPE7BgAW2qsNwiQGZzRvNQB4dPW5kv4uRnTqd47KVfG7IsrLBR42/UemHk/I7g9OfaN7TlwJWqyE8jg7cF1fkd8TTHvqBqU4UlObsNH7C0OfwOB0bGENWx0FQ42X67oHrIhv+Irp5S7XFCKjbRaOsrtv9yei6eHR1yTViHEq8LtMGyS0Dkxy/OiKny4FaPzkVEPMF70mpFCbZkIABLGTqZ2jNyYwovlnTN6XTNEwsXIuN9oLgR3SvTWGojesw3YsxbwDLr9a7VUYhZ4vNeDWm1dygQtyVJPXF1yT2dfz5JKsLhn/RF9F3akN2BOglPg==;5:YTpqwx4LQaz/RIlkI9S+GDgf5NGDO8rf7vqy246y6my4ju4WkaFZ6EyWsjPjYd5m/EKZ59igF9CDqZLVBv3J2Qi+r1e9hMTN6nMxDO73U6B3mW6xmBh843PLNVlHPEtK+F8XytrEllW9YTXW9r54b7Povd7ohAWKSlonul5DxF0=;7:CZBReEfDKjlezxHsu0lCVgcDuqxd7iVS7f4B+MGrbKW459wkmhCsNuxkh+mx4bN5SF7pUNb2lNq29Vh73XQcBqeATqow1npF4rYgzLUFdkFcvDPcKEOgy1LWItMwrZhtEXZ/KAmG4/mT1WQKhSaZyFZ92ov3UvDk4/dWQ1vpcI+J9RotuwkRtCIqRgYAKZrcwV5WpxSRf6DuG9SM1Bc+stzUTnzl38539mKQvl5zZeIV22K30uOdUtdx0E76ZQPY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 13:09:04.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d0a902-f393-4481-0a64-08d6221ee7e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After mlock() on newly mmap()ed shared memory I observe page faults.

The problem is that populate_vma_page_range() doesn't set FOLL_WRITE
flag for writable shared memory in mlock() path, arguing that like:
/*
 * We want to touch writable mappings with a write fault in order
 * to break COW, except for shared mappings because these don't COW
 * and we would not want to dirty them for nothing.
 */

But they are actually COWed. The most straightforward way to avoid it
is to set FOLL_WRITE flag for shared mappings as well as for private ones.

This is the partial revert of commit 5ecfda041e4b4 ("mlock: avoid
dirtying pages and triggering writeback"). So it re-enables dirtying.

The fix works for me (arm64, kernel v4.19-rc4 and v4.9), but after digging
into the code I still don't understand why we need to do copy-on-write on
shared memory. If comment above was correct when 5ecfda041e4b4 became
upstreamed (2011), shared mappings were not COWed back in 2011, but are
COWed now. If so, this is another issue to be fixed.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 mm/gup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1abc8b4afff6..1899e8bac06b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1202,10 +1202,9 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 		gup_flags &= ~FOLL_POPULATE;
 	/*
 	 * We want to touch writable mappings with a write fault in order
-	 * to break COW, except for shared mappings because these don't COW
-	 * and we would not want to dirty them for nothing.
+	 * to break COW.
 	 */
-	if ((vma->vm_flags & (VM_WRITE | VM_SHARED)) == VM_WRITE)
+	if (vma->vm_flags & VM_WRITE)
 		gup_flags |= FOLL_WRITE;
 
 	/*
-- 
2.17.1

