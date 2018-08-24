Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C754C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD00521557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kmbPwfYJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="N6wSejXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD00521557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeHXTRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:17:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbeHXTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:17:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OFcDgF021930;
        Fri, 24 Aug 2018 08:42:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=3ZDju+LZCNDEHSHjs4ge6yjoHlhfyOOnzc3JANTxGXA=;
 b=kmbPwfYJSjPOMR/4Qv7408JaCbgDztloMbyTkJNcKlfX6yfUc5JaNpwh64+r9whq69TU
 A/4vhyhCEhLams6vlkyZXvSPTUldeNuH1D0lcTYaH+vh472lf/HfMjzBW28gi8MizYPQ
 Wanoq0tXWVc+OkBmMOh0KPR8vHsAQlS/vno= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m2j4a8fp9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 24 Aug 2018 08:42:23 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 24 Aug 2018 08:42:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZDju+LZCNDEHSHjs4ge6yjoHlhfyOOnzc3JANTxGXA=;
 b=N6wSejXB0l27u8kFA5GI+fxReCbhgVPTrtqUg8XOk3iVHan6aVzjtjVI45jxrsOmbuQgpk+MvdPNQN+aqDfMFDMDxP1KG9qG61UB5PHS0j6twufVItus19F2lVu98SmrT+esY2Gt3ehIG3HAFlF0MuNhQ42mr3DyFPkE2bxigGs=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::5:71c5) by
 BLUPR15MB0164.namprd15.prod.outlook.com (2a01:111:e400:5249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Fri, 24 Aug
 2018 15:42:18 +0000
Date:   Fri, 24 Aug 2018 08:42:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180824154208.GA23633@tower.DHCP.thefacebook.com>
References: <20180821213559.14694-1-guro@fb.com>
 <20180822141213.GO29735@dhcp22.suse.cz>
 <20180823162347.GA22650@tower.DHCP.thefacebook.com>
 <20180824125052.GA13774@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180824125052.GA13774@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::5:71c5]
X-ClientProxiedBy: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BLUPR15MB0164.namprd15.prod.outlook.com
 (2a01:111:e400:5249::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3f4a2c2-0ffb-4457-c5cf-08d609d82d14
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;3:q7mU8oE3vb/T2hbal4SAnxS84KQXNeetHePqbEV1f6PkwR3neyhqN60RPjB5Y7YC2eQYbmXP+BfnBQiDtrdKLoKIFtgZ4OP8NWUjyCfOJ+YXvQ0DQGD+ozA48Z1ASGo99rJY0+VB+JBAyz2fr8nhgttA5XP3/aviHam/ZH17WwUsem3c60w0M9btiwK2rcf41hISKOZoCB+Tb5nGfjUTWJrmkSi+mvZDodDTcCC7/RhumJh9ozHXK/L1gf7NgLI4;25:Tn+BhayM1T9PLuvroFZBQfIkhkqVsnDZWvoMjWjzJMFZGRSDkdRCjlPPm1sjS4JITEFAdIVWPZ4qQ2+moSVGH74zkrzzftEw0Rl3dELC6qS2wCvWLTs1HQ/9D6oTWY04lmTXJmz0JYhDKEADRFxUrkGCP83XHFqRCKoQLif2nvUF4eZlcw+gFtnzFQ4NOVBHvnvBEiHHtA0gS5dV2um7QggX2qbaHvUYqSNmFIVrP9hPWOYSX4uHR1Rfvxtk7FJDd9KEpO8LKeJ02Hl0SPYjCkLr1X8oCJ9WE4UtzR6D4pwdtHNWs/Q/AR67DPTOiFuRVYLVOA+eCK3iOwQKEalZEg==;31:iUGXGZTm2/DZtWClBTOA2POs2rbHvToqcG9qdrZpuzOBk3GomafjTnKsz+TDjBkLxy0na1fmIGAkKtggRETN2SQHQSYmVUBFH8Mu0/eXvpa99/pumx5PAGTEQn6L7B+65j5SBw0KtgAyIqXqLIuMXOrYMrrjQt0Bs0KfQzArlSXhrFHd7SNZ6nKH+GWKM75zRNAruGzt4U5jSmmlt3wtYMPwXuOE1adOh6gp1b9F2PI=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:48DAtzgjbMBFkadIEmG/mu4QMj84568Lzb+sEaaUSWgUVpaE4MAnJqzshf6aWcnEVBdXQ3c6B9jHmyDWUPN2VGhkMFvNIbAMquLxcjdchXu3mF9wv0wMZI3SPrX+3iF9aQ8DakqM6doOuI2aNjgLOzEhfkClZDhADcquDkYRQ/aD935zcUFpdwiNfD7KdHUHcJo5w3d4McmmyEaRzcz2/s2n1kxXxXYUUcXJ5Yzk9U7NPPnNlBs/XPzHZoOfzBR8RO5CGv9SQh971zfn4Y0SnOCfdsHKx83REdwJ0uE5Wb4aYYGy3Io2tYm3UExhBknWVCN/3rfxnLPiwqwWS5kbSWuW856FWxu/WGDMO9EK4ULEl6v/mEQKgH3WfI5k0WWHuEpDJuSQiT8rMb4+9tNAz9hOgXC6L1JUVek/Ili8ypH35Yv01mQh4yLWZkYU1xM8Q/t8HCrsrPnY/enFnH6npaOU2G3m1kNUg5M2v3xoVJ8taBFBme6ZCXXr/RKrwtt0;4:7GM1JxQ61K8z4urUC+sxQW7Yx+vNiwjwT/dhGmkJnhGo8uwAEcCH0w+Zlh1MWdgJp2f+wORrGln62XuWeJvOdJmGsxzUHpFQ1ZQ+XGk+UCGjmivim9pm+ahtB+D05CzqicVtwT0BG7WkVC1gLxDPhCUbGkSbj2iHaLYgFwkEN7uBvOft17vhTZsGQ5W+lttuQ1r10lp+v8HHgYHDkuHZuy3c+C8XUHQLcPq7ArqV3N8dajrIStlU3TqWRiHRaE38V8JF79/dSmy5dKfMMmw88A==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0164177CB1EF615D9AE761A9BE360@BLUPR15MB0164.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BLUPR15MB0164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0164;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39860400002)(199004)(189003)(58126008)(478600001)(8936002)(7736002)(486006)(316002)(25786009)(4326008)(6246003)(52396003)(386003)(52116002)(47776003)(6506007)(7696005)(76176011)(39060400002)(54906003)(2906002)(97736004)(16586007)(476003)(305945005)(6116002)(105586002)(106356001)(11346002)(23726003)(446003)(55016002)(1076002)(33656002)(16526019)(186003)(5660300001)(50466002)(68736007)(86362001)(53936002)(6666003)(6916009)(81166006)(46003)(229853002)(81156014)(14444005)(8676002)(9686003)(93886005)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0164;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0164;23:Llv9tlH4AWPHmyhLOD3SFPTxf7zILmvbUG1L0EHvs?=
 =?us-ascii?Q?O602OiiJI/5ozZ2+GckAOnlpUET6+PFxm370+P6eIveby39J0N8MjODMZTje?=
 =?us-ascii?Q?3Kal7zoM8wlw1t7PxBbjjkaTQ1fOvruBjBx7y7pprXmjM1DA8ElSioZRP+so?=
 =?us-ascii?Q?8yYwF14oqq87gvG078IrINeymFEVxps3vh74NSpWmuqQeab3SZoHK1fVZmTx?=
 =?us-ascii?Q?GiqgRnbrJeve+aj3j93gZCeKbhwzACccf4fy5bKQAfMvsa8c5FeyDJCY8RWi?=
 =?us-ascii?Q?6q1qfvkdy30ihqdAjporx/RxBEnSp5worweGjcESUEPCX2MYOzKnJJ4DNBLB?=
 =?us-ascii?Q?62LMcp1FJOVRBHMR9o3l/YQQufIegWdA4K5HyiGx4p9c9BVTzeZshNKBK3Ex?=
 =?us-ascii?Q?1yHMCEHfFuVmsiMNV5XBWz+YQhRERjeOjcoiijJT7xomwA/nqLCIXLSCFCwc?=
 =?us-ascii?Q?Ez0H79J00iSS+7uIW59NSKDSFeXJkep1XqPYnz+4GRHtb/SCiNjaVVxCVCRX?=
 =?us-ascii?Q?L2lyWsSS1cb27tI0a61vgvdXCvvt7oBjyQ26ACdjv/lfw9f8SEP5PnbL1S4m?=
 =?us-ascii?Q?shfi0bGRmUdLGRRUFPtA8xtN7N5Nno8JstiYiVAvxfYjHOfae6SZqfyVamXY?=
 =?us-ascii?Q?ngztdGzUF0FIq3pae2Fo1zPRaVAQQiAgQcPNkpd3pLikMt5VEtoY9raKapz6?=
 =?us-ascii?Q?QmthPL6BeTxqq5ZLZdvhZpT/7IdAE9XygGJPJvQgLfPq92sYLrWZpUImo37v?=
 =?us-ascii?Q?zC+I9YAFS0hlbRJwTmLstWfjjvDvAnjUMeLx/G4LWG6TQLQKhK2AOcdbsGvS?=
 =?us-ascii?Q?YwrcE0crl4NWUnkk1RlYfS9SF1HVn9u/fiGJzu/InfEW71V8/0wNT0etQfCg?=
 =?us-ascii?Q?hUhm65XFTtQFdMHZYv3wRr93vEn6b8bQXUMecja/ZXShbXAglknPTpHc2gmu?=
 =?us-ascii?Q?+gdz+7Z6NBDlzsYXkdpNX43f4LwsRAuaC+PV06R3CDv6vCoEUxQIZxYd87IK?=
 =?us-ascii?Q?fwyT0MXJnYwYm2/GETIrx1sOpXp3eeLmO2NxYjBGOqf6bAvnjkj4tDZxu6d5?=
 =?us-ascii?Q?YSHmy3xAKabZIdIjCXQYuleg23Y1zK5xZotVsxsDO8HCDgy3gV/UaU5H5+R8?=
 =?us-ascii?Q?DqWUw5S1FLOxxJ6CMg0/FVw1iWCjTE5mGjiFC2t62NYc7CYCO2Qsf52moB1p?=
 =?us-ascii?Q?yAeaDSgvzO6wSdM0axh7G7aMLcLgoD8KqPKrK4hlrfw5f29Xlp5Zmk4yYRwt?=
 =?us-ascii?Q?bbOjH4amCnJKdbeulcADCUD4zH7ZbUX/L36gyIGj4iU3WQRTwVV1M73fkl9r?=
 =?us-ascii?Q?VxR1xd8DGfo4BqrDhS0YZk=3D?=
X-Microsoft-Antispam-Message-Info: oNnsixpLpfhrhvyBwr9ayjTwTa2JjcRdi2kT6ho3M5FWVFlOW3+8O4AIqLiz0Ppmgu+JXkjDGdeqfVkzSmW1BNpg/iS+bWgw+PEP+vah8EHNkpRIs4HSDN8O22fju8VRVWNnHg+3I8kVgZtFLjd2ZcL2LNBRPzLt4EDyLTTDIAJgkmKfXsiWonFjwdQmeP9+DTvBVZibrKMdM61/9oL0rJ2R5ckRo17RmYkVUIL4jbscUSZv/lh/jAen2naABKIicM3rSJl67+zE9h4aTdT9e8EdizDy6f8HFYdyH2Y2pOsamXPIPqR3lDHGeO4w1R5Fhyq2Yq1tzrJiFoYeZOQEB4AK0v55AP6pqIRC+Pyo3yo=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;6:0S+7qSeWLzeTXOFMUXNzIFCMfjp4CsWfd+aSgqNtgZlq21zA+WUAtNshrC/av50Yp1nvQcQkTW6GX8Alk+SyMu4U8ppTCyD7Mq6Kg9KoJtJHhtmZKxGnU24/ChTfGbFd19PQ9G3ZG4z/aaqz0EvAOVCJVDhjT4uOY8asebRnuoIP/xuUgQ6rhaMz8cKvVmji1ba9r92B81uLWcRUV+oNypcNnR4ZAkLVAs3hKFATotBWkVJlx+jLhFK2kx9NsGUi94ciuxl0Ya7f1EMffpdsDDbl8doa4W7NO9w6q5k1HVbolI5IAD+vSBk+aseU0i8U0Gk+rt7h8M7Z1hqpEMgTMKubsY2DOvVz9migu9GYhJzCbTZV1IRVjiGMBr7BWLR9ut9Q5z+8guUrJbwDtSbiWfJzPnKgc7BXRwYMCoqZ/X9h7PdKQ62fGIUnGQ4l81sIFLfIsiP87A1piCojyfYTPA==;5:AlO/F/f1nRxElTA1osHCHKQja2QVLEdlfYZNomdEWjbRQ0PlFPyjgDT2Ub0ceTQwVGT2+JmsxumBAh6vUP34qUC9I+WM+oTh9ej9aKf7CxByXR1WK7cYTc3SjQTkHqeyBd73d734vYO+rKM2Cep9gd9LXLFsLzkJLLeguUeeqoY=;7:cot2x/3of8NrbDwLJqSMy6vD8Wim1BuDrB9KZy5BZxQRGYo1c1kAjQlVDij3mf3WOjFi7odxOKA8ofc4BnL3aSHj2NQ/iVEhPl+IfC6w0qDNn8ocnK4N8nk546uTBDJksuaBZbUS54iUFFqZifqXteegJowZ5oszjo75GtVkdOmLBTtf1RMwBlXGXVHJ88y29QF86j8SU7HWZYQwalAABMI9TXzkkCgsnZunsGs+FAIFtlOe0vvyFbKdpn16d2WW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:55FSORUO1nziDcm5emKAlUquucHiocLrhNVGcJIuzaOHdeZTADtUwIJM+W2Xp5dNxCgyMwEUza1zX80Hkir2IzMxXfjjnmzU0Mb+S+R+qLcbtAEDS9hRM86xBnE5uhdtjl29rWJvexTXSKaKFetYV5MsXzZT+CjmFcDN6IIv5LM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 15:42:18.2019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f4a2c2-0ffb-4457-c5cf-08d609d82d14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0164
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 08:50:52AM -0400, Johannes Weiner wrote:
> On Thu, Aug 23, 2018 at 09:23:50AM -0700, Roman Gushchin wrote:
> > On Wed, Aug 22, 2018 at 04:12:13PM +0200, Michal Hocko wrote:
> > > On Tue 21-08-18 14:35:57, Roman Gushchin wrote:
> > > > @@ -248,9 +253,20 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> > > >  static inline void free_thread_stack(struct task_struct *tsk)
> > > >  {
> > > >  #ifdef CONFIG_VMAP_STACK
> > > > -	if (task_stack_vm_area(tsk)) {
> > > > +	struct vm_struct *vm = task_stack_vm_area(tsk);
> > > > +
> > > > +	if (vm) {
> > > >  		int i;
> > > >  
> > > > +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> > > > +			mod_memcg_page_state(vm->pages[i],
> > > > +					     MEMCG_KERNEL_STACK_KB,
> > > > +					     -(int)(PAGE_SIZE / 1024));
> > > > +
> > > > +			memcg_kmem_uncharge(vm->pages[i],
> > > > +					    compound_order(vm->pages[i]));
> > > 
> > > when do we have order > 0 here?
> > 
> > I guess, it's not possible, but hard-coded 1 looked a bit crappy.
> > Do you think it's better?
> 
> Yes, specifying the known value (order 0) is much better. I asked
> myself the same question as Michal: we're walking through THREAD_SIZE
> in PAGE_SIZE steps, how could it possibly be a higher order page?
> 
> It adds an unnecessary branch to the code and the reader's brain.

Fair enough. Will switch over hard-coded order 0 in v3.

Thanks!
