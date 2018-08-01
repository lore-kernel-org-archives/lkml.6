Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427AC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B458820851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kcCEPRGh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="S4xUPDJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B458820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbeHAC6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 22:58:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731924AbeHAC6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 22:58:09 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7119qv2018612;
        Tue, 31 Jul 2018 18:15:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=Y11vfCIHat6mrlTltOBYZ9djrUeYULgN2kCy8TpoQMo=;
 b=kcCEPRGhN1FBRTopeQqyVd2CEjhR93nSPhErVikev28h+znNXb/XI1xLU5RpDfeHjEIg
 YF6bXuwgJd6cRUazUcwn+ZusmO4BYjK84BN3aVnmSAssErgH4NOJT0YmBNY5R6l+MXzY
 TWOxNFiMlIVGnBCf9iYs7nkVmhP3h3zx4m0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kk1df085h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Jul 2018 18:15:02 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 31 Jul 2018 21:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y11vfCIHat6mrlTltOBYZ9djrUeYULgN2kCy8TpoQMo=;
 b=S4xUPDJ7gaqZe1+p0ewrQ4oL6pykY9ukS5MLFPvkDPaoyQLnDAMOpyBL31DWTMVnlba8i63fp1RWom69jhWpdQP0uBBsbRrB5YXgvEGHZ0QWDMqLlbvvu1vTQC+jurmaEPsPkBLclsfTZ0MDwaJ1Q99h+o0OwcUzsExYkdZGSg0=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:ec7a) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 01:14:54 +0000
Date:   Tue, 31 Jul 2018 18:14:48 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180801011447.GB25953@castle.DHCP.thefacebook.com>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-4-guro@fb.com>
 <20180731090700.GF4557@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180731090700.GF4557@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:ec7a]
X-ClientProxiedBy: MWHPR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:300:ad::34) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca021210-14a8-4df5-dba5-08d5f74c3167
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:RnwpJrKnH3XKU4hMirrB/fBFtGtPquG3NKiilM3VE5lFYCTRjD0i3ivnUaniDXn3KfygwgOurIaFHO/F6Fvlkcvsj59Le9EcWxex4zI5KpPsBD3wwc7H/poig2fgWUV0eW5zaUxJNXwaHOE0pVqjAxun/Qirae2+U/bJqAtVdxrcIDHkJhKpQMWaeZYEe5uM2SxStUwZHI6Y+P/nmgYqoWmLVe6xdq8ntahlKdiMoxXq1uko31NBJHInQbWBa541;25:pBil9pnEBLAVcyppt23mxjcpspL/p3oJBrkKIxzL5QmmrrGmOfuUqPVRjXOoiTusDtsikN7aobghRIoQRnY17NuYPf0LXWlDPozWIXzzoANatEiRWu6dn/pouVdo16A5jqSQKkSiWrugg+RBuruIzDGJCUTaPKTb8gFYA11dM4OCCC4w2EOe8TLhHXuGdpEvPiQ0oQalDvbFMLSKXUPyJzdMZBoCZ1b16lOSsxKDcbGR1NOENy3kBvnvExV/cBqnNwilL9CxV6ZOyAnXInC27CmMqfeaOwPXnJpljxRqD9j4yDAxO3wGUQVeCmjxjIPKAAPyBCyD9XqG0izKzioTfg==;31:WVkaUy/YNUTwMSphjd3SNj2ovpepyVizAVKQ+BrAwMUB7MgfMOMrJW60ERTbWcCK3aKWxuzrTXYnU0KsI+aehUys8cwA7OFR/7BCGkLdCCn7u3wWrS3beUtFECEu7MHcAPqbWBAHLrJhxPZsOyNcHOWA3gWxm1PckeIcc5h7pVMwTQgZJEjlhYw2w4KUb9+8NuE22KRKlwVxClfAz/sK13+w8NZ9YSjq3yHOZBvJ88g=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:dvi3e8/4FRbY8vCNcuzGL+mbKiYFZeYcu0cCimYL2iYTx6Sgr7hiEX9Ubxq4xIZaXCBgg5iUQ+ier0A2sGrzC3HMaXLxk5fMuFeDJzp4YIH/WQEGBlLMH3qk9U6Tt0s/9q5zlaHRPt8eBv8We+CckC2zNh83V9sSBRq+PeWF7/p9SxNPvEH12Bve7K8CZjrKinSIX4I2NMb8loAr1KuWXh/FL8u9yotvfygqSJn+tgZgSKozulGyznA2QksoJxSStf1rkV3puC8gUij8xKpIM12I+4lIAE0Bcnl5mVgRSD+JsAdlFoy+kmw5Fqzk7fwnRiIjrhPrHGNUMkciHAs1gg9Rm+xNKYHGhIHnUGKxbZf67o1q3zpGl7GqmGBO5Xpa85Ypt43mrzrckiQPZH9LqiiqT0t5liIG/pzB4niaCBB7c6031N5B2rn1jHu29mEnnkXN1eRVoZgDVbfhoF2UX4YqYmU4MHsrMg3unXVqvwYjAtKTSOQlcYWWvAQdcF/i;4:XrpQi1TU6SnqnJ9v757UlPgHVr/D1sAfEEr7Y/thw84mt2Letq3SlHRIV8kvS1jLDthWNPekOSAUWQGo1owigeBLIKqBVZ2urVIIjJcl1o1VV7IqiTdhXGDRJ4Q0cBfgq/8Tje/9cgfkX0dG7Qv95vJgwd3eyMpjkAvisxAHKb8Ab17lxWtTHXIUHTf4tZnlf020o/Gf2iuIRtq66bPBsTu7bLiSGCmRy4hVP/K2Y4oDfCQk+e1GSAqNFDWBqD7wgwvOXBvizg7RwJFJNanj71SenkSzZrbnmjwyfwroufpV0RRmNHFYj0aJPRc4VQ7Q
X-Microsoft-Antispam-PRVS: <BLUPR15MB01628B48C936AF7370FED8B4BE2D0@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(57704003)(199004)(189003)(97736004)(7696005)(9686003)(25786009)(11346002)(47776003)(7736002)(446003)(305945005)(1076002)(14444005)(50466002)(76176011)(46003)(52116002)(6306002)(6506007)(386003)(16526019)(81166006)(55016002)(186003)(81156014)(8676002)(478600001)(86362001)(229853002)(316002)(2906002)(33656002)(5660300001)(16586007)(476003)(966005)(8936002)(68736007)(105586002)(106356001)(58126008)(54906003)(4326008)(6666003)(6246003)(52396003)(53936002)(6916009)(486006)(6116002)(23726003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:wJsxaeYQ1SZCh1h+npkpvhhpFmQAG45ScUrQNCs+Z?=
 =?us-ascii?Q?9Qym61ZzbCtYxh5fj8DNNjVwEC6XihD91z7QZOJlcikCykpGJyhXC1zdN+T2?=
 =?us-ascii?Q?OUMIET3w03hp6OaA9LyH/ch5KtU5CpwWrWUs++KhQPfuqEnn1wtTa1U1/qgb?=
 =?us-ascii?Q?TDBgOubsO9adLP/RGMk+FKwpdx+swGMS4swKH7blyDfkCjY+WX+L5+zW/9u9?=
 =?us-ascii?Q?YIGsYWtYim4thAYn95RB+sOqDgsXiLrGHFAxctyDtIlmJC+2G8aJGy6lvDbx?=
 =?us-ascii?Q?xNHUvudMBCXqu87Vbovn0+7eTEZpfMr0EQhA0duBXEosn7IguKvTiYQrsmza?=
 =?us-ascii?Q?VWyPdVtfHCWFw11fNLAOWKIknge4Pc81OCl3iThP01ORpW6VexdOtcNCwjO5?=
 =?us-ascii?Q?wtek7zJdb8+DyrkbZLeUa90VSZoFwTA8UR2Nn3Dk8iHoHBEvJqc6e5HrBj6M?=
 =?us-ascii?Q?5CAACuMM/5oOlKMeLfPRZ95UDH+rp5wIxjKHXZHtLhxEoRJR3CMGb9TDif6S?=
 =?us-ascii?Q?+PNqpZXDl8VzVsnEN4APaRNVlPEQgGA/lk8CxQztkw1u7q2M5zaQolIaGUU1?=
 =?us-ascii?Q?nROq5nAreKTrCSR8bmnieQE/Dmh6Mtame1xTE7Mf5MDm7z4Xr/bd/BEjpw3F?=
 =?us-ascii?Q?KD7JYqbsTAodk+CN/yzVwTQULKWgxde0OpOec9c6oSJPQrLk3XFpABnCsF4G?=
 =?us-ascii?Q?cOI274l8zlEermH97REq3i06Etv8YWv9pCtjmXxiJ2nDJjn12djeKDc+ubDU?=
 =?us-ascii?Q?+7ewDo6tuz8nmpEAcgoSuu3ldyi5apIEWmtTcGC5muwWc1NsKjHAke/Ni6ug?=
 =?us-ascii?Q?6tjtqE4DzDhrGhxw5rOc1P7y7TbjryVsrUZHeQXyRvZqZD3zJn5o0jRU2Dc0?=
 =?us-ascii?Q?ETjlpuKFj+TS70JLjj5+36nemRklMW0hjQNinGqIYZfC14O54O3fB9mjvj7a?=
 =?us-ascii?Q?oX2I6JIEguSlNun80h3l5YXQ8NeIf/KK3kUN/iMoVK4V/eDeciPqsgXBMbQy?=
 =?us-ascii?Q?4aI+fwWtbhgTsZ0vRGTwQT0NPbqhACDSp79GVTpa+pcFdtsKzlWvXtVdXwO3?=
 =?us-ascii?Q?Fgq4rKpkTPcIdkZQc9uQ5MRwqjmVb2ZsibojTCQA/kBCTJ62wv5/CE3JVmSp?=
 =?us-ascii?Q?l0/LiTXD005EVcSats99bP+rhTmka7v6aHse4pv4ZA4kNzVEzeQkqhBittXn?=
 =?us-ascii?Q?0fcr7g41XSicPlir6iXCqQGG7BdgXwAHhPOT7qmZWZW+pnV3xTmISUY+YSDg?=
 =?us-ascii?Q?aML0/MoNeTt7B8uCUySHPP6rqPa8EoMS6n96qlf1A2HBzW1T/IUt+mV53o9v?=
 =?us-ascii?Q?XXLhp3afHf6dTuaJriAcZ0=3D?=
X-Microsoft-Antispam-Message-Info: o4uLli79XZGf3zbeLV9zyGSDvC3xFHiTkmeOhQo4nM6fv6oVFfw5u6KcRymxWKCy8V8GqohnNVvc4LJx9TpYqGmVEGAwx/FWnz8W0RHQtFfeIHEA48ImY1xEjSHbnijRbjsXK1yQNv+OmR2A4n3XTxirLsBrjJj4wZXQfZ0YzRyZVLjYp1pMHNoR6uXCX4CaBL3wD5SMcv6XfyBPomgxQdn1m+ncIEGQtCmzCrQOQe70jZFILEDC37aYapGPNCal1RQa6euvpXFqXNImS5P5Miq/XluslPUQzbA6Wzj6dI4unylOakj33ntOOVBu3UyfrJCRJwXwMvI12SfyF9cpY4EwCPUOuQTgXbZrwZPOyZE=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:P7CAR7Dbfkw3tgqqaT9gZaoRuLCCHHVf34gykkwQCQ5+vs9nyFPi7QJUyVKoI21Sj7CYdQSSoxcdlz+/slsDiU7pB6T5GDTMWCiYNn39SgwPshanaOZp3Z5rETU5O6rXAfax+fQmzylz907BRKU0+HVacywzUv8e1TofGyvet5Lw+lu6wlKlrEOhd/yxzfJIahWuJoHis4eSGGiMuHjp9cUHlGOSUbCeh3WXzIuOsGwD60/Hn84jx3FoOt13eCJNMpcT2o9z3DA6hVCILC4O8RnJHbv+VskaJaxsbo4Ai1apiU6QKJ4dGfJvaDsbMJFVVSuQGdRsftENKAYDH38/BN8Y8+2GDBnkTsTPKjYT5Wx0k5GJ/iVKac778YVMoEA/cGi7UmSEcZj27w+ohPbz07EY6SV7m2G+KgQiWJ3MlXKhnrwora0Z5lb5uEnX6sLksAc7cfQ7qQs9SagVHpfmdg==;5:3J/DT87A92mJZulIw0hi/wnHPucXLNiOmvApHVJs5hLkucU780LZHjaHvPIhoKq+tzRq5FNTV4EmsCwYB9MFx3o9vd72sMOQfHLAKaz2oq85TZvzuOUUigwvL4LPuJ6jc7V+VNHEuOL0D+SIl+DP0Bkfbo8wJBRLaYF3EBOJJMQ=;7:gcBVVVcxLuki1/1Cxd5pKAJjq+m0OWgtCpmJUAkXhpONl6k1thb2G/jTJXbP1Iuo3OFN/Cw8knXFpE/rbpU8u2QFha5KpfdPgWu6+ZHTwCHvZIj/3v2Lb3QX0vE7VMX2jnxdQ7nFkjeBrVLkBCS24aNc6sufEu/Nw457gLp4HVdOmr7/UlmgVqLKViUFc437xsqvejppTXccrfECxaGQ5e4btFm+GOsxgR9grPzT42RsjDYTD4gp3TNw/X/ptlTN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:2ii17syH5+ioZ76S0Lo5lhN6dpgTeknucaL5LvAD0WNVFPjDeBbTQU+2VgjHgqh9NN7asvqPLfRIqRgHQKfH0AG6KlzpH+Vt+WI/j7BFP59aAowHMiwjYOZ0oDuaOwccWB1fAfPeAQDsBpbp+9lAupVRGxqy953nJc3+saDUntw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 01:14:54.3914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca021210-14a8-4df5-dba5-08d5f74c3167
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:07:00AM +0200, Michal Hocko wrote:
> On Mon 30-07-18 11:01:00, Roman Gushchin wrote:
> > For some workloads an intervention from the OOM killer
> > can be painful. Killing a random task can bring
> > the workload into an inconsistent state.
> > 
> > Historically, there are two common solutions for this
> > problem:
> > 1) enabling panic_on_oom,
> > 2) using a userspace daemon to monitor OOMs and kill
> >    all outstanding processes.
> > 
> > Both approaches have their downsides:
> > rebooting on each OOM is an obvious waste of capacity,
> > and handling all in userspace is tricky and requires
> > a userspace agent, which will monitor all cgroups
> > for OOMs.
> > 
> > In most cases an in-kernel after-OOM cleaning-up
> > mechanism can eliminate the necessity of enabling
> > panic_on_oom. Also, it can simplify the cgroup
> > management for userspace applications.
> > 
> > This commit introduces a new knob for cgroup v2 memory
> > controller: memory.oom.group. The knob determines
> > whether the cgroup should be treated as a single
> > unit by the OOM killer. If set, the cgroup and its
> > descendants are killed together or not at all.
> 
> I do not want to nit pick on wording but unit is not really a good
> description. I would expect that to mean that the oom killer will
> consider the unit also when selecting the task and that is not the case.
> I would be more explicit about this being a single killable entity
> because it forms an indivisible workload.
> 
> You can reuse http://lkml.kernel.org/r/20180730080357.GA24267@dhcp22.suse.cz
> if you want.

Ok, I'll do my best to make it clearer.

> 
> [...]
> > +/**
> > + * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
> > + * @victim: task to be killed by the OOM killer
> > + * @oom_domain: memcg in case of memcg OOM, NULL in case of system-wide OOM
> > + *
> > + * Returns a pointer to a memory cgroup, which has to be cleaned up
> > + * by killing all belonging OOM-killable tasks.
> 
> Caller has to call mem_cgroup_put on the returned non-null memcg.

Added.

> 
> > + */
> > +struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
> > +					    struct mem_cgroup *oom_domain)
> > +{
> > +	struct mem_cgroup *oom_group = NULL;
> > +	struct mem_cgroup *memcg;
> > +
> > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +		return NULL;
> > +
> > +	if (!oom_domain)
> > +		oom_domain = root_mem_cgroup;
> > +
> > +	rcu_read_lock();
> > +
> > +	memcg = mem_cgroup_from_task(victim);
> > +	if (!memcg || memcg == root_mem_cgroup)
> > +		goto out;
> 
> When can we have memcg == NULL? victim should be always non-NULL.
> Also why do you need to special case the root_mem_cgroup here. The loop
> below should handle that just fine no?

Idk, I prefer to keep an explicit root_mem_cgroup check,
rather than traversing the tree and relying on an inability
to set oom_group on the root.

!memcg check removed, you're right.

> 
> > +
> > +	/*
> > +	 * Traverse the memory cgroup hierarchy from the victim task's
> > +	 * cgroup up to the OOMing cgroup (or root) to find the
> > +	 * highest-level memory cgroup with oom.group set.
> > +	 */
> > +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> > +		if (memcg->oom_group)
> > +			oom_group = memcg;
> > +
> > +		if (memcg == oom_domain)
> > +			break;
> > +	}
> > +
> > +	if (oom_group)
> > +		css_get(&oom_group->css);
> > +out:
> > +	rcu_read_unlock();
> > +
> > +	return oom_group;
> > +}
> > +
> [...]
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 8bded6b3205b..08f30ed5abed 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -914,6 +914,19 @@ static void __oom_kill_process(struct task_struct *victim)
> >  }
> >  #undef K
> >  
> > +/*
> > + * Kill provided task unless it's secured by setting
> > + * oom_score_adj to OOM_SCORE_ADJ_MIN.
> > + */
> > +static int oom_kill_memcg_member(struct task_struct *task, void *unused)
> > +{
> > +	if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
> > +		get_task_struct(task);
> > +		__oom_kill_process(task);
> > +	}
> > +	return 0;
> > +}
> > +
> >  static void oom_kill_process(struct oom_control *oc, const char *message)
> >  {
> >  	struct task_struct *p = oc->chosen;
> > @@ -921,6 +934,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >  	struct task_struct *victim = p;
> >  	struct task_struct *child;
> >  	struct task_struct *t;
> > +	struct mem_cgroup *oom_group;
> >  	unsigned int victim_points = 0;
> >  	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
> >  					      DEFAULT_RATELIMIT_BURST);
> > @@ -974,7 +988,22 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >  	}
> >  	read_unlock(&tasklist_lock);
> >  
> > +	/*
> > +	 * Do we need to kill the entire memory cgroup?
> > +	 * Or even one of the ancestor memory cgroups?
> > +	 * Check this out before killing the victim task.
> > +	 */
> > +	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
> > +
> >  	__oom_kill_process(victim);
> > +
> > +	/*
> > +	 * If necessary, kill all tasks in the selected memory cgroup.
> > +	 */
> > +	if (oom_group) {
> 
> we want a printk explaining that we are going to tear down the whole
> oom_group here.

Does this looks good?
Or it's better to remove "memory." prefix?

[   52.835327] Out of memory: Kill process 1221 (allocate) score 241 or sacrifice child
[   52.836625] Killed process 1221 (allocate) total-vm:2257144kB, anon-rss:2009128kB, file-rss:4kB, shmem-rss:0kB
[   52.841431] Tasks in /A1 are going to be killed due to memory.oom.group set
[   52.869439] Killed process 1217 (allocate) total-vm:2052344kB, anon-rss:1704036kB, file-rss:0kB, shmem-rss:0kB
[   52.875601] Killed process 1218 (allocate) total-vm:106668kB, anon-rss:24668kB, file-rss:0kB, shmem-rss:0kB
[   52.882914] Killed process 1219 (allocate) total-vm:106668kB, anon-rss:21528kB, file-rss:0kB, shmem-rss:0kB
[   52.891806] Killed process 1220 (allocate) total-vm:2257144kB, anon-rss:1984120kB, file-rss:4kB, shmem-rss:0kB
[   52.903770] Killed process 1221 (allocate) total-vm:2257144kB, anon-rss:2009128kB, file-rss:4kB, shmem-rss:0kB
[   52.905574] Killed process 1222 (allocate) total-vm:2257144kB, anon-rss:2063640kB, file-rss:0kB, shmem-rss:0kB
[   53.202153] oom_reaper: reaped process 1222 (allocate), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB

> 
> > +		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member, NULL);
> > +		mem_cgroup_put(oom_group);
> > +	}
> >  }
> 
> Other than that looks good to me. My concern that the previous
> implementation was more consistent because we were comparing memcgs
> still holds but if there is no way forward that direction this should be
> acceptable as well.
> 
> After above small things are addressed you can add
> Acked-by: Michal Hocko <mhocko@suse.com> 

Thank you!
