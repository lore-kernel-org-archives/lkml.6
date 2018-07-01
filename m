Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8DFC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71892251DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gS5KZm6u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f6RjlDyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71892251DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeGAJcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:32:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54416 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752227AbeGAJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:32:31 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w619TeOZ018737;
        Sun, 1 Jul 2018 02:32:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=REEBDgPcjSY/XoZPiX+wmXusn+1+53U0OSx2GPiECc4=;
 b=gS5KZm6ucWqG2WdXnaJ0gebPHSKskKvF2OciPLwGBT91umT71VmapiUOkNuODhVTBbty
 EB8pCA/Hs5un1/mvf2wkyeqtuIxbQ1JznLL84hN/8kri902qMCqJM6lNQSAJji7xtV6U
 VbqUNkf5G3VEQco5p+nJ3CHoj5h0wUxWswM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jx7jc1k8e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sun, 01 Jul 2018 02:32:07 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB13.TheFacebook.com (2620:10d:c081:35::22) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Sun, 1 Jul 2018 02:32:06 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Sun, 1 Jul 2018 02:32:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REEBDgPcjSY/XoZPiX+wmXusn+1+53U0OSx2GPiECc4=;
 b=f6RjlDyEXViL51WnBfWxw3cG2V/YlLmhBPg064inoQmZGtJVRD4tuLFZeQv3kdUptgl1iIqgD9iw3acKXAwszXtB2SOtiCktTZZeArwEPRfxQXiCCpP5Uh4Xs1vk75Y/SKUA9VU2AU+ZiZf7/90+hl2SMRYna3BnWajOH6B3oqA=
Received: from w1t1fb (2620:10d:c090:180::1:6504) by
 DM6PR15MB2508.namprd15.prod.outlook.com (2603:10b6:5:8f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Sun, 1 Jul 2018 09:31:43 +0000
Date:   Sun, 1 Jul 2018 11:31:47 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180701103146.GA1388@w1t1fb>
References: <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
 <20180622163200.20564ec4@cakuba.netronome.com>
 <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
 <20180626164820.GA12981@w1t1fb>
 <20180626133133.618af1d3@cakuba.netronome.com>
 <20180626222709.fsznwqauxojhhx7v@kafai-mbp.dhcp.thefacebook.com>
 <20180626153559.0511f709@cakuba.netronome.com>
 <23968d53-2895-f0bc-a38c-5bc99e1846ab@iogearbox.net>
 <20180627114737.GA1580@w1t1fb>
 <0360a47f-1056-3117-31ec-7c3f5d6dbccb@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0360a47f-1056-3117-31ec-7c3f5d6dbccb@iogearbox.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:180::1:6504]
X-ClientProxiedBy: MWHPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:301:39::47) To DM6PR15MB2508.namprd15.prod.outlook.com
 (2603:10b6:5:8f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cee3b16c-3cd9-415b-e9e3-08d5df35762c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2508;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;3:KWPq+XNvVdrWzzlcYNdlbzAmkn0kRts4pvAy+KqZUz20P8YlKiCw3GTkV32dlVER77bd6y+oLKFPNkS5+ER/RbEBdLCO6CDfZvWjAwIqQvrM7bfPhA1wFmhQtzb0xTpdvaHLgDjB8hr2X5C7sypPhCN3oebRZSciYakyc1xm1vV7hpLTbxu6QEZUGC0tG0U84/nNA8ZvGadRLzZ6Kw5dM9jLH52nQiaqfi/127wmzg1Heict1RQhsN0+lXDnNIVs;25:Y9HzL5v141eUl0mDRmOGsYfKZIj042O/fNFujqHXQwGfgR/kvtnxQqJuBjAHANI/uooZlSlgJ95y1JcvbS4D9VH7qi+AGINUKEL+vgB5ZVhUlAQ6+RibrPEA8rkYqpIetOoTh20ZRwD3IcXpwQtFgs2ZJucA6f+A7Jnz55cH9XvkIjanLIMvf0BN8rYX7yINu7JfBvLud61gPGdZnmxax2DIQA7nTQqq26vp+o8uhtZrf5JwBvFPk8HnfZ99iwWAHhDUQvazYfTLsNhiHZ9m61pjtiSp7/gqwdDbYfsIoXwqtD8apQlmKzlwdqzvxLm9Bcu0w4L63JFzhZLcLeHwKg==;31:5GDbN0uyN5cSJFdVKgkoFhxNZuqIokzdgNNcT6k5yBM5rKfjn+BenT1UNvleFQkxjyFSo3GmkNDrcEZNEBQRSetPrIZ/xGa12kycAKt5OUtoi4M9Tlu0bpyq30f0yK0wPAa+AiZPvV7YcxnPqqjfg/OYMtG60oMfdRWGIBxEwIOtYIOszBECaueLZO1BO1jDLEd1R+gSn6+ySBVrZY0EQjgnobey0O8sufq8IDMUKIA=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2508:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;20:WPjCbfP4P1keSjwTAJ891fFZpH+tW2AoDFuiZtq0L8ANZoVDocXeNgIlmOocux4+pf3MOOMUcybz9EXzmqFqNVlMLA9kH8HITxfnfStM07By/N7d49mDPbiSk2Q8ZHbTuy/BuJ2ui2/Dll5fcZsXJiyoOLBL5jfNNOy6HWBwH9w50Bex0LmRs47LpC0swvACvMEAJ3k8sRdduAb9Dmm6NAbkBmlVnSi79zJqIXOcVCIi3to71pGhkagWe/OECCdsXKPPkbXHhqG5JOZg9znRa/SQMd6leOyvgUWgRZCgYeDwbi64p6y+WVa8RbQlitMwDVsfkQ5xk2ttmUwP8DjtxgWR+rcDLJnytQJ6jAhG9HUVBvW+dUejW7xqksurIlBqUbTuyk/7FzjMQRcKlUqAirtio7GTDBfDNvF3HlCa9QAabwc+EWkLvRYHPUSua93hR+VqsYnZNlIW50nVTrLrcgaJhOucfGZynsW+0H1FuGPZLJXXJVBKMJXdF70tXRBd;4:JgcrGgC6m8SS4UZBoC8oH5LeVHl9j1MyzKdXXidIY7zwgJLnZDYDK/51ca8E0pyn+q9Ll5E1h5vtrc78Eadd0wTNaRCln6SmBemiiKfSLOFHNJ8MzkYYaYBMoOL+vxARLH4HLZLpUsUIi5K3sDH3sCQ4Su130TUPN32EZGGVuPvYFIzW2Omd/K1dpH6Oxl74TNiXL0/8HDrHYYAxGRL/BjD5reVIBqVctN8Mp4TKxVHhKl3NGpZw20C/UP1jybpQNgkhMMHMP8wVlAtWL++9i8ZsREctTLQjJd7Ex17TEwgsJoHTydcrV01qRnkbNt1e
X-Microsoft-Antispam-PRVS: <DM6PR15MB2508D2FA71E8893BFF464698C64C0@DM6PR15MB2508.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(100405760836317);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR15MB2508;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2508;
X-Forefront-PRVS: 07200C0526
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(7736002)(81166006)(81156014)(305945005)(8676002)(33896004)(52396003)(76176011)(1076002)(39060400002)(105586002)(229853002)(33716001)(86362001)(54906003)(50466002)(23726003)(106356001)(6116002)(55016002)(52116002)(68736007)(25786009)(476003)(4326008)(486006)(11346002)(6496006)(14444005)(6246003)(47776003)(53936002)(2906002)(316002)(97736004)(6916009)(9686003)(16526019)(478600001)(5660300001)(186003)(93886005)(58126008)(16586007)(33656002)(386003)(46003)(8936002)(53546011)(446003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2508;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR15MB2508;23:d2OK6aEwdWkXZnzfwCZ4uVvxtCCmeP8LKivMgIyPz?=
 =?us-ascii?Q?/YknYE8XML82dlzsE89DXcfyKoIiMcCxtRE+gb4qYefu2K135YPVEgQdeVjS?=
 =?us-ascii?Q?b6/vK/LD9FZqPXPYrPwDjedG6w570bGaHWwfVjezH5denCJNxR1MBDTVWcmk?=
 =?us-ascii?Q?kWcbELVgIBFBGN3Gor+A0EnlHioAoo9KP7qk+XUciU0yPSEf/SdzXM/pzb9j?=
 =?us-ascii?Q?3n5yIbRVZLcRJ0Nt9HC2k8FRLvGs9i0NKMfvBvo+mG1oEY9s6v7zZfOQClhv?=
 =?us-ascii?Q?9YyIMLmpIwjAkxlbiKkF2/jaVSdBaAMFxKw9W6XZSQLCZsw8jhztXofB87Pe?=
 =?us-ascii?Q?0UEcc/VTOD1fdY4r/4gyYFUiUcYWhAJcUTC6zd22GcyDgM39HC6pBqxqvXBq?=
 =?us-ascii?Q?qtlHkIfsh1BimPhHpUr+AEAbUA7gpsf95cSxct8memjmuGTCNRuReczUP2VT?=
 =?us-ascii?Q?M49FCA+52xXBPOcWn0ueOkSNuqa57SHj7QlohMDkvvemCMHB2UaQltBgVjmA?=
 =?us-ascii?Q?9aXVGwW1MbUrKFVfA2Qup+89XZCw0cl1zr+ksyEzTklOfs+NwqsspP8EgvQY?=
 =?us-ascii?Q?iP56yhIBgNNCTeNUK3xgAsOkNa2NCMUO+yVOXpjvVnP1AqXFRdpGXDQnsFl2?=
 =?us-ascii?Q?p63G29eYeHJyhHXe1bWgy2ar/3EaDE4W/lcg3/BmRyoj8pQTpAn4gcuguAMD?=
 =?us-ascii?Q?P7VOLBSObR8jttNdLTG+VRDEugPvrrK/DBYExk1+1VE89iV3iRHW8Eo47+aW?=
 =?us-ascii?Q?JoPpBEDi34pFR5BibRQ6epvWhEKnSbCONp/qRk+Uok8LQqq+cXHKV1Kz7Gf+?=
 =?us-ascii?Q?dhO1H/5PD3eNHAG9FW++A23U96N6hSijiX9Ur1oD/6WxLvoDBmWTsftT2z84?=
 =?us-ascii?Q?lUkY9cneGoPgrguJainDEAV5fwJVb9ZoinUV9SDZqBru+7JcbGhcu7/USjSA?=
 =?us-ascii?Q?+daOp4oBKT9si3ixbqW9AkNkMyQ8gRB7bERW7Jv24riA30a6lhc7xYqJ3Tgr?=
 =?us-ascii?Q?s+PjYRjMSj4ZLCqxDpKGFq+VAXGpgBTl9o821hPU4nWMjwmkgw3gc5MtB2yo?=
 =?us-ascii?Q?S+DV88NVeQ7Bj+ZMATKKVvg9bypgYTVMYv+jmvEtRLUxN7zoi7cED2Cc+IhV?=
 =?us-ascii?Q?+jeELhrACI53gribU08JXEudx1Alg03V+57Cni+PfhkjjVs8826nLPw+dDf7?=
 =?us-ascii?Q?2qAyAJWbDfIrwhIBuuE9a0SEV57DZKeNh2njmD8KeIAskflMjGt3qhwGpsv4?=
 =?us-ascii?Q?diwWbNHWm1uTudnb0sG9KkvQa8fikJMPmCF2PtHyJnuYfpaj7qXSxdDxlfaP?=
 =?us-ascii?Q?LAtOI3NeRAlwJaNSF9HNNM5SogKOCXlkruhHj9z3q+w?=
X-Microsoft-Antispam-Message-Info: UtPmSzRCJ6gxfevYhliODxiQK+vg+doDK/KOJM7b3dcfgvhgzg46Z4FBA+nClkOS2+ZrbXLKwS4E62gDF9JPKzV3mLW+iogQEG7sC2BDIotPm0hsJBaAuSr6c9nCNnpFwACSZzICOH0e4GW98DuQRDKJAAcBa+DXjN5bf0R9vVWGm6NnsyZ9uuIA/sdGLD1zpj5S7/9ZsF2nTW3yVo5Z6W3ZtiZi1/nyvJSGdECqY85Bh2mxYB82C2OvD2IuSkCJGWXtpcvR1diiTz9mV3QkU96j5E8/pq7t/w4jXUAIpdwrakR6AIi+Aabw2MMoXT9Kx0iA/rl/036OKGAyFc42gpYMnSS9eGL+E1WvMsBbtdY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;6:JpL6YaV4k4+Vhc30fI5ceDWwRrgK568ZL+ZWoIaBDoPwBobfEWpgxAG7jFxPR6KagWB6b/i98z0Z2A+xWWzlrKHAzx7bnCHL80sNjkDwn+Z4kQI+97x0T4JFTrzMDyF5Ibak3b/IVphhRGRLNGtTTcZjgtTXJeVAgmCB291i9rZVgX844d8Ilo45KUvzdOIdUAwmOjvQKlZcjiWUStQtux+2BTytL1uzyxmD1jsh47UDCLdEz876mcc+HBFSKahEO1LogtQQqZ198dSj0PAg6b36t20Yn6Y8v16xdrQcdOxdbZVLaTjFbuHDNOtCFzUDr1JrSv0mbNFIW40JJF7jutGk5IrS8gN/G/6FUPP6YIJ/nZjMP7tGIjUagRVx8g9n0K8jJFJXNTqEtr0AB9qTjm2UebMSm0n0vvs5LXGvWJEhgOR/XVgwFDHoeVm1uljp+5kuKTFvMZY/FyZzXIfSzg==;5:RxImVIYXAmoa1Tq+gKofRlHEOYAtGr+mRnvKcwDX+D8l6xf3r3f2wAdD9ZbChD1VznwRww9qs2VXk0S73h/yu/Yfy3UHhJzHeJezhVvPtA3MakAgzk6CrEOOVBqb+5PxtzilFiWsF/oIitILnGDWukSm5/54vpp3G6NWpkGskhs=;24:HPgWLx0b+ycY9Z1K09rW9ccxnQpD8dlRsZ/esektzURSrUua0AuYjZ8FjinfKBJMJzD5c33FS0+i8anN61Did02P3JflCvKYCE4cMDdVa7Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;7:XeKgClxbz2ZDtSx91bgQH+bv+S45NRileQT4htFg2Hi7xAmS4ujAkkfkuZB+cvCeysHeFkGYKyCmwiOvgg9nA7TELsvJycRwqlkZyUpi2FACjkufwNZy3QaqML+faEKs8OaPBzK4d09+I7yKJzbkbSE2Ywhucxuv19FEcrEIasrRvHE46imHzLt5fosuURHEuT03H4nb7veCS/j13V+XUobGuEOxs8RDoI2Si1cpoXqziCURhu/0lGRFQxx2lNGt;20:3JBnT3cAFRZtbL9T0JwHuaj6mpA7mRkt55cs4zOQlzWaD8raDThmGw/kh2UV/I9o3f0KhpbMj9diMHfjL4TSa70mWdv8dTf2wACGK+xR9S8eS5Tl8SQBNq1JfZ+EKV3xRRH5Etxu1by5dSjQ1dHsa8BR95t+yZbFDa1LsG+9kXA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2018 09:31:43.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee3b16c-3cd9-415b-e9e3-08d5df35762c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2508
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-01_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 02:56:49PM +0200, Daniel Borkmann wrote:
> On 06/27/2018 01:47 PM, Okash Khawaja wrote:
> > On Wed, Jun 27, 2018 at 12:34:35PM +0200, Daniel Borkmann wrote:
> >> On 06/27/2018 12:35 AM, Jakub Kicinski wrote:
> >>> On Tue, 26 Jun 2018 15:27:09 -0700, Martin KaFai Lau wrote:
> >>>> On Tue, Jun 26, 2018 at 01:31:33PM -0700, Jakub Kicinski wrote:
> >> [...]
> >>>>> Implementing both outputs in one series will help you structure your
> >>>>> code to best suit both of the formats up front.  
> >>>> hex and "formatted" are the only things missing?  As always, things
> >>>> can be refactored when new use case comes up.  Lets wait for
> >>>> Okash input.
> >>>>
> >>>> Regardless, plaintext is our current use case.  Having the current
> >>>> patchset in does not stop us or others from contributing other use
> >>>> cases (json, "bpftool map find"...etc),  and IMO it is actually
> >>>> the opposite.  Others may help us get there faster than us alone.
> >>>> We should not stop making forward progress and take this patch
> >>>> as hostage because "abc" and "xyz" are not done together.
> >>>
> >>> Parity between JSON and plain text output is non negotiable.
> >>
> >> Longish discussion and some confusion in this thread. :-) First of all
> >> thanks a lot for working on it, very useful! 
> > Thanks :)
> > 
> >> My $0.02 on it is that so far
> >> great care has been taken in bpftool to indeed have feature parity between
> >> JSON and plain text, so it would be highly desirable to keep continuing
> >> this practice if the consensus is that it indeed is feasible and makes
> >> sense wrt BTF data. There has been mentioned that given BTF data can be
> >> dynamic depending on what the user loads via bpf(2) so a potential JSON
> >> output may look different/break each time anyway. This however could all be
> >> embedded under a container object that has a fixed key like 'formatted'
> >> where tools like jq(1) can query into it. I think this would be fine since
> >> the rest of the (non-dynamic) output is still retained as-is and then
> >> wouldn't confuse or collide with existing users, and anyone programmatically
> >> parsing deeper into the BTF data under such JSON container object needs
> >> to have awareness of what specific data it wants to query from it; so
> >> there's no conflict wrt breaking anything here. Imho, both outputs would
> >> be very valuable.
> > Okay I can add "formatted" object under json output.
> > 
> > One thing to note here is that the fixed output will change if the map
> > itself changes. So someone writing a program that consumes that fixed
> > output will have to account for his program breaking in future, thus
> 
> Yes, that aspect is fine though, any program/script parsing this would need
> to be aware of the underlying map type to make sense of it (e.g. per-cpu vs
> non per-cpu maps to name one). But that info it could query/verify already
> beforehand via bpftool as well (via normal map info dump for a given id).
> 
> > breaking backward compatibility anyway as far as the developer is
> > concerned :)
> > 
> > I will go ahead with work on "formatted" object.
> 
> Cool, thanks,
> Daniel


hi,

couple of questions:

1. just to be sure, formatted section will be on the same level as "key"
and "value"? so something like following:


$ bpftool map dump -p id 8
[{
        "key": ["0x00","0x00","0x00","0x00"
        ],
        "value": [...
        ],
        "formatted": {
                "key": 0,
                "value": {
                        "int_field":  3,
                        "pointerfield": 2152930552,
                        ...
                }
        }
}]

2. i noticed that the ouput in v1 has all the keys and values on the
same level. in v2, i'll change them so that each key-value pair is a
separate object. let me know what you think.

finally, i noticed there is a map lookup command which also prints map
entries. do want that to also be btf-printed in this patchset?

thanks,
okash
