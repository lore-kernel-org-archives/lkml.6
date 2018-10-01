Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E42C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A57320666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HoIcZNw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A57320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbeJAHQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:44 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729721AbeJAHQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvITsx1Va7IGlEkkTpNP/yacvTJstAKis3tkcVhk2FI=;
 b=HoIcZNw3NlfCd4xLz4olLOg5v01NFJmiw27/dpqfjdK8gilZKzNMRuyAF1bY9WUVlAYt4tC3Ok1yK+GWhbtUYDkjU688UaAk9QV6bCPBdAq+GJLlJWPM+psWUsQfTU7qMaqr87ZNepi7vmoer7oozWkGxxjZ5hLDLKapwKEtbyU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 11/17] arm64: jump_label.h: use asm_volatile_goto
 macro instead of "asm goto"
Thread-Topic: [PATCH AUTOSEL 4.4 11/17] arm64: jump_label.h: use
 asm_volatile_goto macro instead of "asm goto"
Thread-Index: AQHUWR9/0vxkrdqDWkm5eFrjwwVYlQ==
Date:   Mon, 1 Oct 2018 00:41:31 +0000
Message-ID: <20181001004122.147276-11-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:ywN054YmXshoSjh8XBK57H4BSmB1MlOgv7sp+bUjw0T9XAmvohTBC1bVuDh+Z+0Wvbo9bO15e0BW+kz9zVZRx0icftgsRKPcd2lErw3tFbKAyV5B+DwycbV4C40tVYfig66UwJCM+l+n7IyS4HRZ8c/cMjJPkUO9JX/BqtMTiJPJzSdmRvHamU6nfBTaLuSp7OnxugkNIODoI6w9BQhsx5XGAnuCYbpx9h4LrTMRz1syeOXK76N9LdEslkW1LITADr1yxEMuHbF/VDgCUbpHC9ZY+duhrip+IuEigdJAMSx233W/ZQoR8AGFXaCtxEbXtxaKS54jBR7RDQyR3g9d+GlhcLltUx6MFCrZcfjmcs6BLpZpu32lUJBULwG04PDWr5jvl7t2ZCJIEf+OzFdn0zZky2/KCVqqTD5FWzoQEd9uSQXOnDU/Tjtq529RwYunGM6oU7US6eSn/m/qY50mJw==;5:bDUYJb+7PPHUmO8/I+Z6+af/1wABB2fPftuiuabinzLPGtO41bd4Q8cxo7Uc85bKv8OV6FN3s3pMs1rQLKUHVxy8ldOZIrUHGttomou9wjJjXoeF0iAW2+uqFgrA6sciPC9hje6E2OEn0jzc9GnCvAY9QOXGFH5Naf4pARIAL4M=;7:8BhL9aJ2KNrYjH4gkgGZz6E6gwAwgYGSMDqWAlwyuk6SiApMtrP8cRGPjYhmQQ5uF42G1lLGMlGth07u2kFZW+jvrdshLR86Z/rWuij8Gf9fgQ3PYQ9h4sXvN9Ec6rZ5MY8mqu3RAPVTFKg7PZxrsUMcr53Wplxz4LkqgsIWq/cwrrbv1TWMhSl7ngTRxJNBpbPyvvUaBsAcnbVOwgu5aTh16p9A4ZKgnMDYor0okzArYsa5hqKxc91E8qPSQljr
x-ms-office365-filtering-correlation-id: 4598d463-ca0b-4b1f-ea5d-08d62736a1ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791C4733E3348C98A8B693FFBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(85827821059158)(180628864354917)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(39060400002)(2900100001)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IqmgOeju7WrW/rS87u6640XNCOTDS9OsPeRx57rPkMrpAyKLLVOx48uCSATqSB+U1JTg+7KbrYxUOtmjToMtTYBmluzrv/77oUlHaIWuWAF8kP9JuqNHvWwAbHsV/fic+IfSsrJh5bjWM0hLcvTPgL8Yq+6XsHbfSonl9JAFRtisXcnpBcAeK7hVm7/+gkBbpEMUD2v5IeWAz1uHevD76y1AmjxQo0bpLKpVzkAK6z/cmeH5pK/ZmeoQVzrNDhvONukqGdr2vGH3AzpTc0qnYxgxKwyLWBo9Lj7yDApJGC1alkDY8vzvvsAAZoGmrpsJq82U+ohbfDiP7xEevuxPW0qo9+rQpaybhphmmPBXLhs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4598d463-ca0b-4b1f-ea5d-08d62736a1ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:31.4832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

[ Upstream commit 13aceef06adfaf93d52e01e28a8bc8a0ad471d83 ]

All other uses of "asm goto" go through asm_volatile_goto, which avoids
a miscompile when using GCC < 4.8.2. Replace our open-coded "asm goto"
statements with the asm_volatile_goto macro to avoid issues with older
toolchains.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/j=
ump_label.h
index 1b5e0e843c3a..7e2b3e360086 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -28,7 +28,7 @@
=20
 static __always_inline bool arch_static_branch(struct static_key *key, boo=
l branch)
 {
-	asm goto("1: nop\n\t"
+	asm_volatile_goto("1: nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
@@ -42,7 +42,7 @@ static __always_inline bool arch_static_branch(struct sta=
tic_key *key, bool bran
=20
 static __always_inline bool arch_static_branch_jump(struct static_key *key=
, bool branch)
 {
-	asm goto("1: b %l[l_yes]\n\t"
+	asm_volatile_goto("1: b %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
--=20
2.17.1
