Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5437DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9620894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="I/IkRBiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeH1UrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:47:09 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:28929
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbeH1UrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoMEDyRPWX84qcM+kOkCRFcBf61jl2KtfHkkudxM0ME=;
 b=I/IkRBizxp5Uzt3GKZtXQDTQ3X1vmWrMg4u+1o/IZtw02WohT9XZq9SVYB/wZIvwqUAGp+Rpy65CwSxRYsvIfMFrDIB+2N6jwNjMqFXuBo9hOruOsgh4Z6rIc0Nwi44/H6ly60j1Kp2wLnP/S1MKT1ETBSxq+6KGuxxyRDYtRoE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 16:54:22 +0000
Date:   Tue, 28 Aug 2018 09:54:18 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Convert to using %pOFn instead of device_node.name
Message-ID: <20180828165418.ylusu7xvsmo5qcyi@pburton-laptop>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-4-robh@kernel.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR15CA0067.namprd15.prod.outlook.com
 (2603:10b6:301:4c::29) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69baa61b-bec6-4844-534b-08d60d06e7b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:uTQ3SPHtmbjrMUuCs894EsqCyt2kEG6Y3m1lsXOVp0R5csXJvfQi9kE72CNxE/j/e+nTwWnMhqVjUGQVwT0CCAdhsqw1/xhngn7qrn+GqgRjJ9r5oAl4DEpAKhns8eiwzCBE8m6QCIb3dseXZbk2yP0yfPgdp+zcE+Fu4hN8djykSKNgI97oVXUdDhM6gGvJWJDEUolp8LW6SOI2jzCEvxCeexijRCzz4rkyShiLDs3hGykh6BfRBfypFQZkJ9IU;25:ldn0q29OSUTrU3LvJqHeeBc1pNuYaou7w/+PXbjUvvuQvWyACHxYSIL3pOT2GuYX3k97NLMSa54xBIJtVEiUQonI3Kqw21JQOJVxfXKPRtvBN8pLeGx/PKcNIIiVEfq0o30yUYwZQ3T0E3YgJW0/zBtUK8edAclowe7fZdY4nbnXhdBjgyTEZ/xsEq11FUwxk1we7mj/zDOyo0H2R7pcIliePwQWksD/Wo4X/Jzk6B7OSbTIitCCu/2loXhi76xVOrv9T1IYqNvSgqHx6N5Pd2D+2GkE98nO/sJJIwo67JMVqaJ6y4t0GIwF8cnqOCL0/ipAv6i0SfnV1jVoYjysvg==;31:GGR1XO34aY9lg8EMRIVs10jDCYxmAHOGe4/XoKTf0PksvIN865fbq8gjOtMk341d49gJjU7UjkpN/N3MoWv8/lB0IZIXMus59JNCOeDwV5ng/0E6C6UEKRwnYiC8TBkSV1tsqiG9dhnBj+X6LsTs/qtpytOy6NR1YT2l5LwQDQtFwcFlIUtSOtjb6SeGnEOHX4IBJcJaQ6vDO421JM0kOixC4hipv8ETrp5qotRduwE=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:jCjjxlCNVdXRxt0Vh2/JxiX9UXraV2r1Fza9jVx2LJqz6BGWxJOzQJGVrgOTS/FM6BR0RXL8KRj9aATRaXxBzASVuCosdsFPi8fDtaYQMB/ZHtQLwpLyBNIO+YwuAfuU/wDFcJ6HKk6D/ipYF65h+GWdaSAaPHTY7giEq18YqTg5UWLm7PHlhRrSo5pdM1X3WfcOEFXeNXNHR3IvCTJnt2F9KaXJI7q7d/jm9VkLG7riCvmyIDbdmoLdoyG5jfOx;4:1Yv1wulT6mnOtqVLqqqMIg7AeHQDV+8ImjlEBkt5S4c/DYIvfZHBPYsTw4jrze0C7RyXMWeNFxDjFVUNwp+KyPBmM6f6usgsHsilOn4/1jcVv4ntazJB6gkuWqumZ0wOKw9O51NJpvZ58xjbmAoGXl2NsQoGe00LmbBsf1mZz2zhOWq+vQJ4Kn1Bv0jLUcsWSumudPTXoeSEb9WMqzyc6WiN5MEDO+54Huhqd7gvyJgftRiTaqSstWibB2AVahBo/HtI64Sca1TYfx+cbQFxWQ==
X-Microsoft-Antispam-PRVS: <DM6PR08MB493938D883EB6F682A4AEF07C10A0@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(366004)(376002)(346002)(396003)(39850400004)(189003)(199004)(58126008)(54906003)(16586007)(956004)(11346002)(42882007)(2906002)(33896004)(186003)(3846002)(305945005)(446003)(7736002)(50466002)(97736004)(26005)(6496006)(386003)(52116002)(16526019)(476003)(486006)(105586002)(6116002)(8676002)(106356001)(23726003)(1076002)(4326008)(81156014)(25786009)(316002)(81166006)(68736007)(5660300001)(229853002)(66066001)(53936002)(33716001)(6246003)(76176011)(76506005)(6666003)(44832011)(9686003)(6486002)(8936002)(6916009)(47776003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:IYDX6SXNle29+L1GsQonZAEDRWdhLmr5MTYl3dEZk?=
 =?us-ascii?Q?H7cOToI2VmYtOmUoyfXHlQ4XNl/80v1dxNZHHJ/DcdhaLOCueG2ZZD2MJObj?=
 =?us-ascii?Q?Al//BzmMq3LE4kpx4flx1R2AmK8Miw2vF8X5UKgXKS1lbHYpYync9izkES/5?=
 =?us-ascii?Q?U0G913TAjJpdMp9xvGsj4a5WjcnRoR1tYi8DdqbCR1WYzRrar4JnK10AuGoR?=
 =?us-ascii?Q?22XJJWj4Sm/KoOS5+QfiSxT1GxwkwmlWSprDBKoUGnfCS0fNhg2PkVlxs0jh?=
 =?us-ascii?Q?EyCJ0p4ON6Qow7GObMiWST6kvBvChGliPQC23vBwtMLwWShS+OnctNEmd1wo?=
 =?us-ascii?Q?S596Hc7rTLsqUTYCVbzx/TRYkek+tbanLr6B9o7fSEJnxA1+hUz4OSbWU9bB?=
 =?us-ascii?Q?62mQYs/MoC97tAMc3TpaILMGXS8JrBei23gDlVImWVrbdGhui2sGn0lTZXSE?=
 =?us-ascii?Q?QcH89DCtDH1pt2EyiMtnPnDaXsNE0SiBp4wt0IX8CMfRViiPxU8ZT9go0zq2?=
 =?us-ascii?Q?Cx4gkmoKKu4dhsNlKwONJeSYU6atOmSz0FNNfMO3fWPN0r/oR1Gt7g72l1Ds?=
 =?us-ascii?Q?OZ66/4pRRuVS1RE+ZNRwbC4A7qF2PPn+5xsd9TFPO5l5wmJQ4kyEKXXDNomp?=
 =?us-ascii?Q?0l4lzOovztgHIrmhNeb2Lodl+U0fNDafVX+pEDwO9oUbtotcjPkEZ/vv9eF/?=
 =?us-ascii?Q?9AZWjn/y8XQsly0pm9P2ZavHtC0m5Rzn4DVl4xxeP/1PwBo6WDWaY0c8yvQT?=
 =?us-ascii?Q?m6/8UurN8G1sW5EJatSdw9ev2RoichSkYUT3aH33gpb/+Uaani5O6dAnfavv?=
 =?us-ascii?Q?kEpCQy8vxsMDzW3pMuEkNRcDc7lIPEqrOCN/tv+mntaDdy/UxIvnoZa4wBdL?=
 =?us-ascii?Q?W87ITZJ4ytDST7PoOhS6/5rGz7Cr3X9/uk6Q5Z24tlzG0o9FXp5t298cJ0he?=
 =?us-ascii?Q?TQu0x9JeCdfxxH1GTLKMQBV42Khi4jKvrQeXY+SP9tsoNFlSVIdooDi2bbuL?=
 =?us-ascii?Q?XTXo22q8Z5Oy58sXYloYY3EXfEY4cWmoWpJ/jLZ/AjID9dDmUlgkyYNXccbu?=
 =?us-ascii?Q?NfcyCdqQJaVIHqZtrELiCRzZ7MAsuyXbsKBBJDV2kcm6lXqIjpjaoq8e42Kr?=
 =?us-ascii?Q?sEySq89tfqD3SOe03VZJCaaSlrLA2cCt8FgyVNZ443G7IbGdAHPFrQ9Ck4Te?=
 =?us-ascii?Q?HT7eo2x/xkrThJcjKKCQ/JJ+56gdqoS8hjiAdWJdh2hpGUbkO215S0clBUIx?=
 =?us-ascii?Q?0hNSDDAzAP1kLmOpHMJmX3tT5eD3Kml0tNFkLZ4y0pXuG6HYyq5EC9zPzqfO?=
 =?us-ascii?Q?pMVPd2sfCXsCIlNaT//HRk=3D?=
X-Microsoft-Antispam-Message-Info: 1yf8rpWAbn6hHigZhSt1pIcRjaV8RY4A1rQeS71R3T/vQPACCFHFhd2qDP9IqOlKqd46fEgHVsCh7OB+lCq1SLy8xhuhvT2iQjRsLdVauWRHYg23wp7iJvY0S1wk9AlxrssefFPsn151dITXQUL6W5cniHcSCT1/trQdtePEb8tMIE/8q8vVXcfxNeiPF6mrREFeikFmQI+5n/3h0KqhohSSgFeh8MC85eOj9+V/UqEEK6jxWqP5it8xrSSKoFoIiBFqT3uT1SeCiJ3oxG6GawM3Ei+u8j2CMx8lNWL31ABvJOWcHGsEUZ7Z9lXdTvcvkxuq6wVTlnhr4vNv3/8jAiCHU2lZtPY3nl06wvsEiSU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:e1okHP/w7RC0UCVjF0GOJ1U84F4cztR5QAjutSzwA3R8pz9tMH9zp/bwwP1w4Kuraotekpe0ecFWhdYI01W7D/qQH07DjTBxqZBg68eVWVsgqjl4KjkMz1DsEnzQ2AR3HBwmq33dBLogsTCKclsMVtBIqB67PxEH2fgo531ANgiGBStFj5u7decPN3/DihvC1nWVWv+UUcIr+RgpjETubGrQAjEvOWp9q8ZTsz7Pv131rVt49BiffuY9uGSKQP2Wv/Bxb4GhRJkBavDaCoEp8rv+2PvFZVTUls1lq8VATn07pFCOnDPJ0PGegTnc030oXUGjFzA3DbaUSTgk5Vl3dw5zFgZT1/IzOzsD/MFDAFPwU/M+OEw6Yssf0OKI3yjbjSdn5qJHU/8/FFfpiiaQWuyNxytQ6+J56KaaCnleg1CGF7osZZ4M9vh8cUaslHE8NCFu3CNidq0IySbKcwYfaw==;5:cZfDB7Pg4SHrgEzQAO1/pIdf5SIlh7DLT/fo459gqa23aR2yoACBKlzk5qqkjEf/JicR3aIfGnPtnwQYI7VlJNtM9cZ5XNqKnDMGwI5Q/jEoGRUkTppGqbJ+aDFsh7KfZewXcIRq6opxAmCxWoa+rPUQkh06bjZS/raMcHSi5Qg=;7:ZJwAx1UXSTqt6p4FOBUc52i1Tt0af1e8Idto3o0dz8xxeMdkK3bQurQNRPxnRt6Hcue4i13gEAOdDRQMiDA0Yj5vLKHpJ9q8F0VWWcgYdJFE58J5rrJUbNyGMD//atRChyJq8ghmR3WeCaB+i66wgKpFKIKMWsO1vT+7C1uLFtrhtZSBcr7jj8LdffWBLhHCnkT39XuJBI1tcducIgLivqTlh4JOhmdUhRI9HeNSsWh4Pc7eordg47SLuGE7juqk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 16:54:22.6076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69baa61b-bec6-4844-534b-08d60d06e7b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Aug 27, 2018 at 08:52:05PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/mips/cavium-octeon/octeon-irq.c | 16 ++++++++--------
>  arch/mips/netlogic/common/irq.c      | 14 +++++++-------
>  arch/mips/ralink/cevt-rt3352.c       |  6 +++---
>  arch/mips/ralink/ill_acc.c           |  2 +-
>  4 files changed, 19 insertions(+), 19 deletions(-)

Thanks - applied to mips-next for 4.20.

Paul
