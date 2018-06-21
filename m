Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADA420836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pFqTQzVx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wwh+7QSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADA420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeFUKGN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:06:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55126 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932770AbeFUKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:06:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LA2hIX022909;
        Thu, 21 Jun 2018 03:05:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=ph++W3tV7UrzTcDxKsDIJxHXU52pZq9jZzxAqJc+J8o=;
 b=pFqTQzVxVpP6ifpNVVGXLThKDR2FUT30edMdX80RkeS0tmP22YwVZffRyHpkooVTd/Xr
 YEyhvpCZiEgbzx2Iuh/Kb/YA0twgversg/tORaRIuHkcp9QlCRyarUPqZnCSNi4WJfs0
 iWE1cbEvQeHqUIwsZFbNM2wZFOWtRqHaHTE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jr7hy8avj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Jun 2018 03:05:46 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 21 Jun 2018 03:05:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph++W3tV7UrzTcDxKsDIJxHXU52pZq9jZzxAqJc+J8o=;
 b=Wwh+7QSDYbjNOICA3M8ba86VsR5BDiYb/RWV9sbFCaYldQkuWyFw386ta+NNoK2P5tGNYBnUPcRGbXQgAxBY7coTn860VTi5M6bsqcnsycOwtPWdh0sjeSHYWfDPSrEhFc/BJox9GRBqbPS5x2hc1HulkskAdkaUm/R4xw7xYv0=
Received: from w1t1fb (2620:10d:c092:200::1:81dd) by
 DM6PR15MB2506.namprd15.prod.outlook.com (2603:10b6:5:8e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Thu, 21 Jun 2018 10:05:40 +0000
Date:   Thu, 21 Jun 2018 11:05:21 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/3] bpf: btf: json print map dump with btf info
Message-ID: <20180621100520.GA1176@w1t1fb>
References: <20180620203051.223156973@fb.com>
 <20180620203703.208599277@fb.com>
 <60109415-AE62-4E4A-BF7D-401F66245523@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60109415-AE62-4E4A-BF7D-401F66245523@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c092:200::1:81dd]
X-ClientProxiedBy: AM5PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::40) To DM6PR15MB2506.namprd15.prod.outlook.com
 (2603:10b6:5:8e::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1abf947-48bb-44cf-51a4-08d5d75e8c06
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2506;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2506;3:JhaKEnVZYwOFEC7+sSYvyRLMULVI+3zOUB4+oZ467GuvwykFQWvlzM2ug0CmYWf9wluVQFgfW0HaMzo5bPMQO3XZmeBZ4OToYH0yTIGCJ8oavR9zmm8oE05dU5lwq3Py3Emzsxs43lhpbD5JqHP8cTPp5AXC8eGvtxs8l6Dta++unmTx8cIW1B24HbyRWZpS4ePWqPzfF+44ssZJuwsN4Mb6/UpbO5/nO5stvUd2IFbu8lG8DwRiP90PMtzGDVCe;25:IywvVdL5DTIfB1cI9gwDfUWWxam6lvdEGTgqo0cbz/6/V/CsE2WUYWIuhZ/TnVd1Y/5qT0e9Qfpb42HM1f9uEtX9HnwphWbN0lp8u2Md8TpgvXXiwXTzCWI6v77ILBl7oqs9+9rR4d6AoI3jDuBop2czjPf18DJD4VBBa9lCj2TGI/GLPio2z4PXLQGe9WiOF9R7kihCbCwGhMh9b7fy9FWJO5CUizGIrCU2bLjUmS9GbavR5gFCA08X68Wwlhjt1AwZG+gVktBpQoeojKpMLFnc+LfbCs4yfpUX5ZqTpfsCs67sZ4/4jtr5WhWT6hzqTXn062UdqFR1azHJxHAqbg==;31:/MthMcnuGPqd51+ZDnmpGaPEYAlYV9dUuo8m/d+PsW5ii5+hjx8sEQmunaSzFaF6WlmRzTbuJBeSi4Eh0uR9liIornBqTHz8MolLHmeT4hUnCN7mHzKwjvXbvNtmlN5pGfd6pO0s7hTLACXQL95ynfBJS2gQzxc8xDDIOszi2DH/QYvH1fPzL4VNCd5swqxyT9SgMQf1JUCYsAdfn/yxszKDTIWxJUHlK6aN0jz/lPE=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2506:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2506;20:6s5cHALjaFzGVTdAzuqk3LGEVhlIW8hnlbzoUrCv+qLk0neE1w+G2qw6U6JOixWBttuoAk/r4C0Ep24Go+cvyfZTKoDIEmfrtQBFZSFPN/0533QhQqZ2o0MLVrtHnMKalcQ8mTsb9B8BMiA6iXw/B9WbF4IIbNb/Ri2q4mUEIZ5uO0cIbNI/099SaBT/GXqBRvfyGYunMojqK3e9SXv5EIUwBZFDPQ8F1NT/tWdcqRNofZUxfBX78nvPWV3R2o+nYu7ie4jCpfvx0gdzVxvdqYacADHjgW/tDlAWBjW6EYV8/721WkeoIh+0qIN1P379Kjo8re+kNssBpQ5VgExHuUNeqZriGILTTvFQqiUmOmRJW+jPFiIC3a1Izl2s4i28Nwt56RiXq4uNNs2rZucNbkRr5Oo+zLerlzemLvF8+rwVaj0TipHB1wh9MIsrsjkeOTKMyfJnDdFltubaZkN4SlFwCxv2NZR0+ok8su3Oez4oR1hue/sqAgTTVuuKEYS6;4:693kDED1uIVED4ZQGeE195B9LC4gHnZ5lupz2R3VCBTzkaGGu6OOa9jbF5Zl9q67r6pciDDf2g+IW7fEMqCZUNAIo1Hy3xWAUhsBJdQRbyc+VbXHrKf8pC484cxcaVRIxUJ/8HNe6K7yeIVV8EmxX0BLYjjzvo1ns5btefNs7FJXvzyfF3x935BBQtCa3LLWB+qP88mhGaozQI9TdOTjGMISAtEpEGFT7dyzZASsTEWBxRpXgexO1ORq70GTRYbXgmcVyKWhEQzP/BawA2MZaDEwLpAWcliIRdDKB6Zq3RWDI9h1i1BXw4SEnN7ysqCw
X-Microsoft-Antispam-PRVS: <DM6PR15MB250698A19497615A9ADDE1B0C6760@DM6PR15MB2506.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR15MB2506;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2506;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(376002)(396003)(39860400002)(189003)(199004)(16526019)(8676002)(8936002)(68736007)(478600001)(81166006)(46003)(81156014)(9686003)(1076002)(6496006)(47776003)(97736004)(23726003)(6116002)(52116002)(386003)(25786009)(59450400001)(53546011)(33716001)(52396003)(2906002)(33656002)(76176011)(33896004)(50466002)(105586002)(229853002)(4326008)(7736002)(6246003)(106356001)(6862004)(6666003)(316002)(53936002)(486006)(39060400002)(6636002)(476003)(16586007)(55016002)(446003)(11346002)(305945005)(54906003)(5660300001)(58126008)(86362001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2506;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR15MB2506;23:USixeVm6JTv+uvQBCI3MIkxsTeqnsg6DyRrAR824T?=
 =?us-ascii?Q?gW8i2sdiEomsuky9kxAuO7yGNwDrjuvr2KUsjJH1SkD4jO9g3nSuQjSuNhJn?=
 =?us-ascii?Q?hfaH4Ib2ZZC15XMKXZBESlBWSnXFRiGTrh8mpfImOIZP1cDGGyONRM0aGJb+?=
 =?us-ascii?Q?c4dY7P6VXSkSTPbOQtHdSReuGubNHjJXHOmz8bQkw7+4y30nRCDgEGWBPiBM?=
 =?us-ascii?Q?sQVnw2vTLzHxk10U17IjmqwSV5ZiVWibp6OWtTforkX4sLn6COJf8fjZ1PLK?=
 =?us-ascii?Q?oECOvX9+lMJt9uPErk6biUZCDHhlby6/zyDtSMWUhDUZrLvvAgUJKPefqzdg?=
 =?us-ascii?Q?YAm3Nl57+HtTUjN1kw/SsvF/0rERwqejhtnL1YsZhNAe8cBdW8X85HNt+E8j?=
 =?us-ascii?Q?I6cqy6uA4Lh5y1NCrLw659Mh9i4mX53gRd32MIXBsWbxrri/micd0UnDTDVr?=
 =?us-ascii?Q?BdDRm6ggpfMG4vJBqy0fbxbbowzbUogZC8DY16CkRgDbmEELo/qW7DHJLVyL?=
 =?us-ascii?Q?X1O0Mpn1unpxQNLF1h4SsSf8AmAyNGJtctnO2b3P698v219AYLDc+3yrClrD?=
 =?us-ascii?Q?CXCWFoF89hircWv6nSJJi5gzrb8/9bzXdkgBrB0v+EyzMEKtUJdSIIeVP63Q?=
 =?us-ascii?Q?oWHFwdlnU6dr1eIoNadShiZ/XtWW17GvJEiEgwKaWSM6J07mtqitTpIDRwOk?=
 =?us-ascii?Q?b/nOgjEAdHw30jw3x73YzNAAc6UcpZKxT4jVAa1CE5EcdRvD+jBLOUPfuU2z?=
 =?us-ascii?Q?wzsqtYeaco0YFf5QubxYQBlQF5VibQpiIJ9bimlEmU/KIlIIYhzkBbzR+q0h?=
 =?us-ascii?Q?CMtR/QGwj/tkATafRqjhGF2EtK329P4UIUPNE4S0IuCe7iRn3M6hBizeIN6W?=
 =?us-ascii?Q?RwGZRwSfUhUkxnbTO4ZHWqsM5K6tosjY7C/RQ4fugf+muFIMQzb3gh/v6YMY?=
 =?us-ascii?Q?Xi/ZZf1ECTTvEYZ6/r58rWQfl4gfxrZQ+LFzrXYzJh4Czpd3bhWznQqDl0Hb?=
 =?us-ascii?Q?OM5h5R1x/Q3Vwe34JRV/x9loEhhIqn593R3YLkKBHiJ6YjnGza31vQagKQc/?=
 =?us-ascii?Q?uBZfL+rsZsJSo2nsxa3RanYDvodjnHsPczUwzMr79bOmNxHyHDXYlnXgqTst?=
 =?us-ascii?Q?naLhcbZgNMpf++87FZgPWvuYHPXNfuGwc4KjUeL+f4BZHaRyodLNP/DTfos4?=
 =?us-ascii?Q?wrdhDJopRXojCNQlQ8j0W4cwQSNsUEroy9kn3SklupH2erGQ1FR4V5qdEti1?=
 =?us-ascii?Q?CEed+vFqcMXNIYTvwZ3v1UqY0IZKS3K8MbtejdnPtokYNMExKE8gbto+mAwu?=
 =?us-ascii?Q?yFeYOtLbAA9WeYajnZqDxP0iSz9d9GwjADB1ylRwXNUfYr6MzaR8obPbVzm1?=
 =?us-ascii?Q?7l76A=3D=3D?=
X-Microsoft-Antispam-Message-Info: s4x3iFMsWt4qZvD0fQIRdPwvhmF+H0z0lMoy0MY7sJ9wjj/OhyKV1p3UC/g+81fvjZ3voGBf9sxmKeeKV1iwvwdEpWzdLud32X632nv8dimENVuqfotS+rxwwjk4uxHVIOWElgTfukUI+xbMi3o1Iez+iXZu28mRE8IDiPtxEUu3ZD4bRc550kj297mmOTnj3GKJOIi0TTWjg6A+fcsrTOH9V9Ma3V6tcp8jmkljkCLUD0eOVoobKnV8f/5DfKm3MdetU1AqSKjz70FocIAb+bqkPH/BbcuKBhc9ui+/h7wk6O9XQ8yn5ekdaO6MHVhq
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2506;6:tkywYzlApgczeb5sbW239bt2SpKcKJJC0TjzbMyCrd+ZlP4K1aC645kGzexelYXQaYDsR4eZi7L7FzEOFIFfpMe4bRPJ94xn5DJesXGX9E/E90Tve2OuyG8BEDRu0wEOI4pe7Y3FSJfXQfyxnx4nPOCawAl0rPNyCjrP4LrYDDcI0He1GiGqpgbCUCnQyZLmEwZwmC2MUcgSvsc1wAGiNvUo1dGZQ9lcabpCuk9KTJyDMBzA1BLAssg1x3zdeafCbiy6MQaqgsp+RPpsAQgBB0USUfAuCmHv+dEKKL8/nwnnS73dnULpzKEe75LhTnYgzd3hyubrzHS+VGdBPHKjIyi+kuO72wSPCfy7/1DefqdIAPbCwp5RjufvCleSZHS6cbIYNxVJD0LXZUFDy7DWzQUA3sw099JdT0jVtvxjUaC+sB+25ubJHp8bcNHiBWQxeng6pxT9wISmLUlpiojVNw==;5:GHAN+KbUy8LrQjtnu8Mqju2vdgdjH+usnVSPL/nj9k9V0/aL6ZXIdEE1gLRewZYx7Zhk7WlBrkXcYKg67GRSAKdxriqSBdYvbYc4Vw3Qh2WFuIrYvReqFFyPfLp1spjxOVUkDuNGEFF3pcgUP0jfJm0DMXzZW3d7FdAggDODy9c=;24:UG7/qPjsi2V/orrD62eOUAeFxSVCBaWLjiiNe6POASJIhRuMBJlM6MzzKnYQucUfyJls/XSAEUAyH4FsBW1UavCXdAZxmJyHLtcgj6JUySI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2506;7:yg8ds5TVFi5P5MnKpO/mATj7TZl3lkr9IpDU56Xa/v9SVVkHsikf6fX3+eiT+mP82lesGK3xrakyhhTOj9wnSIiJTFuBkP083Vqaequ1nph6QYdnPgfbmNqpGGxHKx9k9dOBR+vFZPlngwPiK0IKUlODQjG5OZRsKzs21ZKtB1xygy4DUUjeLNUces0bNrUMMMXHZhtI7/3uLrP/W4NHe1qJeHWwyuXqO+U0DBw7Kro6B96gMhU4Rk66wtk8/GNP;20:OpRogzIAC2q2WB3CcaEO/+roDN+OOj8pvYiPLjTwXUjyeCNFt0k0slli/VM/+yvO29dEgrPeUCknOvKqc+CitrrLX9aGCTXsoCtNUccbcRBS9Me20ETajVp53eVx6WvtZcFuOp/JHGU52/17DPpdLrv0owoW6jR5HiPiFXfHrXw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 10:05:40.0946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1abf947-48bb-44cf-51a4-08d5d75e8c06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2506
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:22:52AM +0100, Song Liu wrote:
> 
> 
> > On Jun 20, 2018, at 1:30 PM, Okash Khawaja <osk@fb.com> wrote:
> > 
> > This patch modifies `bpftool map dump [-j|-p] id <map-id>` to json-
> > print and pretty-json-print map dump. It calls btf_dumper introduced in
> > previous patch to accomplish this.
> > 
> > The patch only prints debug info when -j or -p flags are supplied. Then
> > too, if the map has associated btf data loaded. Otherwise the usual
> > debug-less output is printed.
> > 
> > Signed-off-by: Okash Khawaja <osk@fb.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > 
> > ---
> > tools/bpf/bpftool/map.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 91 insertions(+), 3 deletions(-)
> > 
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -43,9 +43,13 @@
> > #include <unistd.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > +#include <linux/err.h>
> > 
> > #include <bpf.h>
> > 
> > +#include "json_writer.h"
> > +#include "btf.h"
> > +#include "btf_dumper.h"
> > #include "main.h"
> > 
> > static const char * const map_type_name[] = {
> > @@ -508,6 +512,83 @@ static int do_show(int argc, char **argv
> > 	return errno == ENOENT ? 0 : -1;
> > }
> > 
> > +
> > +static int do_dump_btf(struct btf *btf, struct bpf_map_info *map_info,
> > +		void *key, void *value)
> > +{
> > +	int ret;
> > +
> > +	jsonw_start_object(json_wtr);
> > +	jsonw_name(json_wtr, "key");
> > +
> > +	ret = btf_dumper_type(btf, json_wtr, map_info->btf_key_type_id, key);
> > +	if (ret)
> > +		goto out;
> > +
> > +	jsonw_end_object(json_wtr);
> > +
> > +	jsonw_start_object(json_wtr);
> > +	jsonw_name(json_wtr, "value");
> > +
> > +	ret = btf_dumper_type(btf, json_wtr, map_info->btf_value_type_id,
> > +			value);
> > +
> > +out:
> > +	/* end of root object */
> > +	jsonw_end_object(json_wtr);
> > +
> > +	return ret;
> > +}
> 
> Please add some tests for do_dump_btf(), including some invalid data type/kind.
Sure. I was wondering if we can follow this up with tests afterwards.
However if they are essential now, I can add them.

> 
> > +
> > +static struct btf *get_btf(struct bpf_map_info *map_info)
> > +{
> > +	int btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);
> > +	struct bpf_btf_info btf_info = { 0 };
> > +	__u32 len = sizeof(btf_info);
> > +	uint32_t last_size;
> > +	int err;
> > +	struct btf *btf = NULL;
> > +	void *ptr = NULL, *temp_ptr;
> > +
> > +	if (btf_fd < 0)
> > +		return NULL;
> > +
> > +	btf_info.btf_size = 4096;
> 
> Is btf_size always a constant of 4096? 
We start out with 4096 and in the loop below we increase the size if
needed. It seems like a sane valeu to start with. However if there are
better ideas for start value, we can discuss them.

> 
> > +	do {
> > +		last_size = btf_info.btf_size;
> > +		temp_ptr = realloc(ptr, last_size);
> > +		if (!temp_ptr) {
> > +			p_err("unable allocate memory for debug info.");
> > +			goto exit_free;
> > +		}
> > +
> > +		ptr = temp_ptr;
> > +		bzero(ptr, last_size);
> > +		btf_info.btf = ptr_to_u64(ptr);
> > +		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
> > +	} while (!err && btf_info.btf_size > last_size && last_size == 4096);
> > +
> > +	if (err || btf_info.btf_size > last_size) {
> > +		p_info("can't get btf info. debug info won't be displayed. error: %s",
> > +				err ? strerror(errno) : "exceeds size retry");
> > +		goto exit_free;
> > +	}
> > +
> > +	btf = btf__new((uint8_t *) btf_info.btf,
> > +			btf_info.btf_size, NULL);
> > +	if (IS_ERR(btf)) {
> > +		printf("error when initialising btf: %s\n",
> > +				strerror(PTR_ERR(btf)));
> > +		btf = NULL;
> > +	}
> > +
> > +exit_free:
> > +	close(btf_fd);
> > +	free(ptr);
> > +
> > +	return btf;
> > +}
> > +
> > static int do_dump(int argc, char **argv)
> > {
> > 	void *key, *value, *prev_key;
> > @@ -516,6 +597,7 @@ static int do_dump(int argc, char **argv
> > 	__u32 len = sizeof(info);
> > 	int err;
> > 	int fd;
> > +	struct btf *btf = NULL;
> > 
> > 	if (argc != 2)
> > 		usage();
> > @@ -538,6 +620,8 @@ static int do_dump(int argc, char **argv
> > 		goto exit_free;
> > 	}
> > 
> > +	btf = get_btf(&info);
> > +
> > 	prev_key = NULL;
> > 	if (json_output)
> > 		jsonw_start_array(json_wtr);
> > @@ -550,9 +634,12 @@ static int do_dump(int argc, char **argv
> > 		}
> > 
> > 		if (!bpf_map_lookup_elem(fd, key, value)) {
> > -			if (json_output)
> > -				print_entry_json(&info, key, value);
> > -			else
> > +			if (json_output) {
> > +				if (btf)
> > +					do_dump_btf(btf, &info, key, value);
> > +				else
> > +					print_entry_json(&info, key, value);
> > +			} else
> > 				print_entry_plain(&info, key, value);
> > 		} else {
> > 			if (json_output) {
> > @@ -584,6 +671,7 @@ exit_free:
> > 	free(key);
> > 	free(value);
> > 	close(fd);
> > +	btf__free(btf);
> > 
> > 	return err;
> > }
> > 
> 
