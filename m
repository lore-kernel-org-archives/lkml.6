Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589CC004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B3D21748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rcLZnVDu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NdD99gPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B3D21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeI1Qcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:32:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729093AbeI1Qcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:32:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SA4vBd008635;
        Fri, 28 Sep 2018 03:09:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=35eScStQsSSw7DMVNp9jLgQR9/wX+Zfdvycd72GRCOg=;
 b=rcLZnVDudGoyeFUPwS49S7W/1PdU3wiwsxJP3/45IJVeYL5oVnjWp3LzHnNpCsOkTsgT
 gtrvztJG/gIlwb+Btr6Pv7CEFrOcnTrwcAPpVhmHh6PTDHYQ6qVPiLa73s/n8lo5pNCh
 AQhtElhiGIDc2bpe4KQjf4kQad/HsaN3eZg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mshdsr59n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 03:09:11 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 06:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35eScStQsSSw7DMVNp9jLgQR9/wX+Zfdvycd72GRCOg=;
 b=NdD99gPx3JUFQ7fPfiqcRO3jvmAM8E2Kj3y481JzcqwHTCIi3dByYJ7keqSUl0nhoitpxFwIi2gjyfgMsagS6NnkZjyS115SBpIu1NwJnVohyqhTnF/9aewNuE3LTllEX8nt0gBnrgWD3ks6DL0lmfQMctJVaCmv0fo3XzT5h7s=
Received: from castle.DHCP.thefacebook.com (2620:10d:c092:180::1:836c) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Fri, 28 Sep
 2018 10:08:48 +0000
Date:   Fri, 28 Sep 2018 11:08:29 +0100
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <netdev@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 10/10] selftests/bpf: cgroup local
 storage-based network counters
Message-ID: <20180928100817.GC9018@castle.DHCP.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-11-guro@fb.com>
 <20180928085356.56xe7javtd6cdfz6@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180928085356.56xe7javtd6cdfz6@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c092:180::1:836c]
X-ClientProxiedBy: AM5PR0601CA0030.eurprd06.prod.outlook.com
 (2603:10a6:203:68::16) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f18869b-9977-4362-2dc1-08d6252a6382
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:enQgE1eQg6JlAXybb8UBaVjMBBnFeKgYeJqI4twFeF/Ec54lXeXQMiowM1WTBzQx5OM9Pjo2y+drkAA6j5vgjcuOqZrRTajUEJlnf1kbq2Y8l0YFuTkdiYnezyG2cVPzgimtob0Wve8OTM3TOY36tULmC+qEkLqBBuWK/4Xud7XrQDUNCjTnNMlkDpOiYIQtMLv+z7cpCBMZSc0cVRtcx0n4q6dZ+522f/RDpUmrqxWp1kId984i2Sy/pZyf1n3t;25:ihkD+bayvTJ6PC8YzpxhhS1JbyCfu53REcu7KLkjEQP6TzM1ETV5TXWz8c9YxuL4P+MZ1TnMvWye39jijOEfHVMBYGvP2U+78d2JUyztlw6wN/IwfrqdwM8MUjsKOoDz3XlbeHJHLCyWxcIWBmBGWJ4Wznd54iGGBWv5Fcu4oWPOgkFTIFwyVz+qqRF1hUZyOeawKZWsEkMM54PYWVKuu4scvUzRSJ8gcXp3EHxjj3iegtfmTSJoxaRx7nDbmmrZnWyEyxbK4ES3P9VKSiDTYLBRInpk2x9ea/dsP13o71/hBs6Wj7FYgYm7cB1ZQF34nCPRrQVA0p33KWH4L7SxvFlbkd/aYEd+demO26FHOmA=;31:/uNtDfnyvc5eKIcaw5ezlAkDIBCTbWFWQco93BeauGyVz/pJDkGZriEnWj7No4FiQfTmYOTtkQcsc/w7Q9STUN9PGjfTxPv5Nw0/4ORAojzcIHAUEdr5h2f+rv8+m3+JmyJbtndzf4jr3XfsPiyWOb6S5iBLfows9V2VVVu+4uzu3RMNJCJS5KFVAQqtHzF8fxQvlNO754YRCkpep6s/LkTQCnW/Qxg2mtwzxGkWrA4=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:hoXI/y5xEtoq3VC2Q4Av8ykGrA/QekRfT01Ckie8cJq2ZMFrXOBKi7Ns7+zWUgr+uSHuAK3TehgKZcyOQnoKLMDTq+T/zfP0CG1gU7K4pcSRf5ff64jjn6cf3Ies7bINfP7CZpsQLYYnSJe56nPGSI5lCF8zgZZXDwinyrTD8Os9Z0zPn84hkGW4h2YFT6CUOfgPvdbRRKn/4t10ODBmx6T7Bz1K32SX0cDbyaEg7Yt281PdHIn0SVFb9y9EhxiNnF7ttrZmMfR+7cO4qnnd8rhCcscRqjiG182NA6oV7a6hxJ/S9NGRX4cnjkltHfmC1aNSlase5SKdNw+SIGcvB2RSxjG+9LC+u0LSkujFr47sDLk5qhicqBWWVOuCY6ebRo6scmnyIJAdYvUi+JhfTCbj6eE0olEIxfqULy6r8SWvqyQtV5pZgxkwwMAb4Sqg4tnY4q0Fg3RioIsiFkcg3X+cfHM2LLzaNg9XMRNimkoO0a89JRTyG29iKsm0mpFW;4:LzHVkbb8GZ597piIyKCJmHVl58jdI40mWx4vn5840yYMf7+8wA3oaSOntWJxA6/2mMiZew/QRnQyVjLhZ63s5P9GF9dc4Wv+6goU/EKvFqcM+IcqstELw3d0g0CQXxD/kUtZ+XZOjVYLxkLBYT6OvVddjTKgcNzMu0loHCwiHpdOT7xgL+vuXs1EHGWKaIShi338YUVcfnvsXANkSUyisOd8exN/xBbdBAYIHL3Sg58dYBdqT9VMYvWxzCaAFsphYGZf1svIQ5sCauvgswZe6vCa2Antty62+S3nDoIW0vC4Tx+RJHQZ3C+6J/YlxhgGteTRkI9OAdKFEscp+EXb4puViIRW/cT7SAGPfHg6T3s=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175C7C4A44AE0E39081199EBEEC0@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(265634631926514);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302061)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(14444005)(476003)(53936002)(9686003)(55016002)(39060400002)(8676002)(316002)(81156014)(6506007)(386003)(81166006)(6916009)(486006)(86362001)(16586007)(58126008)(478600001)(46003)(446003)(52116002)(76176011)(11346002)(34290500001)(229853002)(6666003)(52396003)(106356001)(68736007)(54906003)(47776003)(5024004)(50466002)(7696005)(6246003)(105586002)(305945005)(16526019)(186003)(7736002)(4326008)(23726003)(6116002)(33656002)(2906002)(97736004)(8936002)(5660300001)(25786009)(1076002)(18370500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:z5B+aadyWywZdVF6QX1LQn/Plhy04VLzY4AKskG2v?=
 =?us-ascii?Q?f2MaOydyctCDSS0y6O0B4E4JRXC9mi1vOuMvPp5WHkBqFr7eekZgjTzmHIda?=
 =?us-ascii?Q?UYseURudFsaHE+SPN/R2AWIst8rh8iQlmDyonMB8nvA9OF1/GrMCFXKz+SKd?=
 =?us-ascii?Q?lVtd2VdjT7rRzz4asZGodWCYBxKu/JUV0CJpod7Jqe0pm/r5xgxHBid9VIeo?=
 =?us-ascii?Q?fRsfo+lFn4Ai+gVe9rBr40dAG4SfpH8+oamQQkoxbM6C+8B5G8ijXOS46x0b?=
 =?us-ascii?Q?hgohKKkCKDinWWXfUWiH0hatM/jYJXDRx2lKSBJPJ/yS8suMVj5yoANq3V6W?=
 =?us-ascii?Q?Fg+SzcAmONqR12GOqNndiKgFuL+NR4CKSsYZTvgFjOrXrOci3xQezP5s+ZsU?=
 =?us-ascii?Q?Wz846ReHGrobaOlAf/Kju/az0MyQlqGiARBKUepLaVvMNmhLSp1cPAKTcbCU?=
 =?us-ascii?Q?NNDNL/uIKg6f468nwb6eiq96a9WiaNASLQATG2UX+H8OClB30lapi+EZs9V+?=
 =?us-ascii?Q?rLXUBjcLrbRbgcIbgsPgtyjaC+Kj0xbPK4eQKXIiCao1GPCs1FHs2DvVAMG1?=
 =?us-ascii?Q?eoiM3JldF3tean2GgNaLF0aL+p6QW3qiuyTQFnKGLKONrjLG2vvcSNS6AzQU?=
 =?us-ascii?Q?m/O+EMXTPkA+8mcxA22HRCaevuWJf/X+K7BKmpLQ8lu1u93kDmDcUh/4+kHk?=
 =?us-ascii?Q?JecegWHLk5cV6VpVvtQBk8B/JmS7gzUEcEVuPvMY32YjgnmQtBW5xr/ojRFX?=
 =?us-ascii?Q?WSbfoDKUD7KB14gMjBI9ybnrZrfPQTbWqyaffBBUsP/UPBr92ZAZIulhV9DC?=
 =?us-ascii?Q?filEoCPRZCcuwcSejItV+VE5TqDHFy1Er0NHBZSTxTUeBoKaf8pQxTJPuDJk?=
 =?us-ascii?Q?zIXhdINdMYIxok2gC9mjxRHMXhfdjeyPgGhKO0F1I3asGxEh8MTuuEcfcBwe?=
 =?us-ascii?Q?4ZAf5Vzfp8IVbJQJujFqfEOVuvFOjsq/m7vHcyn5X5b0+wO+1QdAgv8jbXHD?=
 =?us-ascii?Q?R2Jmj6GBjYDcr1lTiLCDmBabJ722Fy+ZKmj5fzwnAvGwXe98IJ1dGbZuL4VM?=
 =?us-ascii?Q?9ENOOBzcP4TXAk5+sItPiCpls5ivRAMbc7beBCjWUypaLRN0U+JmjEzUPj1n?=
 =?us-ascii?Q?0A3k39cepZVlcBhWlT/SrgvMFlZRouJl1amTPmD42evYjQO6SA3AT0plxgz2?=
 =?us-ascii?Q?W90l6AQ0LRx6z81kCOAOdnIl2ynGRRpS/h9JZWiu+MrBiWRMA+N1fSq/H0Gm?=
 =?us-ascii?Q?uegRFllk1oDx+StIVe0hgtG2Zp84btQkrDyCohbNc3sIpqle+Ssd+EnnE9ej?=
 =?us-ascii?Q?VVOp1R9hjcP/IiCP+HvKV9CGLmQ67pnpTBjguyJQPDRghFGFPqr2NoAId/+r?=
 =?us-ascii?Q?blXPA=3D=3D?=
X-Microsoft-Antispam-Message-Info: W2re5ia2DL5JJ4oYEAzyrLzYU9leuOzjc47iX5eNfptvumqYvIlRDXyzLU1C55lt3tUCQHbj682eFbYf7pKn3Wu9Mwo+SCyHVh6PsfnYXkRXG8RAsiNUOQT6AdkqOG1c/ImkmHSJcijI161kFtzOlZU9cO3bS/ETXJUsbr32M3xuS15T9F5kieaKQ1L3aqyj6rMMKcMpXngKWPxpgvbBW8MjhbSyDfhCkJHpApQj9ppb/njGtCaniupBM3zWrCBD3tmfAAcTRGO1tx0cLk59Xk6vhgbMhOg4B1tilik2L02EwhBPiZ22X/q+bE5ukx4A155SIa4pg70+NQOMENCN6VUVuXwZ3q+EyX+SeWmtiP0=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:qQ467ShntWzCeKfbIfgSUFKl6aPqs7X/6gzGUTIoX4wPn50bre7YV2Hzl6ma0i/FU5Od3VF37l9e8Ixkzs13Iqw67knQnwFlkz1vtAWTdW5YWAoFFFIqE2icOZ0uzTI6JP+YqOG5wF39P9TrfMonOUF10YWafDibT9WrH2WB9oFlWqEMizlGZdmYmhYNfa6lHNUStpqk2MEkTYWRTtsG+a8aGnFUJnpaIeB6aLRVcxtU/i617FDUvZ+CXqmezoOeS5fFru1/syFNA/U+x38xH05OVkkxR0QOVOTACn1fnYRl+PiuLZR/LIDaRzK4YPd1kPuCofzPFUVX1hQdJ1QIevVROMHqcXQYgzxgywOkNZmjkDQqvpjEVPsRgU7VM5yfUQpJbWcsH0qtFtiWJ3A6QyWUZ+hFDg7P3mX8j30swPinKQE5zUuLAMRdE4m+crVe6UfmNjY1pUzTZ0Zm9kl8cQ==;5:vJ/zGBhfCabig2RJNjzaol0zZBEONDpB43X/Iy+1kGYbFLQPl/gx5UyZlsS0zyDfotq5Gw43WtutR2oDTXniixCmH/tPU07Ea9RSzG3f+JN/E+cGdnS7TuFP3jUZuc5OwSjP/IneFVYzpXC6+oWZ1LKWXskVRGkOjDUJv5TWd70=;7:KnYi7T9l7W1UXOyjRfDrj/q09/sR1s9WYrhtYUWjcpsMTOjhEfc0YeF2S7hZwIbAgTxJXcvVuZTyvu+ReFNb0czhAX8aV/AWap/1dFEkjTOBoUR510hV2hpL/PgDhAjSxESid7ocCu/BHLoBL5IUEIIZKZT6zr+oLnogtEo14wBFCP+wWunwj4gQhoq2B6EPBIH4YV/SwtkgWldOqCPL26h6n8WFuRHH4fje4QYkLZUad4fZVx5w7XnTM1KS8zoD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:7PJlg72hkEEwh3oNF5UUd96jy0pBmr06DLhqoselbghiBTnCcAoTTDKZap/2EPiiYlbaXYvdnUXbFW0BTIJZTkmcK8cXrQMt++HB88f4bma3/Rgs18oachsjURC6G/s7mSIh+56HLMjNFn6OpTL/6rZ7PlyNcMajRpWt7QY2IC4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 10:08:48.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f18869b-9977-4362-2dc1-08d6252a6382
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:53:58AM +0200, Alexei Starovoitov wrote:
> On Wed, Sep 26, 2018 at 12:33:26PM +0100, Roman Gushchin wrote:
> > This commit adds a bpf kselftest, which demonstrates how percpu
> > and shared cgroup local storage can be used for efficient lookup-free
> > network accounting.
> > 
> > Cgroup local storage provides generic memory area with a very efficient
> > lookup free access. To avoid expensive atomic operations for each
> > packet, per-cpu cgroup local storage is used. Each packet is initially
> > charged to a per-cpu counter, and only if the counter reaches certain
> > value (32 in this case), the charge is moved into the global atomic
> > counter. This allows to amortize atomic operations, keeping reasonable
> > accuracy.
> > 
> > The test also implements a naive network traffic throttling, mostly to
> > demonstrate the possibility of bpf cgroup--based network bandwidth
> > control.
> > 
> > Expected output:
> >   ./test_netcnt
> >   test_netcnt:PASS
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Song Liu <songliubraving@fb.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile        |   6 +-
> >  tools/testing/selftests/bpf/netcnt_common.h |  23 +++
> >  tools/testing/selftests/bpf/netcnt_prog.c   |  71 +++++++++
> >  tools/testing/selftests/bpf/test_netcnt.c   | 153 ++++++++++++++++++++
> >  4 files changed, 251 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
> >  create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
> >  create mode 100644 tools/testing/selftests/bpf/test_netcnt.c
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index fd3851d5c079..5443399dd3a1 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -23,7 +23,8 @@ $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
> >  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
> >  	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
> >  	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
> > -	test_socket_cookie test_cgroup_storage test_select_reuseport
> > +	test_socket_cookie test_cgroup_storage test_select_reuseport \
> > +	test_netcnt
> >  
> >  TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test_obj_id.o \
> >  	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_prog.o     \
> > @@ -35,7 +36,7 @@ TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test
> >  	test_get_stack_rawtp.o test_sockmap_kern.o test_sockhash_kern.o \
> >  	test_lwt_seg6local.o sendmsg4_prog.o sendmsg6_prog.o test_lirc_mode2_kern.o \
> >  	get_cgroup_id_kern.o socket_cookie_prog.o test_select_reuseport_kern.o \
> > -	test_skb_cgroup_id_kern.o bpf_flow.o
> > +	test_skb_cgroup_id_kern.o bpf_flow.o netcnt_prog.o
> >  
> >  # Order correspond to 'make run_tests' order
> >  TEST_PROGS := test_kmod.sh \
> > @@ -72,6 +73,7 @@ $(OUTPUT)/test_tcpbpf_user: cgroup_helpers.c
> >  $(OUTPUT)/test_progs: trace_helpers.c
> >  $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
> >  $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
> > +$(OUTPUT)/test_netcnt: cgroup_helpers.c
> >  
> >  .PHONY: force
> >  
> > diff --git a/tools/testing/selftests/bpf/netcnt_common.h b/tools/testing/selftests/bpf/netcnt_common.h
> > new file mode 100644
> > index 000000000000..0e10fc276c2a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/netcnt_common.h
> > @@ -0,0 +1,23 @@
> > +#ifndef __NETCNT_COMMON_H
> > +#define __NETCNT_COMMON_H
> > +
> > +#include <linux/types.h>
> > +
> > +#define MAX_PERCPU_PACKETS 32
> > +
> > +struct percpu_net_cnt {
> > +	__u64 packets;
> > +	__u64 bytes;
> > +
> > +	__u64 prev_ts;
> > +
> > +	__u64 prev_packets;
> > +	__u64 prev_bytes;
> > +};
> > +
> > +struct net_cnt {
> > +	__u64 packets;
> > +	__u64 bytes;
> > +};
> > +
> > +#endif
> > diff --git a/tools/testing/selftests/bpf/netcnt_prog.c b/tools/testing/selftests/bpf/netcnt_prog.c
> > new file mode 100644
> > index 000000000000..1198abca1360
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/netcnt_prog.c
> > @@ -0,0 +1,71 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <linux/version.h>
> > +
> > +#include "bpf_helpers.h"
> > +#include "netcnt_common.h"
> > +
> > +#define MAX_BPS	(3 * 1024 * 1024)
> > +
> > +#define REFRESH_TIME_NS	100000000
> > +#define NS_PER_SEC	1000000000
> > +
> > +struct bpf_map_def SEC("maps") percpu_netcnt = {
> > +	.type = BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> > +	.key_size = sizeof(struct bpf_cgroup_storage_key),
> > +	.value_size = sizeof(struct percpu_net_cnt),
> > +};
> > +
> > +struct bpf_map_def SEC("maps") netcnt = {
> > +	.type = BPF_MAP_TYPE_CGROUP_STORAGE,
> > +	.key_size = sizeof(struct bpf_cgroup_storage_key),
> > +	.value_size = sizeof(struct net_cnt),
> > +};
> > +
> > +SEC("cgroup/skb")
> > +int bpf_nextcnt(struct __sk_buff *skb)
> > +{
> > +	struct percpu_net_cnt *percpu_cnt;
> > +	char fmt[] = "%d %llu %llu\n";
> > +	struct net_cnt *cnt;
> > +	__u64 ts, dt;
> > +	int ret;
> > +
> > +	cnt = bpf_get_local_storage(&netcnt, 0);
> > +	percpu_cnt = bpf_get_local_storage(&percpu_netcnt, 0);
> > +
> > +	percpu_cnt->packets++;
> > +	percpu_cnt->bytes += skb->len;
> > +
> > +	if (percpu_cnt->packets > MAX_PERCPU_PACKETS) {
> > +		__sync_fetch_and_add(&cnt->packets,
> > +				     percpu_cnt->packets);
> > +		percpu_cnt->packets = 0;
> > +
> > +		__sync_fetch_and_add(&cnt->bytes,
> > +				     percpu_cnt->bytes);
> > +		percpu_cnt->bytes = 0;
> > +	}
> > +
> > +	ts = bpf_ktime_get_ns();
> > +	dt = ts - percpu_cnt->prev_ts;
> > +
> > +	dt *= MAX_BPS;
> > +	dt /= NS_PER_SEC;
> > +
> > +	if (cnt->bytes + percpu_cnt->bytes - percpu_cnt->prev_bytes < dt)
> > +		ret = 1;
> > +	else
> > +		ret = 0;
> > +
> > +	if (dt > REFRESH_TIME_NS) {
> > +		percpu_cnt->prev_ts = ts;
> > +		percpu_cnt->prev_packets = cnt->packets;
> > +		percpu_cnt->prev_bytes = cnt->bytes;
> > +	}
> > +
> > +	return !!ret;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > +__u32 _version SEC("version") = LINUX_VERSION_CODE;
> > diff --git a/tools/testing/selftests/bpf/test_netcnt.c b/tools/testing/selftests/bpf/test_netcnt.c
> > new file mode 100644
> > index 000000000000..aa424f8db466
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/test_netcnt.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <assert.h>
> > +#include <sys/sysinfo.h>
> > +#include <sys/time.h>
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf.h>
> > +#include <bpf/libbpf.h>
> > +
> > +#include "cgroup_helpers.h"
> > +#include "bpf_rlimit.h"
> > +#include "netcnt_common.h"
> > +
> > +#define BPF_PROG "./netcnt_prog.o"
> > +#define TEST_CGROUP "/test-network-counters/"
> > +
> > +static int bpf_find_map(const char *test, struct bpf_object *obj,
> > +			const char *name)
> > +{
> > +	struct bpf_map *map;
> > +
> > +	map = bpf_object__find_map_by_name(obj, name);
> > +	if (!map) {
> > +		printf("%s:FAIL:map '%s' not found\n", test, name);
> > +		return -1;
> > +	}
> > +	return bpf_map__fd(map);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	struct percpu_net_cnt *percpu_netcnt;
> > +	struct bpf_cgroup_storage_key key;
> > +	int map_fd, percpu_map_fd;
> > +	int error = EXIT_FAILURE;
> > +	struct net_cnt netcnt;
> > +	struct bpf_object *obj;
> > +	int prog_fd, cgroup_fd;
> > +	unsigned long packets;
> > +	int cpu, nproc;
> > +	__u32 prog_cnt;
> > +
> > +	nproc = get_nprocs_conf();
> > +	percpu_netcnt = malloc(sizeof(*percpu_netcnt) * nproc);
> > +	if (!percpu_netcnt) {
> > +		printf("Not enough memory for per-cpu area (%d cpus)\n", nproc);
> > +		goto err;
> > +	}
> > +
> > +	if (bpf_prog_load(BPF_PROG, BPF_PROG_TYPE_CGROUP_SKB,
> > +			  &obj, &prog_fd)) {
> > +		printf("Failed to load bpf program\n");
> > +		goto out;
> > +	}
> > +
> > +	if (setup_cgroup_environment()) {
> > +		printf("Failed to load bpf program\n");
> > +		goto err;
> > +	}
> > +
> > +	/* Create a cgroup, get fd, and join it */
> > +	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
> > +	if (!cgroup_fd) {
> > +		printf("Failed to create test cgroup\n");
> > +		goto err;
> > +	}
> > +
> > +	if (join_cgroup(TEST_CGROUP)) {
> > +		printf("Failed to join cgroup\n");
> > +		goto err;
> > +	}
> > +
> > +	/* Attach bpf program */
> > +	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
> > +		printf("Failed to attach bpf program");
> > +		goto err;
> > +	}
> > +
> > +	assert(system("ping localhost -s 500 -c 10000 -f -q > /dev/null") == 0);
> > +
> > +	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_INET_EGRESS, 0, NULL, NULL,
> > +			   &prog_cnt)) {
> > +		printf("Failed to query attached programs");
> > +		goto err;
> > +	}
> > +
> > +	map_fd = bpf_find_map(__func__, obj, "netcnt");
> > +	if (map_fd < 0) {
> > +		printf("Failed to find bpf map with net counters");
> > +		goto err;
> > +	}
> > +
> > +	percpu_map_fd = bpf_find_map(__func__, obj, "percpu_netcnt");
> > +	if (percpu_map_fd < 0) {
> > +		printf("Failed to find bpf map with percpu net counters");
> > +		goto err;
> > +	}
> > +
> > +	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
> > +		printf("Failed to get key in cgroup storage\n");
> > +		goto err;
> > +	}
> > +
> > +	if (bpf_map_lookup_elem(map_fd, &key, &netcnt)) {
> > +		printf("Failed to lookup cgroup storage\n");
> > +		goto err;
> > +	}
> > +
> > +	if (bpf_map_lookup_elem(percpu_map_fd, &key, &percpu_netcnt[0])) {
> > +		printf("Failed to lookup percpu cgroup storage\n");
> > +		goto err;
> > +	}
> > +
> > +	/* Some packets can be still in per-cpu cache, but not more than
> > +	 * MAX_PERCPU_PACKETS.
> > +	 */
> > +	packets = netcnt.packets;
> > +	for (cpu = 0; cpu < nproc; cpu++) {
> > +		if (percpu_netcnt[cpu].packets > 32) {
> 
> pls use MAX_PERCPU_PACKETS in the above check.
> could you also double check that if that #define is changed to 1k or so
> the exact "!= 10000" check below still works as expected?

Do you mean adding a new test with a different MAX_PERCPU_PACKETS?

> 
> > +			printf("Unexpected percpu value: %llu\n",
> > +			       percpu_netcnt[cpu].packets);
> > +			goto err;
> 
> > +		}
> > +
> > +		packets += percpu_netcnt[cpu].packets;
> > +	}
> > +
> > +	/* No packets should be lost */
> > +	if (packets != 10000) {
> > +		printf("Unexpected packet count: %lu\n", packets);
> > +		goto err;
> > +	}
> > +
> > +	/* Let's check that bytes counter value is reasonable */
> > +	if (netcnt.bytes < packets * 500 || netcnt.bytes > packets * 1500) {
> 
> since packet count is accurate why byte count would vary ?

Tbh I'm not sure if the size of the packet here can vary depending
on the environment. Is there a nice way to get the expected size?
