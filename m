Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB1FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2558720BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="he6roAuh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dbhY7K+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2558720BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeHOTsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:48:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729347AbeHOTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:48:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FGtcXq003292;
        Wed, 15 Aug 2018 09:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=63L+FYLZ5r2I5JwDiCG5/mGiMnlwAR7/rObgQjydjAQ=;
 b=he6roAuhUGR9K+josHKYSUScQmxC5Je1NNDnNVvigy9dhL327TpwvthDAt0LdUE/t76v
 00vhhz884PNW47TlEE0sGkz8TcKCOSTG5DnqiQ1GLeEKIhTAT34hteNxLcKYZReXcvi7
 rSohbMe0rTxg5J1pLYmtuQDdSYSlfojjkgo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kvn0rrmfq-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 15 Aug 2018 09:55:38 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 15 Aug 2018 09:55:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63L+FYLZ5r2I5JwDiCG5/mGiMnlwAR7/rObgQjydjAQ=;
 b=dbhY7K+7QjcuzNR2jkPNh9Obi1BI91sLI08DdPZYxsnlFTFazefWR+RkK2OTw1ayVh56wTrBC+8m+rAHlExTzH1lbJoqMlESbh8KlOCj+CQ9rffE3/hxFJZv4oqFhuhRRPHIiy1SNFJV8+s9PXBwEd3OpY7s+MWqC/i+ppvV+xM=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:abf7) by
 BLUPR15MB0161.namprd15.prod.outlook.com (2a01:111:e400:5248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Wed, 15 Aug
 2018 16:55:23 +0000
Date:   Wed, 15 Aug 2018 09:55:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180815165513.GA26330@castle.DHCP.thefacebook.com>
References: <20180815003620.15678-1-guro@fb.com>
 <20180815163923.GA28953@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180815163923.GA28953@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:abf7]
X-ClientProxiedBy: MWHPR2201CA0033.namprd22.prod.outlook.com
 (2603:10b6:301:28::46) To BLUPR15MB0161.namprd15.prod.outlook.com
 (2a01:111:e400:5248::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22c8e998-1e58-4978-c16d-08d602cfe4f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0161;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;3:N/pubUeskhz+vF7GstNHBOXBNvKQ/T8EnmpgD4d4J/dFqckKjdwJYaP2YBAH1D0gg0J+8OHbG/pzyKVDBrPQqC3q7Raj1s44S9aAwkCHqNLxY1gsiplq+BEGYFIkjTzvXJydv6rz5GGZu/2yvZpxTdWA1ciYB4h8sAtmRNx88ziRATNGEQcvPxKZpr7fPd5BEaUMJWWReKcGcfe3FtldqX+LcUuHLy5xKnJdCBwJkYlwb08gTaZZqg1cC6QKvL8i;25:NA+M8zZ/5GGZbidqK385C4yCMWZBKTvgIposhmg/oUFu5y3O2TCBuwUKnpvD5QjQZFRlM9zqYa2UF+RvhAk8tfKV6JS1DWxFD5oJHsYGzlLkA+8HJ8e2bfRuHTIa5fvKk9xqNApZzILj3T7AsVmFYhswu9mVHCVQ25yWUtHHjt0p3dmVxbNm94uaxOAiOMFHBcEjMmuadlAnHZl4gVEmSH9xrl0xUmmGo0W0S7u0e3zdPWvqubmj5XWg6cnLukODmlfNcLRCqgT96WTFAsmiGz6rRkv5J/DmbNkY3T3SOs++6iQ3eF2FU3cgesDmViecTweY+XAvYkeO9LBWlQqqFA==;31:91rW5oN/bpxnT2Xna/le5C6A+LxQYt17kQzncV54UvCkO217HaG/p4fDb5UN46ZXVS8VbwKbM7dBJg05k8tidIIxjFVD1xcETg8Rd5LKgwaJjWw6qyoZzN8juc26SWuUzPlrwhXNS5cts5W3Z0NHqUjcsfnJjo7XxdqIN6k2a9MytVYZV6N/UaFsJw1XVlBWh7Mq9XqHJooTsGpr0MJrh7o4bDUW363yV+IQqBukDaw=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0161:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:iAluhBR/uN6yQ7ZZDclKu67UQHjG0NLKA1LXghifnt+QKOGAswXPiVwrPYK3+vMacIIvL8TBW+AzaUvt39dn0v8lfHQxofRuIMJrDlTXevKn0F8IwMbBihj1LeBUHFsKhE40+nzibB3e3G9jpxkeiSvCoz4qU2BtD9QHUCSR6wkHCLos4oIo7oqgFVbeWPSZ2KEGjlzdHEiNOd5afKXAlUNorlyt829JxdB4TN6x7KsOIEYCT4Ks7N41p3YtEHWmXmKJFBHWM6W2mAg4SiJGv+Bw0Atl4rNsUeTlY//kF+Ubi/aDt4x3ZaJSOS+L0M+JU1ru8b/ORNYOxvft5iGKb/7GxLBHPh9t0bK1mFM0qQP+B3JrsPTaic+OkwojutAjyb8jFpzTfBIrW2iKAMjvKwSH2iZIFN4xUsyKMt5rqGIelTum5YknM4zn97ptVsRs92vYR0UO+Stf/GWmeLE0LywUBlLSX1MEU+hOKSHhPDDO7fz7Dw1Ic3SXPAItWaCA;4:0ZF5p9WF96fj3fuSrCrFrwPdwg0CqC3wj5p+mEItv8EuFpBcG+yemBTfFmJU7FIo8875mFTvBTLlOiYSrBI6lYM1Y7n8qw+W/8Vs4744JgNW++H6KvalJfoYuz3AYMFVELZ7W3j7l5QsQi6XC9Y8u2wuqbrWvbexaNOSgiuyoT87WiWiFOrPV6+O7PFxI3rGdPc2oBoeCLaeR/EBXYXVFiCWC1Om6cPiEXilQh9em75xFDN7ERvxDz8vmGFCVR4pKSLaW6X6MKAqoZkJO1BnOQ==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0161AA807A778F9C813AD9F5BE3F0@BLUPR15MB0161.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0161;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0161;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(6116002)(52116002)(86362001)(8676002)(81166006)(81156014)(316002)(8936002)(9686003)(25786009)(478600001)(6506007)(7696005)(386003)(486006)(52396003)(50466002)(46003)(229853002)(1076002)(97736004)(15650500001)(68736007)(76176011)(14444005)(58126008)(446003)(305945005)(2906002)(105586002)(55016002)(6666003)(11346002)(106356001)(7736002)(23726003)(16586007)(54906003)(6916009)(53936002)(217873002)(39060400002)(4326008)(47776003)(33656002)(5660300001)(476003)(186003)(6246003)(16526019)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0161;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0161;23:bFmRO/OhFQ8FkD3ESGbNhWLFX5ZY6MZ/GDKOXF4UA?=
 =?us-ascii?Q?qonRCWXwmhABrWMFKWVJ/ApbfAp2bKiDut6csl1L9uo4qp1HmP+NL1Dph0Do?=
 =?us-ascii?Q?fEWOuuiT23d64AO8Tf3e+4B/eleD6VzVKBMZHw7tQkYWsZ2Od1RhPzz0wlva?=
 =?us-ascii?Q?WbsVJmAz10jNTMUdiAIhhbL+1KD+BRIVm6vmVz8GY9A8hQDRV1lfbcjNguRm?=
 =?us-ascii?Q?itKnTKyNnnppLIKKERgw/74uoMXW1CwwRfkJ74OwQ0hOYRvJj3xiT0aDtwsu?=
 =?us-ascii?Q?UIZe0z1XlDZIx1AMAba3jHu9Z491qIJDsS2rYPoOdRusngSX7sBWoHFt5cQH?=
 =?us-ascii?Q?0js6B+KjU5qXD4WB2261wLOxIARScpqJrXRv2I1YolY/78s6Ngj6R8YILZF/?=
 =?us-ascii?Q?g+12xhFTqDVxCdfpwhx5oXR4jLuqifr4ZolxIpSLg7oislVf2NpcjHjv5NUz?=
 =?us-ascii?Q?DLTR4KtCoUtis3WuXYurJPt41zcHn0Rj21VqFhUeSGuaRH7EHj9hwnSpmr3A?=
 =?us-ascii?Q?d3ZDltzU5hQ/EN0zSDCTOLP4SZQoRYVrA3Fq2Hl9BYXHmdSci7qjPM7xYZ9c?=
 =?us-ascii?Q?XH1l1HDxCd05AAkDbNp5u1dSWGRLcrfTCVMHDKRy7Tgf6CRtDK6MCYn2Ozif?=
 =?us-ascii?Q?HYwcr6vomLUtatcFkB4/WZuR61+yNcz1MvhvydqHRGVjQCe6DTxLrgbCQutM?=
 =?us-ascii?Q?IDIL6vQbU4D90Pz40clpUfUCeXCbXv9bq0hDjUrKfrPvBiZ22p+dKyxB3xA1?=
 =?us-ascii?Q?8jijet1Ra5s+yL1TcZ4GVvOTM1UjLCv+y2AdJb8I25zfKs5Z0WP7bdvSn40c?=
 =?us-ascii?Q?m2Rt8E8dILStk/jojEyVNQr9478ztiCc4VWCOgBmYXFlgXqLeZxXZshBGbn2?=
 =?us-ascii?Q?V5MsY0/tlyi3nsQv3B0p2M2p2Z38mh1bK/KOnku4vJ1+7nI8siECh0YoOj2S?=
 =?us-ascii?Q?ucNpxcD45vvV1Sne/0uQoF4vKMy8FPNZT0a+nfceKVf9I5T3YjlXro6arT57?=
 =?us-ascii?Q?bsVCzu2NTI+H2TW5eza5vVObxZwXMxXIDx9Qd/cNLc4zoBkyvPvqvxgcSh6p?=
 =?us-ascii?Q?NvYX4lK8p6J5CeCIVVSwi1yx9PEv7UPsxOnLcNwwFWkFEuwsVmP/KgviBYXt?=
 =?us-ascii?Q?htvVLl2bdv0hHs6GQxPzAj+NGYIVqc622VJDv+X9055DnuENAWgC2g5VzrK1?=
 =?us-ascii?Q?+8xfseXf/ket0u+pkdViIf3bjgsBG5ZqLCfgsO4eWOlBO7+t1X2k8H9+Jja+?=
 =?us-ascii?Q?+36oMcF2E1MRryLXibJ6M37nrCO9ibx9t9JUv34J4BQ5AC4mLhES8XnTFZjU?=
 =?us-ascii?Q?M+vrsHJU+Kf+rOviBQx5yBxGmt5nqbXET8BvnyvCj/q?=
X-Microsoft-Antispam-Message-Info: bR3MbMA0krcYwBM8elmeMq7WXBjCtNbaDgf0WnyAE/6iZZYJy8qqfG6rArauiQE6zrZ0VWlBug6FrtBGX0i2lZkdzBTzD+oSCx52Xei2usZkEhzTh2H8fKiDoTuX0OWbguMOBV7B3jkqDqQPe3AIgHRLS+V5pEdr+SBRMZcIkNsBwjYo05HZyqWk+D8QR1cRD0Gye37znlbmm9Qe57mJnzb9HztVWaxS+cEuMzKwjaHuHqOrDlcpQS1NmR7xto1j0WkfVLmDopZa76AQNWeUEBxYbrPQH0zHOgEa22DkzqS9JIwTK2NPLEJMhxf60D7s9qqe+V9saQrW02/2zAQcNUrr3d4xnEiMt3XVUBhXXro=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;6:ih292WXSueys1AoYpgv5upcKAJPfmHRMCMeZShFbWCY5sL+nFtMwjAodqb69HHdi7rZj8PW1gNZZsRxTIu85HkrRRN4KefZxF2eR9odzRrWNdGPp4FjlPuTzAMalSXkFgCSNVw5Dl07a9Db1/EuoNqwrW7PXpwSAemVBSjLgG6QrIT6OtlsaIf0FBzAu79IuRKbLCXcRZbElvAPA+8Ceo0MlfOgVCi9+J/AG6/kf/JLDvzLGBzSIwmzr8EBwWWsY5xQOEapIUqXN/ePQlh7RluwKmv887QaUvMq7Zz/xpoj98Loq5RHfw4xGmv51d6WdI2vIfORHirA+geLeKmJ5UDVqt/Iv+QXUMMnZ22Oq9QrtzMmqwQlYVH8KluMQ1otERRLQDb7Zthv2pYsRJGwsz+DlzmXINcQ58vVUo1dXFoqdnAgnL4fsR0S1MrsU0Pt4GWLHPvXIe0Uw8hMx5xbzpQ==;5:HRAdLtZbrp2NSpSwkDTEEaKTuxRnFEgHqMTmJJwhk+wP++FKzFyW6EPZYf1XiAPT2rK8RFP5ecQTrj9gKym4JrIS2kXQ0vxAWtgojCRuYdJ2xWbp5k/bt9K6SKjWzZS0W00HM5idtzP4gij8Ja9/JWhZqFQjZIaNZ0Um5G/P8Z0=;7:4iIHUvHDUMIpuC9I8kaQt+aAgw1UQ2yRXgs54NxlHK2pyptPZCb/bQaTibZsqdZQb8QOxtvHEEZYfXWBlKQyMsTdEp/u1KXNTslLChpkkVVkT0+3dTanfhg8TPSaNk+i3xbtXcNbh+27o2gg4vz9aoK3jDXkovd6DtI1uRnViwIIH9xjMZq8LmcyqeON+/BQWOxlPe+la9xWaM3NvKKBCDCNss0c1ExU/BCJhoWfGkZKVt3HiSSMWlgPGvFhJnMG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:vSPhlFtpVuYjgGfrclkXbQjJZ5TiGdsdqxCFC3DPX7T393r41GL4rjR8pcMmVb93aRv3fr3xzWNiljfw4S7DqSVdNikAPIDi1BdMHZBylG400Pox8WAp0uMhoWlrmBNOZJegqqF+xGZ1dMf1bXMdQiPQotEcMBWLeWhQ6r/u8O4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 16:55:23.1660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c8e998-1e58-4978-c16d-08d602cfe4f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:39:23PM -0400, Johannes Weiner wrote:
> On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
> > @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >  		return s->addr;
> >  	}
> >  
> > +	/*
> > +	 * Allocated stacks are cached and later reused by new threads,
> > +	 * so memcg accounting is performed manually on assigning/releasing
> > +	 * stacks to tasks. Drop __GFP_ACCOUNT.
> > +	 */
> >  	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> >  				     VMALLOC_START, VMALLOC_END,
> > -				     THREADINFO_GFP,
> > +				     THREADINFO_GFP & ~__GFP_ACCOUNT,
> >  				     PAGE_KERNEL,
> >  				     0, node, __builtin_return_address(0));
> >  
> > @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >  #endif
> >  }
> >  
> > +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> > +{
> > +#ifdef CONFIG_VMAP_STACK
> > +	struct vm_struct *vm = task_stack_vm_area(tsk);
> > +
> > +	if (vm) {
> > +		int i;
> > +
> > +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > +			memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> > +					  compound_order(vm->pages[i]));
> > +
> > +		/* All stack pages belong to the same memcg. */
> > +		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> > +				     THREAD_SIZE / 1024);
> > +	}
> > +#endif
> > +}
> 
> Before this change, the memory limit can fail the fork, but afterwards
> fork() can grow memory consumption unimpeded by the cgroup settings.
> 
> Can we continue to use try_charge() here and fail the fork?

We can, but I'm not convinced we should.

Kernel stack is relatively small, and it's already allocated at this point.
So IMO exceeding the memcg limit for 1-2 pages isn't worse than
adding complexity and handle this case (e.g. uncharge partially
charged stack). Do you have an example, when it does matter?
