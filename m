Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCDF2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fc60SGi8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PxdrHb43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCDF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeGPWjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:39:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729245AbeGPWjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:39:13 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GM7lta017171;
        Mon, 16 Jul 2018 15:09:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=UtwC/tk2CmIwywKkFSnhK9NMVhM9ctrpgWHZMq2l6Bs=;
 b=fc60SGi8JfcvTZz/PCi9DYxHZ09jQl3VKqeJkMI4DtRNT9ckTIMjctMkl3zGa6RCEt4N
 B2MVgpYBFEuxKAKWa/egfrcm4DcJ7Y1c/GLoMHEQJZDKKBeXpGZcZ6qBooTBYEc6VVTa
 2x7jm+7ML3R5csZ3SU/n4BTZEhThnm0svYo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k91twgbmj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Jul 2018 15:09:40 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 16 Jul 2018 18:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtwC/tk2CmIwywKkFSnhK9NMVhM9ctrpgWHZMq2l6Bs=;
 b=PxdrHb43VYXefhy+O0TUtGA3uy/vXF8QIOKWTGMszfVm1woCKoO1kBvtZrN5YCFN9zRV/R7OUwuIT/IqMfHymw8vk2S3Ja61m2FDh/rf8HePZvXsTe/gJb18E3YhDQvJUZA/dG4wQgpUMsxVFJ1aHQjl390Fa2VuEQjKySd1zpc=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::7:d20) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Mon, 16 Jul
 2018 22:09:28 +0000
Date:   Mon, 16 Jul 2018 15:09:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@vger.kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
Message-ID: <20180716220918.GA3898@castle.DHCP.thefacebook.com>
References: <20171130152824.1591-1-guro@fb.com>
 <20180605114729.GB19202@dhcp22.suse.cz>
 <alpine.DEB.2.21.1807131438380.194789@chino.kir.corp.google.com>
 <0a86d2a7-b78e-7e69-f628-aa2c75d91ff0@i-love.sakura.ne.jp>
 <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::7:d20]
X-ClientProxiedBy: MWHPR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:301:3b::29) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28def2c9-202a-4509-7640-08d5eb68cd24
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:HGMYoo8rlrUn0Q26113f8A0T8m9vIAA4Y+Vqgckk7RJ77HUUD/jypX2YovAWc4HYJONoPd2Nl8y6UlYzLJjLR2GQIdzJks5VoP0d8fszwAnz8GaiQIv5qVhWKZoXXK/5Rv4mi2cQ8YeEwHhQTBfxdG+4fNAPmGP5ft3iGjOAkS+jB2lBNlSVybu6Lss06+rcqGPK97UNc6PrvQ0/cb7o86LjXUvSZcZc0k2DCdt4Qf5EFvyECSAypsIvdc1i4n1K;25:RXkMcittfmKaau3D8z+67EpO5M6cRH/qpsfPM129X376UdyTWMjRh+GjEJU/kW8PJ12bbHy9Tctl0+3FeCmhgwk6GWA0XQzhTecTdEALoVLqzJHRGwqv3BBryoy3dTzvl4lOozwwl/KxcxSzSSgPubnQHZbDu3pqimwbcS+9qJsC8WHpx4gi1V5ucBQu6gby1WzrIiBVjuzV+cQYw6PFUCilXl8cYlGRusYI2rfQbf9CTj06vSCOiJehIexYeZINxiC6Ov7nSD6CWa7bjH1+n+jAMtz4OSVhErbPisziZKH9/AKmjTpd3LoXHDbb7jfP4Ha/B+nQu4ZsBnWutaGMtISvDwFDRTEoPmKn/Rr5X14=;31:KKMPYgXEpDuatQ3CmNCdK1jqPx02VSFkhofoMo5HGORwTymoLxMiZvik4VVpY5abv021q69AwSMk5vmtPSJ1Puz5xAPg4RTQFFZ4JsR9zOe8u6OVh+G+7PEU3qk/Nbmnvm5ml8wbLxPIrjdxUtU+oOxuGjWsaeXDeH4oNtOo61HUJBH0hVyJMJbyPz0Xsovo15p2PAbhf3+CKyIsQMrEeFfQOz/8MM70qesJvoG8n8Y=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:gepL70Vqe0h/R1Zet+LPcmEBe1RmGXZll+UY8WZizX6pXVk2NhaKoVJ03UnlHaOcLlFRGJ1QXuRmpEib8L/NiFLJ9X9BZheEItRSWSTyxm3KkaYTJsgimhIeeuD3paUECYdp9WvEr/RuBQYnWMJYGiuRC1WhQlCWbOw9CJT7efSXHeFF7ro9Aoz3fLZTqLA4icUr/7C2rMx7Y0Xa08NL6nZE3ZuNTWi/w0hm91/znlQm1U0fLp4MvmVyDL/gF0Zx0sQuudn8pH+PCC71kg5buVxYyqFxB6Kh6eYLs2XctvyA7Q69yNUriJRDirauEBUUEocmeS0HShy7gLYz6G9XTx0UzWPHZHCE3GU68bHnvsrjsrNfSvtkRQByuo6pTwwiA1w1iOHIvKDs6XY7jfdv+y0U4DxqrqyWYixnBGjYKPsDIk4RW8AySl4A0U/tOmKZPL2wbigIIw5p0UaU/PRh+nGsWm+jIB5hmsAgjnSsPt8P6+ixh5i2kwOpISY/ghGS;4:LfXDguZJrHNT4AZuS4A71giaWPfweR52i6WEnG/Q8XHx1up/KXl0HBGj3ADADCsJy5wNw9dPcHAuPrGcrix14sFhm1O9boDt9zlgiUo7EayEOmuz1RV+g/LH3X6rSmLJMYKGgAIbOBpefSq9o0Q0s0MidZW4yEifwOQsfEi808g+ag5MtgbqNcyj/KEoyNALYB0njC41q9yPdzmHlL1NYZPWA3o/rM4OWQoQgfxovH/U1ocV0fRzhWU3DHrrSYoGUqump9rNUWrpaNYrphSZmA==
X-Microsoft-Antispam-PRVS: <CY1PR15MB01702F5F54A2D9BE59A1021DBE5D0@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(46003)(6666003)(86362001)(186003)(486006)(52116002)(52396003)(76176011)(7696005)(6506007)(386003)(93886005)(16526019)(33656002)(106356001)(7736002)(105586002)(58126008)(54906003)(16586007)(47776003)(50466002)(305945005)(7416002)(5660300001)(2906002)(316002)(478600001)(476003)(446003)(39060400002)(81166006)(1076002)(4326008)(55016002)(6116002)(81156014)(8676002)(229853002)(25786009)(9686003)(23726003)(68736007)(11346002)(53936002)(6916009)(6246003)(8936002)(97736004)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:Qk+tSx1QV9MWOTwCn5yrqhJSkuSz8cuw26QUIOhKv?=
 =?us-ascii?Q?8324aM1efNdQQMPtKfLzfiJW3HkUlTPYAwq2p/dXN4FtdCWB1V6Lb38363Aj?=
 =?us-ascii?Q?XjdzU2U3GJVNvTkDeJdLh5PihDmvoFLXPPGjFmjdn23WO6fS2dGyYdZo80RT?=
 =?us-ascii?Q?aR2HXPekGFN7CwtIhqR30JX8EJWB68F5SlXD4XBYEaXuah9+aJoT63HMy+w2?=
 =?us-ascii?Q?0NF8nF6CLQYjB9OQTb0VUEzG0JQ5fXi9yd8V1WpqeknkoZ8kLohxpDrnqt/o?=
 =?us-ascii?Q?BpyTxbDpBq7keXAVttIzZ1XOuCUbbH+i/BLWpvHLeZmVUjfCmwvnP0J6u5ub?=
 =?us-ascii?Q?zw9chK447P+3t2zMKgc8QtMYgjmzryDOHlwLLvyjggQi6/hUcI9snpNY5Ffw?=
 =?us-ascii?Q?6PWTVq8gggsSpRCGW0Z5yxjAKeIrDCqyNN+0QR3RqZzlj9gfEMGrBmj1ZFkN?=
 =?us-ascii?Q?vFM5KCD2UXCDPmsySZ53YpfQ2sIinqpiE9OlKBKPQ/zcdfKbj+Sp1K5/GhKL?=
 =?us-ascii?Q?rqBcs6lXcYPdalKkjK/wyncMROIYezzHjYsgmZaHa7el6XTfp4Hm9rwodiYV?=
 =?us-ascii?Q?Z/PvBdQaUSPHC4Xnva6nYga0selqnfWuJ9jB3wYSJ1KIg84sbf+I5s/0Oge5?=
 =?us-ascii?Q?XHY5Ao8gvmkGlg+pC0CB2maRScFUwYgRPT5ebIRAPdJn/V6+bRVPtrGipm5U?=
 =?us-ascii?Q?xiu/8ZIp7T9Gx2v6WHhk6OydlGIX5rJv/VOhv1FInx2+xT3mPzy0epvLqMxc?=
 =?us-ascii?Q?xjKiZ7z9q/vdBfY8YPr35BIbhzvk1d5M7nP30ASz/pyAyRtIrx7B/U6J+HPs?=
 =?us-ascii?Q?6/UIbmvJwLVQLx/iE5x3eFVE3DpsvKuVeqm+2Vb0RKx0RfRjYdirIi7RDyNb?=
 =?us-ascii?Q?/YT0KyNKvgKSC6x1sb3uFXxRT6HxCOmtxNuUnF9hR5sbTzWkLMDfoyU09dXz?=
 =?us-ascii?Q?Uv6NTEW5C/c+v7oJwxhhR3EObQmAxeE4gjMeqTZIBt2JMGBBmF5veZ9F4nz8?=
 =?us-ascii?Q?iFKTaGNbGXlMDUb5nv93wbJExJJ835/5TKZiz5108WAVy5d9VVYNZkGPTvZi?=
 =?us-ascii?Q?8cy+W+7/qi+9/CVW1zhW7JYAo4DGpW9MOoibM5GXD6cSEVDqhDwit+rNRt/0?=
 =?us-ascii?Q?UvcE5hEo5Byez02GN0STcTC+oP1x8coHZfvY7GtSVMS4pARmNf/nmAdBrFeV?=
 =?us-ascii?Q?jdDwtHCRs+gq7zW0roxHqzBY4DRcciBHNHSezqrC8cRgmX6j0H6kEwySVzRt?=
 =?us-ascii?Q?75aESOgIP7R78QWVCa84e9xsz3wKaekpdzQw8yx3fTmF0TxxT275v3+DQ4c3?=
 =?us-ascii?Q?Qlc6G5orWXCUUAruy496Kk=3D?=
X-Microsoft-Antispam-Message-Info: fQclWj5TNNGup3p/nKJl1uLLSQyo6FkqZefhP5p8UeFlCEyJAhwg6m4YfqLeUZBmKX/EkP4drpas/bqG92GVJliYqyu+9riqUhuTiNqdnOJH1yFrWOCRWkXZ6M4iAnpVZJC5va09QLme8sdEzTohDCbrvUGyFZp9hq5LoVCUxsjLsGurdtLkh91z2vkBZ/KRX35q9pv+7d7cM51Z0cA/b4af87Dfvbxs18pSLCRkEOJt2+Q2ISfIESCA+ZydSUwDHtO/lV8pKwsxFj1IAw2G9h0xPQbe5OL89X9nEizOEs+R1Z50xFbZdFP0Wk3FZMRYrI9b4R8eDhnvy+LtYP+ZLRA/t++SEDVYUuNZ/qqll0I=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:kKZuglAY7RhXqEa7Avx0FeDrNgCaG4PFFFbmqz8wr+Ilzglpxw+m4LerUkmuW8Udfe5xmbnW/5O+OBjx6ystmf1d0oY9UZiJC/MS6dsx8PNur/5duOO8azzWK+WeqpRrOqgJSJHKIF9+/sHn3FPbg1xI+MUYo9MrkeYI69F33yWaSDNbF+W35R2Qc3ld+j6zbo3WbH2qsCFCmf4z4xe00EOrMFnmCcsvf9JLCICrgWJoRJOB4VOaRf391eKJLsUnv5BeFlKXQ3R5hunSvqfXrHOcsg2No4oddMfbhtv79orBdW+LF9KYO8xh3UN6XJ08vDsmwJju296t3h6KtEXLquZpq9GPM9wDYM1SikvzBx5pFiL9IAJfizWfoRp3psdpb0P4wy1i6FolligjlgJlmMpXepB1pLM7O7IOj5ohQd34CE5Y1MMp9TaHMQtrdHijRYl+pbnUDX7P4tU+YKHyAw==;5:cLTFF2IDlwUHpu4d7i4g3WWB0r8TfC79jBDHEiA0PB/cmgB0ZNShIVdCbjOt1Wmqm6xwNldhosGtLmpDcCeDGdqKeEACLXLFKxKHW7Q6PzhugOLeFjdJlFe7GC3xjmCFkAp/BySVz05fc/O6jbwQReUzkbwLHid2+x5DvIE/zsc=;24:PFcCQUSi7kFKL2c/GwZtB0lCADe2/lgeuShz8H9a8MalF/v98kGdOnkb5MTStyVtJlCCmgOIojjnU1bYDZwqKjeExSNsh69cH/qqrCUK67c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;7:DxeJYFk1FabPr63O/NQdipk67B0chbsfcVStSOg/QX+V7uLrK7lZUhxt+nxJik2FcEmbgpIqicvujLCR6obdY/SNSkTK+yj+pkHsb2LmNN9TivCsHEjzixRqbcliDMhzpLT+7/SppV/S/IXC8MY6305ztAK66vJmskjrO+sMuVZ4A3k9pjrAWvmHuC2peK9yyGBzkhwhykDFne4GX7E5YEmyx/kQAeOcafUfguq+9wQ/wW5tV/m1aG3JPPBM089t;20:TM6AsoUiYdSUj7xC6TKMLc2RkafI+QAG2MgFySQzVZZxNw529/YWAmNfrmNGsIxDiLIzfVwKXWIIs+yN8woT/r6RYoOD4ff/faBy1QVTPyzBgaB4hUun/A3U39bvU6DLk8p4rpfjEmVnTppE2s2YN9V6DNTz69gnrIMYqvjgtPU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 22:09:28.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28def2c9-202a-4509-7640-08d5eb68cd24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:13:47AM +0900, Tetsuo Handa wrote:
> No response from Roman and David...
> 
> Andrew, will you once drop Roman's cgroup-aware OOM killer and David's patches?
> Roman's series has a bug which I mentioned and which can be avoided by my patch.
> David's patch is using MMF_UNSTABLE incorrectly such that it might start selecting
> next OOM victim without trying to reclaim any memory.
> 
> Since they are not responding to my mail, I suggest once dropping from linux-next.

I was in cc, and didn't thought that you're expecting something from me.

I don't get, why it's necessary to drop the cgroup oom killer to merge your fix?
I'm happy to help with rebasing and everything else.

Thanks,
Roman
