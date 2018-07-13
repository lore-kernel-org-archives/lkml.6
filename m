Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21B0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4524A20846
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qg2M29/p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LB9AApAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4524A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeGMVxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:53:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35054 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbeGMVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:53:06 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DLYBaP016300;
        Fri, 13 Jul 2018 14:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=ftHX/o8v/Ubb6AvLQoJRaWQZPGaehbfzOxdkFtoOQdw=;
 b=qg2M29/pIpBCbH3lbtZFSg8+K9NCkILr6CTlFN+ynWoWs4yN6QiWpee2nobt33rgW9ts
 HQecEFPZUkFct+yHtECCqwhVQdeLVMs+kQi8h1NH2FNZBmK7P+Z0rFwrgsYKPBnsC3Wv
 bq9JDBbzjKytrdm6HT0nzuZktIyyEs1Jc9M= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k71v28cka-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 14:36:15 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 13 Jul 2018 14:36:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftHX/o8v/Ubb6AvLQoJRaWQZPGaehbfzOxdkFtoOQdw=;
 b=LB9AApAPdAefq2+i4uu+bJiwnMjusn/Pt7EDlb5jiPUrMxwtT2WEfiJc5wMvkGlYYXlFG/fPpozbokqnZE7wcUDFMojy6dQzEjiwsQEIElmsOIbctDtFx2KJBI2WPQam6y9nFkapMhX/ZPemU3Aet/97FFSWCQlT1VGKW1UV250=
Received: from w1t1fb (2620:10d:c090:200::5:1164) by
 SN6PR15MB2511.namprd15.prod.outlook.com (2603:10b6:805:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Fri, 13 Jul 2018 21:36:09 +0000
Date:   Fri, 13 Jul 2018 22:35:51 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 0/3] bpf: btf: print bpftool map data with btf
Message-ID: <20180713213550.GA5667@w1t1fb>
References: <20180712030803.875913594@fb.com>
 <20180711203010.51bab0cf@cakuba.lan>
 <e938c861-b341-22f0-7e82-215a27e2b74f@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e938c861-b341-22f0-7e82-215a27e2b74f@iogearbox.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:200::5:1164]
X-ClientProxiedBy: MWHPR01CA0025.prod.exchangelabs.com (2603:10b6:300:101::11)
 To SN6PR15MB2511.namprd15.prod.outlook.com (2603:10b6:805:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3005bc25-fda6-4e1b-ffde-08d5e908a6e7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR15MB2511;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;3:Tz0MftmryuWxUm9yfT2SyfgIn2Gg3p8EN+MH78WMPfHyeLL2cGBJ/77UrGy58Kp0Pkkb1+ngllXDCp9B7yyP1TieNW8k+sYbRlLl446Y8Yz5IHY4xPoxXUb61wgy4Vn6yzE/2+OSY7XeUFXE9hVQskOEsWC7c38RamWbwSEJAXMo1bG541Fp3A1sEMlfm7IXooPDSOJKQdp9qQr3mCvMGzfjEYnFEkgSNnXIz+guv9A1UlaJTlXYEhivXWJdERka;25:/GAMXK8PdgpDqzPF9tAxl9Mog6cB2jDGETAVmx8WRnuFDmecTTItar/6G+DQS1+D3mC2wayDYExVsLBzlR+wgBQZKZVFos+ZkWIY5Az20VNOAPGxf8n6xbZC5dxxw9OUu3ARQpXbcgOHMXfrXjZ8ofRxoIZYXo5UiBqzOWjbs5AiEVnn7+Y3s7mVMAfGSl+isKVmZuiY3OHfoogy3oCeLXfDU8kshD+BA8g3QUHjNqVkTAmOIeY2RZzyjQnca77qD0PyubQ4nN67Zy9BtTVKyLHHpGgEd8mLol+UtcqErajoYDNTghOtujM1KZoTiwfDnUDhwAUuGjxAOqJAkL2iNQ==;31:3sSDlOQEO1YsrzpV8vEdUwxXgWO0evIzV9/faG1rreIFPo52eytKxa6xYOYe3ridQwoFjMyj4wqebBNil2G+fUMDHDYYYPT3sCloVb3SoBShIB5I0RFJvzEnB9Ag7dUC59YFFYPF1FnoA10WISuLehUcdcdkzXKv2oRJdemPXnWghKP/iUyPUEgDJB9TYTmV+NAdyCqCY4wSPxoX2NOOeB/yaQ//gcynojwH5JMB3rU=
X-MS-TrafficTypeDiagnostic: SN6PR15MB2511:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;20:ebO6u7KsEP/VQVKRgAE5zgJzjK2zyRVAUlJqtMicUAFY3N4gfdxlCuqza/rhMStg/mnigCCMEKuEdkof+3gCXPIJ3Enz4xLaXEyIpUOIL+L0KJE7TZgMyn+jNTe2PxD0HUZj/Dx29dL4T8621J36DOaIExJ2O3v/RF0eI5cG+O7RzyakWE7erg1wlyiR971Xhd1Qp9wlU5JQve8H6OZcps8PXv95oZH4ylEC8Ot9t1dfjEtSySNdupI5MDHGPXSPQKa4Bp8HOUDP33PNe8q0FMtZ9jF9JwoL2Mtkxe2ll4ZISP+T9ypNGqNrzXkNh9qEpBA8zjp4dJRenKbjVpdClouG38A4J6bjKOx+HlzPxqhXH8VdI+paILFFWb2nwKxpH4HVvjoAjOcuD/FwXRgM7OGlxX2sCJAhInUmFpMrMDm8TLEyJNYn9xEDbnikCSUDeKfKDaSsmctKJvWVReq6j6srkkL9Ts325tuJ8JG67Kz/HvsW4fKNNQ0vaWI9njxe;4:4BCMavxV20chLPWsVp4FWGmaj7zyasBk33D1E+3W7lzeIJk9WxJ/gE3AGbXpfnoDZVhGW9MwkB5E2DRAskJ6KYhJPj0C2E3Jp+P4EF+YYzdnDbVdbVi/jJDj/vm7qGVVIOCYd0umswgSNSlh0x733xPiDu5rwJjPYHXr+ixYuwMdDF/pO+2i3u6iX5s1Ka4rPGYPUZlh7nEAl6GTy9cQfnydoRhjH3LlfoZ33unbZ4ylYik5t+PPP35TMNoeIMhqWZmYpj8f41OXIMMnb+/Zz83Nek4wCdKRIvy8BjRl7u6P4gq5VwgDxhfB0wxFN39n
X-Microsoft-Antispam-PRVS: <SN6PR15MB2511FD8DDA48C6D706182B25C6580@SN6PR15MB2511.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR15MB2511;BCL:0;PCL:0;RULEID:;SRVR:SN6PR15MB2511;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(6246003)(68736007)(25786009)(39060400002)(8936002)(5660300001)(486006)(476003)(11346002)(305945005)(446003)(7736002)(81156014)(54906003)(76176011)(186003)(47776003)(50466002)(46003)(2906002)(53546011)(316002)(33716001)(16526019)(478600001)(4326008)(81166006)(58126008)(33896004)(386003)(16586007)(55016002)(52396003)(9686003)(105586002)(106356001)(6916009)(97736004)(5024004)(6116002)(229853002)(6306002)(966005)(6496006)(23726003)(1076002)(53936002)(6666003)(86362001)(575784001)(8676002)(33656002)(52116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2511;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR15MB2511;23:OkYNMpEx2dlIERoZGw7KP06G386akT7wnY/WwrLnp?=
 =?us-ascii?Q?WQM4udQF6xIY6NsfS4gUlcXU3TrHekKSB+VWvX3Q8mSr51qXa5lnBoXk6FUW?=
 =?us-ascii?Q?SS0ki+ENwnHm2wfyYI6JCXupgauhuS4y6MslJWuCO8Z+M5Em2FLFzerFcFQA?=
 =?us-ascii?Q?g7tOj2BNdlXlFDCliDGuQQa+kqj0LjdFvEb43fZyZGRcisr7rKaWfNDHy2s0?=
 =?us-ascii?Q?6CCdOw7bLAEa0XGa7+9ITqpryC23EPJznIkl0aSSRGQ2F1pgIqlAH7ZctpP3?=
 =?us-ascii?Q?D6a/lqMlMdPhLU8kCetMaXPmo84qFvZRN9aDyvuBdY0FBNQm2BjEHPLxjpu3?=
 =?us-ascii?Q?KYgDF0FUFMm4QTsaCdlLrC13ia1vWO081y5RG/xy66E4C4P1IS6AOnhygalo?=
 =?us-ascii?Q?56C3pOvOwdEMnNfFZ+I2acFaLOM4Lehh8Iq0s3p+q642CL0IaaK8B4Rj9z9e?=
 =?us-ascii?Q?V8f91U+ft1gohkW+bTe1NyQayMDpyOIi8arhEge8a+xdvYNh1rJTai96XETc?=
 =?us-ascii?Q?DyFa3GhF489YknwjupgaQ3y17eSlxM74REB/RJdfuq5G7LhNO28we2geWnOD?=
 =?us-ascii?Q?WWifqdQnclzDEVRd5xfl9hsv8JLksdGx3fCjh30GbEX02KtGUKqtNRirPclA?=
 =?us-ascii?Q?7qNz6Nwnw8OPVuLc+MF1tJvLVD1pRDUkeL5buPMTGQuVhIBvJq86ox5GF7JJ?=
 =?us-ascii?Q?DugUEbXRldM7gj6afOoacIbNqd0BpyJ/GD2Iv52nXtm9OemfHhCZEWZCsHnm?=
 =?us-ascii?Q?JrS3SdMqEEvR6qlfmxPZ4A5JqbPHPI3Zn9h5uWx+GwwOT8QtB88pqlq0W4vQ?=
 =?us-ascii?Q?n4AojRc0luQF0L/RKm9Zb5D0kreKnp1utKF8l58zc9K5l1XOm8dJwheqG2t0?=
 =?us-ascii?Q?NnkXnem0QXKb3MAxMi4uB3hHzrYV5u0qexx7e7LSvH5fHVj3YPZFSZx4V5c4?=
 =?us-ascii?Q?3D55OtiXdlIrKx7T0s2/QdmUEMzE+bbShufsjnQOUbvRbgp76BOOPeba40i8?=
 =?us-ascii?Q?g+4pnaXKVaZTvY5Qnf+2VDVpG78o4JNkxfuGoVhLtdw8Ss9Q3CcaMIclSkDh?=
 =?us-ascii?Q?lj98hmmTBjAb/2BQSTdqrtBcVgyL8NKB7pOIFGjA8N4rD7evbrvhPT4IBrah?=
 =?us-ascii?Q?xW8rR2g/4LM+bq9vLQSQXoD+7HWnzChU0HwlBvu2NuMb411+29eXQPDDsdVx?=
 =?us-ascii?Q?1qKo8rEjtEJzg/qOD2MHrgIyajjuua9/uviQd0WjNfkU5ncSmS6o0VG19Zpq?=
 =?us-ascii?Q?P9HWqxgyeX+lvATOKRimoKkjwlaq3yatJgdnRX4sh1uqV5QLcIAdIcXYiZjs?=
 =?us-ascii?Q?xpG3ykRVLLkYWoojWOnnKJQiMDk7PlE6Bh3Tf7Ambd9Vr6mVTUzuI3Ul4zVP?=
 =?us-ascii?Q?okLJIfrU7JbuD9WwDUvS38yF0k8S7Npz4l1nCjaeGOdp0ow?=
X-Microsoft-Antispam-Message-Info: pNC1cSi1Qd54lmCtlpJ0hzNlGQByX+kCl6uX6XD2/x6lQnb6Hk9vQLMFwyEg80kcTkTdam9gUe5kGKyDtAm6zncWOkz62H7ApwSEd4kzqn/a/+JiEXn9oES7/UhH1Dlw4LHg+QNjW6iu1pwB4UPXlEQO3h3faYNuUCFRhQKPITFztbwEStoz6u559tC/Jksu4nIbrjJcfRXfGKW+4NZ30GR9yol1XVhFwCzLgqY98OtfFOOpfRXPZg8B2j/hFaQTfDDGbMj0Q2XRBQjIciO2hWEvPZdwKCtJ3SarsoGMs8UzN8g4MoDTrMFNV76nTLrwmBn8Ogf4Z/cCYID5U2+BuXHcmV2Y1PJpSLy86lk/hLg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;6:SEPszntia4zSam2e5Tqg7CVVKLMdUY+SN/Niqu5g63Cl8lp0VO04EkXGih1Tzs7bvVnZRWQbsudfHwwUzGa1LYiUZWKuLljcLuLVlyI9y1xCpOTZ4RfP+PVJO5pEZWfCKJ//n5lqZTC/IERTizURZ5fO7Ez60iNdLFjjRn0gQJni5f8jS858w6JZ462sEKeDeViKUVMAQvC538fp/5QlYQzC2lhV/bq/eNmsbQ7+AmqvsnqQHS4ms8BYzhFZ1SOsv1oRZ1LnjGmmElanFe5kTTmxrOjOSaqXAoV15cs9+48bwES0ZyLpgU31S/JLWZ/2MsSd/9cn6IlI0UP7/QdvDHmNIGpwTRgL/rUcS971L/c1JhrAsWM47nmNxbgF5xoqiJE9CYlF3ft0GwrZXJFLxIfe5sdsYW84b6rGQFhx0DVCHUORSOdGj39Dtm8ZXPJmSNu1Hl95tDmenrL0z4wGRw==;5:TiqCBUPvMWmc1nJaXEbuLYLpzP7/zPVwEa3La4657KypoKt9bGIxByMg3+ZjFbdX2aEyiUfl3r5Uam3z2roxUhRLlh/aHw4XFMemrPHnx813tDI1VHRrpmE4Vn/x26Ma//d8A6xrDDL52V0mzkm+DGdg/j75Ghz6ZTGXgEpobzI=;24:jTHBQoH5eArQLmqPAL7TG0yu7NrMPW92NeKfTw8n/6cxhpKYMu/qdiuCskoSqcws6/TpxZ44r0+kBPrmwytmgikQF6FWk8zKXbveTgmbRdM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;7:p4rRXDj0eZXROBqEGlB6KwubJ/UuyjFDdGNVPY5v61CrmmKnhQK87UL1AlkLgyZycoouTHLyEKtR0eZhqg3Pun2rMhr7jQZDDm/UaEPyn93oCBjCLlwdW/a+BMKxaEVQBTKr2SXW0hnLVrsPrxjVAJDGzelKdBh/+mivbuXtUWsUztLId0gJNFUvKfzQuKPrMMdgoijOzU1DmEaj3uWWYUiu73BuM3IqIRgY/S/Bb79gidBbAawiOWHnr3bbEC5z;20:qhR24GdG71ln8/dLo0/Pu/fkrRl7eE2lfSKZIAMjCd7SBaLKogWms93u35Bhnpdl+V9WGU7RyTwGpFIhE1yDg/dNgMYrApw5g5GR4hsXVbQtecg0U8P8xFaeaBFcaeeih9FmNSvnV53Ia6fTlxYXNvsWJdAsws+1IJm+dTtBQTw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 21:36:09.1771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3005bc25-fda6-4e1b-ffde-08d5e908a6e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2511
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:49:01PM +0200, Daniel Borkmann wrote:
> On 07/12/2018 05:30 AM, Jakub Kicinski wrote:
> > On Wed, 11 Jul 2018 20:08:03 -0700, Okash Khawaja wrote:
> >> Hi,
> >>
> >> Here are the changes from v4:
> >>
> >> patch 2:
> >>
> >> - sort headers in btf_dumper.c
> >> - remove extra parentheses
> >> - include asm/byteorder.h
> >> - compile error when big and small endian bitfields macro undefined
> > 
> > Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> Hmm, strange, by accident I just noticed that only your bpf fix ever made
> it to patchwork, Okash.
> 
>   https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_netdev_list_-3Fsubmitter-3D74458-26state-3D-2A&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=4wHrS7MHHFLZe_WCJwRVhA&m=wkiBQFYWPyiN9WONHLY0WiZxcOwNRhXaMMLIE551mCA&s=RggQzClRdkwawboGLPgPXHOdUtYffxeOwlcBlFru-P4&e=
> 
> Potentially because you've sent with attachments which got dropped on
> the list?
interesting because i send all patches using quilt mail, the same way i
sent bpf fix. i can try git-send-email.

also i dropped Acked-by as i changed patch versions. is it common thing
to do? or should i keep the Acked-by?

> 
> Could you properly submit the series again, and retaining Jakub's Reviewed-by
> tag to the patches?
> 
> Thanks,
> Daniel
