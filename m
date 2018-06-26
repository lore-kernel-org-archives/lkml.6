Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F867C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E3D267F0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ygd7D6sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E3D267F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeFZKIL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:08:11 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:60561
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932189AbeFZKIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgAypS98NkGaZ/ktA7fRlFYyUx8ymCtl4lKmozifxPc=;
 b=Ygd7D6sd28yKd7UjgyFq8rFoiQXJ3Hqbb/r/Y288Zao0PKIoVn0nsxlVta1DgRcPMxxTVtpmmXQbNUWjkhEcohrwUDWMIU19O2bngGXaywZmtlqxuu8P+fNeWwKUDCd/1KXnBRgQEbmQHodaAWu3GndBZFF634CQ1gT2JhVyNyQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Antonio.NinoDiaz@arm.com; 
Received: from [10.1.219.16] (217.140.96.140) by
 DB6PR0801MB1943.eurprd08.prod.outlook.com (2603:10a6:4:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 26 Jun 2018 10:08:06 +0000
From:   Antonio Nino Diaz <antonio.ninodiaz@arm.com>
Subject: [PATCH] get_maintainer: Allow usage outside of kernel tree
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <04452ac6-1575-f612-72c6-6ea88e70a9d5@arm.com>
Date:   Tue, 26 Jun 2018 11:07:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: CWLP265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::15) To DB6PR0801MB1943.eurprd08.prod.outlook.com
 (2603:10a6:4:75::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba2c6fe8-c219-4229-039d-08d5db4cb698
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1943;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1943;3:JqUnWDr7eyFNRH6hqlkWp8CfIOZ5Bp4N6ApLVUF5JP9XyqCorR1XCMWRLf7TzHjiuGI9PbNPoxILfl6aBGM+LZVQ/Z9KFDM53T/zoLOwOJJbNURgS9dFaXU03+LfjyNhwv4mCpWTJa4f2HrKbERiYDpLmMF3AIOWf2Z0abLXJdaBzbNUaKqt2NnUfNYWqzCmB1g6ymPdtjcPidWGpCIOe6+1KtOxHHZYGG9LY7eZ3C49+2DmmOqYmtfVZa7Vy17y;25:JN0Zmdj5y3lQXXa20CxDnMs9kkO6aSUMhSD1cyMgprRyzhfGV/tRbjtGgsRTnFhvdUPWegYV5x98mnUBxR7/mN90BUK2tLQzYaniMtCRbC7+lL7rKdZmA+BSB8crNMtpfk/+yP1em50FLxTgeGtVBSIQUQ1eKC5Pk32JKOa8RKHy4UKupHKy6mtE1X6I2auCwWJpKcgyad3AEQaDHZs07tBCcWlUfDSwdGacIaf8H3OCrbdTRmk44/AFZ7ky/5V7XgdHrSsX8Pmb7JQ88Z1QvAD9UYwTVftT/WvnWKkhwqtVDZKd+BZxjYXFPIu+5npnkow3R38giZx/4CCag3Qs5A==;31:zasUnAbDgoL8nDSysWf2QWEHmuU9naCJb5esExxGjyaMrirp/GEFX8181iFHtBvFwyHlsHXJAgCkoVLI79DLkZ1eW+2H5kKsGhcako9ef5G2PWXs8oZABmRgrWJbuRON1Gz2LT2WT3GWPN6Xo2c262TmdUTBx+9kwvzdVdFl2im681fFs6vkyVrv+l3oKAY88KWqc0c26PXYRXwTDYGHGriLfTXggXHjGVA3T+jcSSo=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1943:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1943;20:WyAMN8rGjO0CLbIK/6ESefLLXDdPVesTkPt8rYU4/uuWJtSamCjHtd6VGRZ7tD3aX0Cz7zKg2rl1540abxjOeaZLakqvZ2IAp2lvZIJQn1aWAqmMyvdMXGuEGP99cKkjM93I+yy2A7Y8+Dv5RBC8Lp8MBcXeR3ONccxlBkAZb7rJ+1AS+Fedbu52A/kb+ExuqpAwJZbTxVEqU42UMocLFwOpFE4BU7CK3AynoK7prwGAWNPu6oqLrwnX1S6kL4M0x1KnyA2/oyGCgvjWZS/SMgH8IQbONbxsZRzoXzlE7srkAGZhjG38FLmbSLG2EldkxCd8LPPepQOFbsr6xPzg9TVQrJqjq5RO0GwKwq3gEO9pJ4mwBRZgGO/GPf8/jiu1vzZXKAQwNzgpYLZWDWdPMlYgwzEbMulgcaLukM57kyYlDiwAUgc5PdxsEtgMtGalZhIEjWQa0eJlksisI8x6DDMOkpjv00v2tw1tuhpfMiW12aNu0TxHv7hpx1OUnFQX;4:G8mhoVLJ+mxGq4fg7EJXJ0xiE+5/mu5CyJFCKF8N/6ppr/fXMIuHxeeBtfHAt3hq9SZW6komvnG5aEXJiJhXvXxXMerqVzBZqnfGt+Dq8bn4sIiYp1dn00n7GryB96/OW4M/uAaniRL0Y0KwyIY5mCxzBhaUlJjgFsleCmVtTMezEXUpLwg495brF19uDr/qh0r6OmIuzJokLemR4GxFaCA+6jGbCGBKbhHo56bamjCrPxdYrkNkJjBDd6pMONQibvHhtAlOXXuTw9hmf2QvXs/qOr3mtepcs0PDE5uAbFbWWXNaN+RiGxENqa67lA7HTUxz9XV7MV+83PbVADBdJbVnE9fOXMz6VHQF8OgfDaCCSlsX2n3x4qubCeswnu2k
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1943A51C52ED051353099D9F89490@DB6PR0801MB1943.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(223705240517415)(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1943;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1943;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(40434004)(64126003)(36756003)(97736004)(386003)(58126008)(1857600001)(6486002)(5660300001)(478600001)(72206003)(68736007)(65956001)(66066001)(8676002)(476003)(77096007)(47776003)(65806001)(6916009)(25786009)(26005)(31696002)(65826007)(7736002)(86362001)(105586002)(16526019)(106356001)(956004)(6116002)(23746002)(486006)(2616005)(6666003)(305945005)(8936002)(2906002)(81156014)(81166006)(8746002)(50466002)(316002)(5024004)(14444005)(52116002)(31686004)(3846002)(16576012)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1943;H:[10.1.219.16];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DB6PR0801MB1943;23:YC326ECgu3B4Fz/dKu2qFffCFr86C7aTQmF?=
 =?Windows-1252?Q?1AdvKApk69VWfvmmWTcf4IeXpIvYOnogVCH6PUrUprFRHADyh+T+ej7Z?=
 =?Windows-1252?Q?fX6m/0f09sHzehmAfBfv2Q30fbcXzwRvbmhOeKHNtHVDmFWw2fg6M/RN?=
 =?Windows-1252?Q?+Og1I5o1hgvUwlUEG+pkdFXThky7dPFOHi5mi2eo9wQ0DK8K/8fw+Pld?=
 =?Windows-1252?Q?QBjwjrDYlCPtymunK8jkXjZnlw873w9gCA9TfbTENApwkxO7PVA/wi5/?=
 =?Windows-1252?Q?KWrj0DN0FpH59IUjlHdUXAz3sLbvkb28JEcmRDwmJPuU+oOGgxrA41+1?=
 =?Windows-1252?Q?gzokszpWEIOvKNcIiUsMYR6/7WsWwpyV961cKZvzgijL7jSO9xuRc+9w?=
 =?Windows-1252?Q?zkEKdt945D3GCavF69MD6LVGM7iBSR0PAQUmlwT8KrQ4tiF1oWU+a2zo?=
 =?Windows-1252?Q?Wxl3P3QMRZdt8hzFqwKVxDQelpfvzW/eE15EMzlMWnNqeVri0P1/fKYg?=
 =?Windows-1252?Q?GsiIq764H1cA4LJLfw83j6RM4gR44sB8bMcE/F+Jtjus2xcaEgU3qq/u?=
 =?Windows-1252?Q?paNkfIcWc4eRsEs1ozNLqz/76B5mKNtK+wPjZCeOKPZdDLJcFqXkpS1e?=
 =?Windows-1252?Q?fZu5aQiFYbNMdxG9HFeiI+8MOmC9oN5DEYUGMPkGc833PSS70sAzZjmB?=
 =?Windows-1252?Q?0IuVaSHFE67G4iXiL76otlLa3hkIIWNoIVhtnTlfkW98jIvY8ExauLQE?=
 =?Windows-1252?Q?+8ZIkPRf2DYxgdtA1i4K9/hDsg+z9KZ3oy3unk2bOdpk/RL/KsoKOOdq?=
 =?Windows-1252?Q?feNEBMkWSMe4msH9oY1neAsmwdtryaM9voNGmOiY+jL7n5A41Y1Y3J24?=
 =?Windows-1252?Q?w3orNCt5Zygmz7ROoS0LzHqeoZlFTiRwHWHUEC+BLM5KJ7gwAwoXs9SG?=
 =?Windows-1252?Q?M8u3ccIrsTnCqFjgGwZpzG2QPFVZlNQacllCnQBqJmS1LDM2DGFyWv1k?=
 =?Windows-1252?Q?19Y/aVs6a5XNMi1zBKg8hjmmyP4/cx+SlZ7EdqVXokvCH0fz4o83Bi9U?=
 =?Windows-1252?Q?j1ILOj4HGtN8Y+ueyl4CM/k0yt1y61wWpJY+25KhBT0gsYqcVCk2lcHO?=
 =?Windows-1252?Q?KsEss1ocTjyVw15ac1//FsFifoJsX+NX+mEW/Kky7yxnXTh1vJTEQl+H?=
 =?Windows-1252?Q?eDHrxfbRw35OcBrGGj+ij0NWjwQwOZ35RuF/jPofy3qwLchfXoQ6k6Vg?=
 =?Windows-1252?Q?e2A/HDD5+RxNpul18KANfB2V40xvw0r3akKXfjpxItRUAr2YIQfw6vBQ?=
 =?Windows-1252?Q?izaHu0g2jeKOwJ1a+qRcZXyxIijPQzRsrXAR1E+JnPVFhhrRwYUXWMxD?=
 =?Windows-1252?Q?OKJmRvXTxMU+nTQ/vqvOSG/pyXPPr/S/avC7O1hnjVqXOAKn14qo8YtT?=
 =?Windows-1252?Q?wf3zuE2ARAMb9pYHYmCck?=
X-Microsoft-Antispam-Message-Info: F3auoQzdc8+w+5hQW466GiltvZVEdqV/E2wJl3G5cP0ONPTpHeWDbudKYyPqRL9Pnj+9mycwrsHV5yoxByI3FZA9yPfNUb0NSEp6hl/vCYIT4y4TdkmoXAcqJ3aguga7YC7tf0JsE4uoU+12U4AxBoec7GtpGegLf8egMxqxgptRIWlccQgLZij085Ngn5/O7g697Plt/wHDNOjqVo1uvGPnRp+ZUC8V3Y/HGei/Cl90Xsm04nxGBs7gfv6+rWqMZGpxYHqQmOKis9L7wLoplnKCN78U3PVk1YI5ARoG4S7Rrpz5ZiCXdzWOZbGkH6FNPFHbv13aqVtkzObL4kFnR4bimOwKH47PVFM1fAqZX70=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1943;6:LZajoLMyUeYPIXvooE/OWuP+w6spyUJHlDSEC3gbyl6v0gb9/5J/X/94PEDN+SAd38m1vxgtozHoPWebiw7FiU4+YeB79ob5CFgbfeah4ENczDiuhX1R6nhjYfC5FRzSnGQifDxfxKMPthp2M+SDHcPmnaFkF3IKXUKOVkD4NjdB5WjcWdOt0jfaxHElI3JUkGraBSG6KV7rwnl7Jt9I34U1Nw2V/Y0aDmmP98EL9K54AwIqbxLatgEudaYaxwXTMGXRIaJT0AAt7jh7QAxHiYmrHgl12j8x4LPMgOh3EIQmhZ5Kma4zoP9C9b6PdDaRu0KtvIgIxO8Bv54RRxtOUHkuwmiXZMbn911h7tP55aKAoC9dG7p6M/NhjAdhjwSqn48wPtabRxfyZRcqmiubG66ORif4wcrrGMNVE0i073VxebYgaBmyxcZ4iMokW94Jx6uYxIQIttvRGdihmxf6rQ==;5:7yu1tOzgMTsPBS6Ls5HL3ubJaQdQzY+iHucqe0G2nx+HlBCPa2gPGX2AEoAJrhl25U2sabE+Zix++iEVVrhE+iJKIU+XrlYZiHK3lKRh3ZAy0RSlemSNDd/Uw1BO+vUK0QWCb25IDlbGAw3dLQKUG3gzyc7iiUgHqp3sF8zS3SE=;24:12fZbWcyiJqIFYPmLHFeLjkiB6KIRf44DLfEBlz1dlHcrJBRv+BF8goGwcmpf51WgMKvKCOl82kGiAq4eimyWUpmzLjPo1qm2PpRLOFsJdM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1943;7:kGQnUdPv8OC+1gSFNpQTEKVGuDyiyaChUMvYVFs1jsGsb23OMxG+hNuDYwlYMrEo5ic0CjJoOqq6irHngMUbjv7Qwe6yeCQYVojcVgPGN3EsSO3DAiYzkMtKdp+E0wHYjcSr0F02QC1gW2pGvJe2nm3R1PZDmemku7KYUbnKElV873InL2mGDPmktCtScXLc1XwZoBWbXC796I257l06fskm4DyNrW53aA38Eg8sIzO+GTnYbwC2sJtNVdOJ3aQz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 10:08:06.8615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c6fe8-c219-4229-039d-08d5db4cb698
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option '--no-tree' to get_maintainer.pl script to allow using this
script in projects that aren't the Linux kernel if they use the same
format for their MAINTAINERS file. This command is also available in
checkpatch.pl, for example.

Signed-off-by: Antonio Nino Diaz <antonio.ninodiaz@arm.com>
---
 scripts/get_maintainer.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c87fa73..82a482f 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -48,6 +48,7 @@ my $output_roles =3D 0;
 my $output_rolestats =3D 1;
 my $output_section_maxlen =3D 50;
 my $scm =3D 0;
+my $tree =3D 1;
 my $web =3D 0;
 my $subsystem =3D 0;
 my $status =3D 0;
@@ -255,6 +256,7 @@ if (!GetOptions(
                'subsystem!' =3D> \$subsystem,
                'status!' =3D> \$status,
                'scm!' =3D> \$scm,
+               'tree!' =3D> \$tree,
                'web!' =3D> \$web,
                'letters=3Ds' =3D> \$letters,
                'pattern-depth=3Di' =3D> \$pattern_depth,
@@ -319,7 +321,7 @@ if ($email &&
     die "$P: Please select at least 1 email option\n";
 }

-if (!top_of_kernel_tree($lk_path)) {
+if ($tree && !top_of_kernel_tree($lk_path)) {
     die "$P: The current directory does not appear to be "
        . "a linux kernel source tree.\n";
 }
@@ -1031,13 +1033,14 @@ Other options:
   --sections =3D> print all of the subsystem sections with pattern matches
   --letters =3D> print all matching 'letter' types from all matching secti=
ons
   --mailmap =3D> use .mailmap file (default: $email_use_mailmap)
+  --no-tree =3D> run without a kernel tree
   --self-test =3D> show potential issues with MAINTAINERS file content
   --version =3D> show version
   --help =3D> show this help information

 Default options:
-  [--email --nogit --git-fallback --m --r --n --l --multiline --pattern-de=
pth=3D0
-   --remove-duplicates --rolestats]
+  [--email --tree --nogit --git-fallback --m --r --n --l --multiline
+   --pattern-depth=3D0 --remove-duplicates --rolestats]

 Notes:
   Using "-f directory" may give unexpected results:
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
