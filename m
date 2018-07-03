Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE14C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4ED243D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XY02TXXF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gGogoQHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4ED243D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeGCVrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:47:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47388 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752775AbeGCVra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:47:30 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63Lgx8F019294;
        Tue, 3 Jul 2018 14:47:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=xOShNDsoiZ8MUk6u3liD1/BCSsbe7P0jBLi7SmFn65Q=;
 b=XY02TXXFB/3GlmA1E/8Y2Imnsv8WF6MUKQaUnPMH3LZHsbLe3ncTtQvWzi0GvCVe1R2W
 QB1B39XWfJDlyfSRGVO9G/6B1xa1tLhE/mauL+zsxVJCfmxwkgsVi1vIOBfxVLd6mBjW
 VpZDRMohZJB+MkjFicsXCXnkvAEr2NtxTZ8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k0fvf87e6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 03 Jul 2018 14:47:09 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 3 Jul 2018 17:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOShNDsoiZ8MUk6u3liD1/BCSsbe7P0jBLi7SmFn65Q=;
 b=gGogoQHi3z/fdmW/aNWeeWaUpDoA//AINRUFbevLTJ74nzApSYXP33kn8JqjmLDVubEvA7YVRUNImjhifVPt/UBRDcYsM5s8ALoIKMjOuDbZSy/TBd/ja51NdOiLhd6aEwqjeGOViUBhhzSKh/Wj6+4vQdqBPXW3hNHbVDHr534=
Received: from w1t1fb (2620:10d:c090:200::5:808d) by
 BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Tue, 3 Jul 2018 21:46:12 +0000
Date:   Tue, 3 Jul 2018 22:46:00 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
Message-ID: <20180703214559.GA4448@w1t1fb>
References: <20180702183913.669030439@fb.com>
 <20180702191324.570616684@fb.com>
 <20180702220659.6baa77ba@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180702220659.6baa77ba@cakuba.netronome.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:200::5:808d]
X-ClientProxiedBy: MWHPR19CA0076.namprd19.prod.outlook.com
 (2603:10b6:320:1f::14) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d79c539c-c12c-45b0-1ffd-08d5e12e65db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2501;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;3:IVMQsz3DKCX6q87/XIvEg5d4aKgbKyzMrE5F/kq+Xsrj50KTFAo/a0tMAP7cdGvXp4MAX/9PtSnRQY4+8a/X8Lj7LxuAOpZYGOf11rCIOUXlpyU8mpGeUSr9PsRstD/W4CfUocbsBjhZy7ht84lL6sHUqwHanBtaeB3+nrEVYmhJGaO++4jmVVte41yqhCBW1e8BUZGLMjDv1aICER7zvKpykRLG1N12tjxuadL8AaOzCkecPjKD0Kl+JB6hUpgu;25:n1I1psamh94TN7II3uM/GI9D5nooUHS1Bbhox5FqWAATjo4Yb2J1utsqoDi1TFFMXqSejJvJJzXCipPI+tyAUX3lllCsLqE93DM4Fzzivko031HqLnqO9QFAeKuVnLM6SYFI6VwB8YuVuN0N2UuMyFeMkMlVPG8+1A7Yo55AuviMpx3rd4oPz6+B1A1eaJDfZAPT4iyIkHqdYC8J+PKR3o3RYCU0WlgKW3Bz9LFctSXKV/A+WG0LZsrhYBcXMA4ZMS/ftOjLI0384SciM9n982ZyJ+yENcyz2t+A7/U/P5oaA9J4LgJ3e7sTlRTZVAKbuciMAIN+SvxKuOcQR0WKyA==;31:VnIXk8ZseE7bsEIc4e42pN9+vDwMGllb5soFuzFlDWBg/usuf+Oja4JSMgO/8voCETPUQhqJCgwUfJcJfSgqPdx/69KJRxOVyADlWNF/DPu5Gbsrpg05dO6c3AmN3fdRPIFoz/bbkrAyFF54Oj87+cpIKXa0jYgq7F4d7RVPqPvXJKSV+ZtNN0a/iQ7ecQg5tZPQJEfmwr2czfOJodr5jwlnViCStkPA484NQhUVmKs=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2501:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;20:rZiJ5MbWGo5kF+gg3JjtaezEOVqbEKvhLudhp3xP7zoCiYHTih5DGFekOzKL7z1QYi0Nn8Rjnk+qQgTUbeZnFc/C6ZqokcF7BVmlGofSDwTb1Q7AU5kEYsiIOQFYnz0LI9jvZndILy2hLtdO5V2dMrWThT6RzpK5sMPgSgWS7J2kzXiHLjb282hsgF0oNBPblmBsQkSlptxJ828wE9k71sMRBaPjdVCYDI4P8U8u8O0HIfEVKjqqG3FAmKTKsqweAgzB4qGBhEnQ+w2SAASXuwSkm6ZIOg8S8P0XFeNWn3nT8E6ZHGYMFzXCVhhtTNnsAxcP9orDtkOo7WIrO1teFpomVTOILw4Oc2VP3eA9sUHLVNIsyFFg/xwwkApyR43AHq+i0Thc1PnFZ3TbqBs3yh6OK3AZgj4jdPYteuPnMyV369JdOmFWmTGmIuAJLJm7GC+KpOOWRMfb1pfl9PvpabjguVcUEXuLrynHGAosFKnvCMCSAeUvrv9Zhcp2cDUW;4:dhcdtyAkpXQJGPL/rXeh+RDRG46TihQ90DVXuGcPZJEiEUxK+aleV3SYREQ4xn+jexiWoF2F7/ArKlUwr3TQ5w4YsCDEsfuU1qMmi8ZsY7U5/F7D/28txVwe480wDOh7MY1fx/BBWfz4LB2Ia1JV3h1LRx/+y9/TF0HOC4yd7340BTmHGnRfJYdB8sj2UIe1+XYZVe/9mpDIu4BjlJJz1fJIsJhWT8YBqN5T2zl8kQYwKg3S7rkenLSn3k8JEbvbFvVcnf1dhcgHMNKtb11tqf4U3/3Uw8SLWzmP1txiOBlaKowncvKjTGgaWvnJ+R6pqsJ3s8ej6Ok1IWBtnoPD0/XDVeQcD+7XUJWKCvP1D0A=
X-Microsoft-Antispam-PRVS: <BYAPR15MB250136DC8019A92E84D22EE2C6420@BYAPR15MB2501.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(81227570615382)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR15MB2501;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2501;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(39860400002)(346002)(199004)(189003)(486006)(53936002)(106356001)(6246003)(33716001)(105586002)(1076002)(46003)(97736004)(478600001)(6916009)(68736007)(33656002)(6116002)(5660300001)(23726003)(47776003)(386003)(229853002)(16526019)(50466002)(186003)(6666003)(305945005)(33896004)(52396003)(52116002)(6496006)(25786009)(86362001)(9686003)(11346002)(55016002)(446003)(81156014)(76176011)(2906002)(8936002)(8676002)(476003)(7736002)(81166006)(14444005)(54906003)(39060400002)(58126008)(16586007)(316002)(4326008)(18370500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2501;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR15MB2501;23:H69b5dJwjGjKuGGkuDaiiSKaJuxnJ70is3TwK0QHA?=
 =?us-ascii?Q?PVhcqN5jvjfgIZVWd2S0vkv8YT39GJzVewiCVUrc2GlMX+npTS8p5dTBGgo0?=
 =?us-ascii?Q?Yp0AVM6rmSKjR4YCHP88PX0K/jzkm1jL4wNCX2tdriVzYJIR2iG1Jr8xdIBP?=
 =?us-ascii?Q?A9I4OHavp7fXDF+4f/ysAvbkxMiY+n0vzzKUCPWZ8Hf60VkGTjfMMwclDnCX?=
 =?us-ascii?Q?E2pqPeAsFAet5G1kBPG+Fw11DwEQFzKKEMP/scJUe4Dbuqy4kMsnkVBVwGIs?=
 =?us-ascii?Q?bUX5tC6+xv/bgh0b1eMCR+zVE5i8ZLyM6T5UHYKoBVLvd6jNDBRgqS5QLDZj?=
 =?us-ascii?Q?UIzpNaInKQjqXSlEQ1Uu8mLn3TaLGW35IR8ajvbV1SUMQXctOQbC7aFKOoJH?=
 =?us-ascii?Q?eeZ28qMW9VD1lBptmvkikXH/xM+fWEmwHJURHSjSZyXddn4u10U/4qf+4XfI?=
 =?us-ascii?Q?FXhfjCzMcumv0QWddPTLi9eMKs/RXKsrVdymLkdYbN37/AsQPnyac3aEIq09?=
 =?us-ascii?Q?Z6qr2Q8jQS9nOWh4dP3ci4d+ITmJyctseBBHdOaxMODOz2xAjVqW5OfIgSK1?=
 =?us-ascii?Q?xnTrqMYkXy8KKjVuWvoWd+jqvg3kjkIZz5IN9Vw6HoWWkel0T7cCyB2KCPAw?=
 =?us-ascii?Q?JuwxXqq0SIcs3eHEUlyGpSFjj2G8CXGe1JmSVmPWEURPXlAXy508qMZSp7Mc?=
 =?us-ascii?Q?VOcZaKlbXHljkH5njKD8bam8gAz21JHxQJXvuqjQUSElawjYKjoA1so1jziJ?=
 =?us-ascii?Q?u9lzWM/TVixZ9Mk3Lb8Y0Jcep10p/gFGlVSZywlA4cOdXkQX2j1vO0MNvL3S?=
 =?us-ascii?Q?OT6YKOmNU81fiCX0+uUhaouOUuf5KCz5WHS/dIeN3/GveTwSpITVH8jjWs4k?=
 =?us-ascii?Q?rm2xLlpwKGQPyrMT/4Fti+oMflwFa0aSqIWRsdJs5vwuh1vVehLZxpR1SJ//?=
 =?us-ascii?Q?7luyMYryqsy6R0lnC0DlEbK1DOY1eVPujdC7n1RcspZpskPrXPs0m5yR6RJB?=
 =?us-ascii?Q?vGY4O+Ym1QNbDBDh71jKJcqBo0za79dkEc8pj1fnzyMmyQryTWVqb7nw+3H9?=
 =?us-ascii?Q?CuhHfrvtQP+7ALXo3/hp/4A5TEgnrzftqb7QG90WOh5XM0e3tzQWKnj7vz7r?=
 =?us-ascii?Q?QHwDv4hQLNBHL/yMqDu6xwArmjkHDjvwmdlLR6W5y3DpuNXua64lq9wt7xso?=
 =?us-ascii?Q?ojgwB3u84DzH5hREalqvNkw2p4/v+ZjboNav1K4S+WICNhvshXhRutMn6M1K?=
 =?us-ascii?Q?zZU7D7GPgRsRg4iZQC458g1BMSsAB2T+2+duPuc5W2+cfbaKRHWz73S608jM?=
 =?us-ascii?Q?HoQEZHE9LwNO1gu3v0T8WpCT7N86hap4jocFtV5UJCL?=
X-Microsoft-Antispam-Message-Info: iRmalzcKkcvEsU83eU5Ivga61Wjxh1m2cbcZhIMS1vJ7U9/E0EkvqN8kD1lAXKYGVjOAYW5rKrnBnRTsFt03AB+XEvjTNqLcxqWAqnlaSkfDknOwG6Wz9fICaxXEGrelGE4S7Z+IGDtZAdotpBzdDwyUYWX9vsb8iaDvrx8f0ufmzpseWIV+pCGdJnI1hfGrnuu/gm7zQrgkWl4f7b61RxNSGASmL6PvItJZhiJpmIGfvCsDajIwr1BQFFGoJJm4PTbABPEgT4oTFnPw/jwNfeUn4dcUJmaBTANP8xnczGTQIlGyV0wCVjHnUo8cbXg4U/FZTcmDpV6AaTlNEt5Bv7vWrMmUD2xgn9pZOYBHtiY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;6:mBLN8LV9SfZx4uOockLVGjUx+FP0gZTLhVVH1M4luzU2NwTcn5GL8ySz/fpEf4hr8vPSnuIEK7RjiecC889Im5lmAQ7xXcXLXG2YIBSv1nqTEyFq8+fQ1KJRShVvgGi5GpGdrCeeBQRuRJXPUZC7PnkZO6rozjZV15x40mVBNpaLLC/nfVCDBWOQu59PLE3CPBDItQtFX0DnVn/q0NvcLlVZqtrdghLpAvYsO446FVCSoAFjAT3W4RENB7ksVsmhDCxyn2SIC4ThQyQS2zBiosY9fllLPLH1cfXCS3lCx5Xhzx1pRYZOt9IAsipdl1uiUp0frV/jbe3ddTw8zRuNBjULByMUdoiqz4BRF4RfneDjNfni4Nh25Q6OBuEbmVB5TOOYOJRkpaRvU1CuYsVeQqM9bocRHMrnouNZSNihB6dthmljoZoc4xI02qUqAoibgh4x0Nz0BbWdie6HxM8VBA==;5:XWz2zSr2t95/QlSGRJvlVR3R5FYpm4KVfGRDLgG5t1P5kVokmZL2h8DOWHEhj/MbXR52qFAM+E7RSBZ49/ft47yZgkWWOGeHkld9Sw+L3Fmejw4qW5G6o+b0cq6lkxgxsUXDNdVfeNd1He5B11vAUr9IhY1qKAooV9UMBclxBF4=;24:tNwW/g/Dh+9k73w8c/fDnkFxSWLiuIbn4UZres2v8sc1XhvED/2YuEnevRRmVjFdJcMk8ymrRgP0w8BT6HdzFGY8c3K+lktuM05SjE4ReEA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;7:A4PA+n2Dlf9v0DGYXlzxw3al/BmHSQ0nHhz05zx8/K/iVXQolOBjr4IjGq2Fr4R+ViWanDSsr71UpeYmGmRGmRnbahfYZgeJ8tCNRcSCdF5VQznTSEfcxEBrcIKSS/Dq/RYM5xsrFamUTqQE7EYr+criyfYvvwq/EoB6W9LzpXMTI9kLjCPauuvRVnTG7dzcczdyNIchbqj/lBiW4s2cmuBQ/opdBWVDypk6Jtnai5Xuslgh1AzL7HMBzV2H2x68;20:ARGUOTKjY/5xj/Emmd8bcPYcp1+67FqxeUypDcuwrrCiWi057lYdwk2vV3YP4wl35bvEeR3COOUnZDVCTKFx3tNBSJ2pgTSsfCzMuPvqXxUBOy2O48jsGAigFMho2lHVYOKZIZ63eRWKmXBh7bNu//X5nXgd/eUsn8kPaFA9Zog=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:46:12.8152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d79c539c-c12c-45b0-1ffd-08d5e12e65db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 10:06:59PM -0700, Jakub Kicinski wrote:
> On Mon, 2 Jul 2018 11:39:15 -0700, Okash Khawaja wrote:
[...]

> 
> > +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> > +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> 
> Perhaps it's just me but BIT_OFFSET or BIT_COUNT as a name of this macro
> would make it more obvious to parse in the code below.
I don't mind either. However these macro names are also used inside
kernel for same purpose. For sake of consistency, I'd recommend we keep
them :)

> 
> > +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> > +#define BITS_ROUNDUP_BYTES(bits) \
> > +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> > +
> > +static int btf_dumper_do_type(const struct btf_dumper *d, uint32_t type_id,
> > +			      uint8_t bit_offset, const void *data);
> > +
> > +static void btf_dumper_ptr(const void *data, json_writer_t *jw,
> > +			   bool is_plain_text)
> > +{
> > +	if (is_plain_text)
> > +		jsonw_printf(jw, "%p", *((uintptr_t *)data));
> > +	else
> > +		jsonw_printf(jw, "%u", *((uintptr_t *)data));
> > +}
> > +
> > +static int btf_dumper_modifier(const struct btf_dumper *d, uint32_t type_id,
> > +			       const void *data)
> > +{
> > +	int32_t actual_type_id = btf__resolve_type(d->btf, type_id);
> 
> Please prefer kernel types like __u32 wherever possible.
> 
> > +	int ret;
> > +
> > +	if (actual_type_id < 0)
> > +		return actual_type_id;
> > +
> > +	ret = btf_dumper_do_type(d, actual_type_id, 0, data);
> > +
> > +	return ret;
> 
> ret is unnecessary.
> 
> > +}
> > +
> > +static void btf_dumper_enum(const void *data, json_writer_t *jw)
> > +{
> > +	jsonw_printf(jw, "%d", *((int32_t *)data));
> 
> Unnecessary parenthesis.  There is a lot of those, please remove them
> all.
> 
> > +}
> > +
> > +static int btf_dumper_array(const struct btf_dumper *d, uint32_t type_id,
> > +			    const void *data)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
> > +	struct btf_array *arr = (struct btf_array *)(t + 1);
> > +	int64_t elem_size;
> > +	int ret = 0;
> > +	uint32_t i;
> > +
> > +	elem_size = btf__resolve_size(d->btf, arr->type);
> > +	if (elem_size < 0)
> > +		return elem_size;
> > +
> > +	jsonw_start_array(d->jw);
> > +	for (i = 0; i < arr->nelems; i++) {
> > +		ret = btf_dumper_do_type(d, arr->type, 0,
> > +					 data + (i * elem_size));
> 
> Unnecessary parenthesis.
> 
> > +		if (ret)
> > +			break;
> > +	}
> > +
> > +	jsonw_end_array(d->jw);
> > +	return ret;
> > +}
> > +
> > +static void btf_dumper_int_bits(uint32_t int_type, uint8_t bit_offset,
> > +				const void *data, json_writer_t *jw,
> > +				bool is_plain_text)
> > +{
> > +	uint32_t bits = BTF_INT_BITS(int_type);
> > +	uint16_t total_bits_offset;
> > +	uint16_t bytes_to_copy;
> > +	uint16_t bits_to_copy;
> 
> Please use normal int types for things which don't have to be
> explicitly sized.  Using explicitly sized variables is bad style, 
> and ALU operations other than on word or byte quantities are usually
> slower on modern CPUs.
> 
> > +	uint8_t upper_bits;
> > +	union {
> > +		uint64_t u64_num;
> > +		uint8_t u8_nums[8];
> 
> Are the int types in BTF constrained to 64bit at most?
> 
> > +	} print_num;
> > +
> > +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> > +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> > +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> > +	bits_to_copy = bits + bit_offset;
> > +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> > +
> > +	print_num.u64_num = 0;
> > +	memcpy(&print_num.u64_num, data, bytes_to_copy);
> 
> This scheme is unlikely to work on big endian machines...
Can you give an example how?

> 
> > +	upper_bits = BITS_PER_BYTE_MASKED(bits_to_copy);
> > +	if (upper_bits) {
> > +		uint8_t mask = (1 << upper_bits) - 1;
> > +
> > +		print_num.u8_nums[bytes_to_copy - 1] &= mask;
> > +	}
> > +
> > +	print_num.u64_num >>= bit_offset;
> > +
> > +	if (is_plain_text)
> > +		jsonw_printf(jw, "0x%llx", print_num.u64_num);
> > +	else
> > +		jsonw_printf(jw, "%llu", print_num.u64_num);
> > +}
> > +
> > +static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
> > +			  const void *data, json_writer_t *jw,
> > +			  bool is_plain_text)
> > +{
> > +	uint32_t *int_type = (uint32_t *)(t + 1);
> > +	uint32_t bits = BTF_INT_BITS(*int_type);
> > +	int ret = 0;
> > +
> > +	/* if this is bit field */
> > +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> > +	    BITS_PER_BYTE_MASKED(bits)) {
> > +		btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > +				    is_plain_text);
> > +		return ret;
> > +	}
> > +
> > +	switch (BTF_INT_ENCODING(*int_type)) {
> > +	case 0:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%lu", *((uint64_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%u", *((uint32_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 16)
> > +			jsonw_printf(jw, "%hu", *((uint16_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 8)
> > +			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > +					    is_plain_text);
> > +		break;
> > +	case BTF_INT_SIGNED:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%ld", *((int64_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%d", *((int32_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) ==  16)
> 
> Please drop the double space.  Both for 16 where it makes no sense and
> for 8 where it's marginally useful but not really.
> 
> > +			jsonw_printf(jw, "%hd", *((int16_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) ==  8)
> > +			jsonw_printf(jw, "%hhd", *((int8_t *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > +					    is_plain_text);
> > +		break;
> > +	case BTF_INT_CHAR:
> > +		if (*((char *)data) == '\0')
> > +			jsonw_null(jw);
> 
> Mm.. I don't think 0 char is equivalent to null.
Yes, thanks. Will fix.

> 
> > +		else if (isprint(*((char *)data)))
> > +			jsonw_printf(jw, "\"%c\"", *((char *)data));
> 
> This looks very suspicious.  So if I see a "6" for a char field it's
> either a 6 ('\u0006') or a 54 ('6')...
It will always be 54. May be I missed your point. Could you explain why
it would be other than 54?

> 
> > +		else
> > +			if (is_plain_text)
> > +				jsonw_printf(jw, "%hhx", *((char *)data));
> > +			else
> > +				jsonw_printf(jw, "%hhd", *((char *)data));
> 
> ... I think you need to always print a string, and express it as
> \u00%02hhx for non-printable.
Okay that makes sense
> 
> > +		break;
> > +	case BTF_INT_BOOL:
> > +		jsonw_bool(jw, *((int *)data));
> > +		break;
> > +	default:
> > +		/* shouldn't happen */
> > +		ret = -EINVAL;
> 
> You only set ret to something else than 0 here just to break and
> immediately return.  Please remove the ret variable.
> 
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int btf_dumper_struct(const struct btf_dumper *d, uint32_t type_id,
> > +			     const void *data)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
> 
> Please don't call functions which need error checking as initialized
> the if below looks very awkward..
> 
> > +	struct btf_member *m;
> > +	int ret = 0;
> > +
> > +	int i, vlen;
> > +
> > +	if (!t)
> > +		return -EINVAL;
> > +
> > +	vlen = BTF_INFO_VLEN(t->info);
> > +	jsonw_start_object(d->jw);
> > +	m = (struct btf_member *)(t + 1);
> > +
> > +	for (i = 0; i < vlen; i++) {
> > +		jsonw_name(d->jw, btf__name_by_offset(d->btf, m[i].name_off));
> > +		ret = btf_dumper_do_type(d, m[i].type,
> > +					 BITS_PER_BYTE_MASKED(m[i].offset), data
> > +					 + BITS_ROUNDDOWN_BYTES(m[i].offset));
> 
> Please use a temp variable to avoid this awkward multi-line sum.
> 
> > +		if (ret)
> > +			return ret;
> 
> You can't return without jsonw_end_object().
> 
> > +	}
> > +
> > +	jsonw_end_object(d->jw);
> > +
> > +	return 0;
> > +}
> > +
> > +static int btf_dumper_do_type(const struct btf_dumper *d, uint32_t type_id,
> > +			      uint8_t bit_offset, const void *data)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
> > +	int ret = 0;
> > +
> > +	switch (BTF_INFO_KIND(t->info)) {
> > +	case BTF_KIND_INT:
> > +		ret = btf_dumper_int(t, bit_offset, data, d->jw,
> > +				     d->is_plain_text);
> > +		break;
> > +	case BTF_KIND_STRUCT:
> > +	case BTF_KIND_UNION:
> > +		ret = btf_dumper_struct(d, type_id, data);
> > +		break;
> > +	case BTF_KIND_ARRAY:
> > +		ret = btf_dumper_array(d, type_id, data);
> > +		break;
> > +	case BTF_KIND_ENUM:
> > +		btf_dumper_enum(data, d->jw);
> > +		break;
> > +	case BTF_KIND_PTR:
> > +		btf_dumper_ptr(data, d->jw, d->is_plain_text);
> > +		break;
> > +	case BTF_KIND_UNKN:
> > +		jsonw_printf(d->jw, "(unknown)");
> > +		break;
> > +	case BTF_KIND_FWD:
> > +		/* map key or value can't be forward */
> 
> Right, but you have to print _something_, otherwise we would have a
> name without a value, which would break JSON, no?
> 
> > +		ret = -EINVAL;
> > +		break;
> > +	case BTF_KIND_TYPEDEF:
> > +	case BTF_KIND_VOLATILE:
> > +	case BTF_KIND_CONST:
> > +	case BTF_KIND_RESTRICT:
> > +		ret = btf_dumper_modifier(d, type_id, data);
> > +		break;
> > +	default:
> > +		jsonw_printf(d->jw, "(unsupported-kind");
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> 
> Why return ret; at all, there is no code after the switch just return
> directly from cases and save 9 LOC.
> 
> > +}
> > +
> > +int32_t btf_dumper_type(const struct btf_dumper *d, uint32_t type_id,
> > +			const void *data)
> > +{
> > +	if (!d)
> > +		return -EINVAL;
> 
> No need for defensive programming.
> 
> > +	return btf_dumper_do_type(d, type_id, 0, data);
> > +}
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf_dumper.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2018 Facebook */
> > +
> > +#ifndef BTF_DUMPER_H
> > +#define BTF_DUMPER_H
> > +
> > +struct btf_dumper {
> > +	const struct btf *btf;
> > +	json_writer_t *jw;
> > +	bool is_plain_text;
> > +};
> > +
> > +/* btf_dumper_type - print data along with type information
> > + * @d: an instance containing context for dumping types
> > + * @type_id: index in btf->types array. this points to the type to be dumped
> > + * @data: pointer the actual data, i.e. the values to be printed
> > + *
> > + * Returns zero on success and negative error code otherwise
> > + */
> > +int32_t btf_dumper_type(const struct btf_dumper *d, uint32_t type_id,
> > +			const void *data);
> > +
> > +#endif
> 
> Please don't add header files for a single struct and single function.
> Just put this in main.h.

Thanks for your feedback. I'll reply with v3.

Okash
