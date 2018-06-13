Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 33A3CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8149208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dWCOAJMK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q+NbNJOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8149208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935707AbeFMTvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:51:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935291AbeFMTvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:51:16 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w5DJnGsG017340;
        Wed, 13 Jun 2018 12:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=leVYqtwnpfMNoHWZyX6EooDx+zlZIyUN8CZOppY9pnQ=;
 b=dWCOAJMKdgzrMuiAS1zkfMY8o8+BSHY+Pkbw+OrvniXyTuQ4RZ4I+MiGC8lSW44MsXho
 4PfuAGvrIrEWVsn0grg3+Dq/RwRuJGRmmgtGY9Tyz7R3mlrQbPIwCk1pJc7wNFYFOhXm
 3wdOT4qY/OR4mtvsYgRSNiBFeNG+u4oJZvg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2jk8bbg9mm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Jun 2018 12:51:07 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 13 Jun 2018 15:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leVYqtwnpfMNoHWZyX6EooDx+zlZIyUN8CZOppY9pnQ=;
 b=Q+NbNJOo5A6ZmHszch4khj5lh8w5BSR3HXmBIKex3C4z6X1WDknxKD47PvVMVQj7G83aYku7ytR/PSEOw0zzSgHF6kjvYduNc7Bf0iXrDBHlSAGw57gWqmgi7hLsEYdHibVWtYpNNGCMus57ZZFYGiHLQTcDuiw22rSmtv3Evd4=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:fa8) by
 BL2PR15MB1076.namprd15.prod.outlook.com (2603:10b6:201:17::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Wed, 13 Jun 2018 19:51:02 +0000
Date:   Wed, 13 Jun 2018 12:50:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: OOPSes in mem_cgroup_protected
Message-ID: <20180613195054.GA1647@castle.DHCP.thefacebook.com>
References: <CALAqxLXg8ry5hdNXhJRWE0vHuGbtP4xg=DWQ4t0w_Z-6MHmEmA@mail.gmail.com>
 <CALAqxLXf1QtUYQAE3T0sFzzuKh728KGxpY8pkFnnTLML+idbwg@mail.gmail.com>
 <20180613043309.GA5531@castle>
 <CALAqxLX1F7ZwXqVm4PDmHmJhKNmox8QL4GL9S03TAhfMxOCOyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALAqxLX1F7ZwXqVm4PDmHmJhKNmox8QL4GL9S03TAhfMxOCOyw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:fa8]
X-ClientProxiedBy: MWHPR1601CA0020.namprd16.prod.outlook.com
 (2603:10b6:300:da::30) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c63bf6-d5ac-47d3-dab3-08d5d166fe99
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:Sc3sp0XB5+mTb++vRGhChCUfivFPnZlyolcUxB+sF+RxrCaSsgAmPBwds/tn4bP9tokb13kcSeIXvQzYhTXVp22b73wIYph4uiVp/0JO3bEROwoyYYmYi81d9YW8t7Rt633pgGfvcH95mBtd2bx4RP++2u4r4zE7gybGoe/YxdB6FF0GMW2QA6wdGiojQOaI7sLK4tWZrlT0DiA082+dZMdKjCwIxA1F6AfPFNaPlAXd6XdK95V1ZL3inEdQFHkX;25:5IKisnlH1TO8zLtkq/a4yefvhTNmab7BfGr5JOFZXYRnQT+8r7vEwCeOV5zTpHXOc9KzmdChq4q7iulbLnobi5jp3Q6ozaA1Jjc/dbxEc0I6QY7t3/sQZP6YJbJYO1aamYdXDz0FH7R553JB0eHDOo4I7iyJm2S5nVC1DzQ4vap8vGOXNDAs+Ph1gIGuHKYKAgyvFOEzFAnvI6Vn6CuIkVLt34Id/pl61sk1oSclWjxJWd/PQZDMvngnsT7ABI+ULaehK+O5UnC07r2zno+c/iMCbFIFFAXWjTs33F2/MJv2Nw4bbBvaUgGHvOvZWn1n/mHuOfqeJhRLjdvTygfWhg==;31:QosPAlkaGHcjO1vLSeaQgWPaDqBHc5ed/omCcj2vlpTih0TD6axxaUYhEH/bGES1BNVfWQPlk2xM4d2/QyeO3oNAT7olDwl0i952Bz0p3v3diVe0Qe2ECzsV4WmRVQ03tNfQJVCUNuq9BaNYooidCSL8Z4edeonjqqcSPZcmWGtNPfOFnG0eNVtZg2K/jdezRiacyh6TjepCPRjDdY5PsRr4JdmorcGpV6tCVzgfvN4=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:tIL4L/O2J7SRKuaIKuM4iKnhjcyWFldOWjWwgtR9RKxKdsV+NdSaKT4/IF+3wb8DfuY+Y4ToYh7B9qLFyl0ohsXs6mCm59R1LbHPb6DAImGKkU//BKLIfEfGgMcFORQg1UYXW9DKXvtG+/oLd3moYow0OUO2ql96JvqCjYHKXasOfpZ6rMyFDfKQC+sA47Dytj6tjl1wrT3givpvc9Eqi2jCwKDUfmDCDIhnW833SR7VYBtxjNUYyaV4C09QwSmQ1wS8FL07ItUSMXlpI79ctd7GvmGkel8CNecZjIUipt8n5nTGyGbtgzqKcHWDBlzawnuqaUb97nlKNz7+VdLSLPbjv9bcUZWSvijr0SjMXOdcCo5NDgcaxMtTrlx41EQcF9cz+SfRTHwVd+UCh2QNHcZWL3JHiKUOZBDS451gDE1qIBpgafrRGoGCrJQrt6hb3NXJ1WkPCdah1SmYQe39wXtEKfUqIBvYnhT6XJhM61rDJpp9iLjCoHx/z5QX6EQO;4:6ceuS+i3lapQRhwBbmHrM43R9SPdTJohEr6s/87+vX7UEK0tObccemL+NnoFppnWfAZmQmVl3Rwy58Hv0z+RUuZXp3yaiDvzQYvfMMweKLEvlBw3h6PvdRpaI2vzkIHb0vHLmOoXiyoZ6u7cEAWwFBcihLCxMbQGRYaj48gRVfWiS2fXdyPaASejk/u3Q+8gbc+9EVP32lQEIjdtSJfmj1eBUek4XscnsGtJf4hJA49yhBna2SUd1Boh8fTwUkxQC5lkE90O1CnIQJvWjr7qhu9HLCeB1kJsFlRP+Vxevqfw0/l2bNJQK7h92NgGTney
X-Microsoft-Antispam-PRVS: <BL2PR15MB107695BC2EB3265653DA3FA4BE7E0@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(51914003)(189003)(199004)(7116003)(5660300001)(46003)(11346002)(478600001)(6246003)(446003)(93886005)(105586002)(486006)(2906002)(476003)(106356001)(186003)(6666003)(86362001)(55016002)(6916009)(9686003)(76176011)(52116002)(7696005)(68736007)(16526019)(53546011)(4326008)(386003)(229853002)(1076002)(23726003)(53936002)(50466002)(52396003)(6116002)(6506007)(97736004)(47776003)(81156014)(81166006)(7736002)(54906003)(8676002)(305945005)(16586007)(8936002)(25786009)(58126008)(316002)(33656002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:C7TL4Ci/OLIBBBkVHYkvZUKhjHMQgEh+d6dJy8VfE?=
 =?us-ascii?Q?O8ALPxVit/+GZQRYb7houULpavz0Mve7Iw4YU0LZ84PdtRCWPxNmmL/JbP0u?=
 =?us-ascii?Q?hTjxxLWXC8sfEbZ+tBiCJ0zZcD3I/Oo3s9BiFlBr5qIUTwjyp7CRq29riEzT?=
 =?us-ascii?Q?QXXHRsR88m4hKTQfgzbT6xhyH6kZp+XdKQdtQXAqK64FaiAbuQ6xO2yWVXbE?=
 =?us-ascii?Q?Dli/B//P2AlLG6mPA+PY2dVGCU+C+ZmFfA04lIN7AmyIwioqeP+ZpyEQi2bJ?=
 =?us-ascii?Q?yt0/vdv+qlv5PVue+Rv0KTVmESfy6C11aE63o6a6OM8utbsNNGZ/aZekj3gr?=
 =?us-ascii?Q?Fd03PKeLrQlT1l5fvhDAXoEqd7TmxVEoMGqTH5Z/eJqJifkxweuU8B9ag5C8?=
 =?us-ascii?Q?hGgFCucfnW8UUwvI9ZcPCbjJEJ1My8XSShUZFeWPEB4vKVME1rFwevfZF2o9?=
 =?us-ascii?Q?uUKtzmEXqzUH5y8GWQcdbdDd0AocFlgEbiOk8WFo8vXfx1PpGhg7XqrXy6/z?=
 =?us-ascii?Q?UBnOKflx8xsW1sSyS6hCUqr8xMjZhs2g7awMku6UlsTl/F4UTfcztYnzOLyh?=
 =?us-ascii?Q?jKHstrkkgxwVy3CWbM6jExdyXQYN/ONatSUVTNJqdRgSMXEZxhX+ZBINM5Hr?=
 =?us-ascii?Q?Set29ObLdenFxGbwumVDScsmmSrBSMyvyz5eB+0/qkmi6ZnJ1mG/Q7VyE561?=
 =?us-ascii?Q?k9bh53nQPrFhWUgcfDfL5yUv8XQAE2fEdprXUW8FT1UAqgHW7DN0xQCgyljd?=
 =?us-ascii?Q?wf0PTgRGBrcrCgd4l1nZXe2+ai9h9WGNmxPy0pfY0R+jZtAZRRDFleVT8Zdc?=
 =?us-ascii?Q?tVcXX12Wql7Q+7enCyjupK9bi+txAPsE6WofBPMLa6F4NqwPE3yBAUGGt47F?=
 =?us-ascii?Q?OIaCWyXsj+nld54WA/7ClrQdr6+jY1bqrH5trOmERmsAKXFxBrTPtwGJwI5D?=
 =?us-ascii?Q?aCQhrAxzxMd8v9tVAZtfKXf87kDwlohEDkKMEeUDKKadUDoLHO0jQdHXX6Eg?=
 =?us-ascii?Q?iXE6JNf+IyaDzrSE/XjL188LW+OtMRlGPL99NkuwDTnHhHIIn7dV5v+CQSgc?=
 =?us-ascii?Q?7k/mMeiRK72CGKrBsUSO0XoiOL2b49z89s5xLq0RArv8sfpmK1nflSuJ5sNH?=
 =?us-ascii?Q?k6raPBzapF6vxdjqTXSyvGwzRDFBbK3X/jc5F1uyl2H++Vrv9oB0Alrocnll?=
 =?us-ascii?Q?+3+nZW1eGqWOigKdDztSqBXs9SaBNKRs81uJh0APU6pmrVwGSk4FzGfpxmWO?=
 =?us-ascii?Q?o3XIMHlGmTfj4fdeoJUCdjZ7UW9/Wymm7QPxlhtLinTXUMx7CoHWsznQTwRj?=
 =?us-ascii?Q?3HtVNMOIVJHnZqGmN5JIuuD5lOIY9TzBy34LBcwGd/0?=
X-Microsoft-Antispam-Message-Info: VdiXQGgvtTji5Y+rB76siNLjWwT4QQL2vTlWrDcGe59CVDIUDN1UD8gGl85YwDlR8vIoArI07BY+UARAgh/IJhT2OQC1QMPlthh7quTg4r8E97GcUEu+I8XoHDu/R0oR4hdlxsOvf6uZIeV4g8YTS78UIBiR4PET7zTDNTjdDX45j5nhrLlNLuQZJZ2e/bzi
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:FcURKnALl8rrf4qWASjsXdKsM01g0axcdl5m9Pdlb53DxFV8sYluQHcwqjm45g8tFJ5MdRpDpBMQbthujncJO3Lg/SDhDITqut6GEP7V0we6m1oMRL1EXD+0nOvLNdPytBqWSV2eDnM8KZs2z0EcZkQJaTONOI8LvOsb2oJshQ+pgznmdmqVmP8uXK9rszHJ06b/vgxODT8v27ESy63dJ9diHxjYw6BGgSZWpXCUYbKDXcja/f9PQhc03alYRGSj2P1t5tZQjcUDECT6xZRg0H0pod1KaJqfONKP4MjEFxbuuP1+J8xHot/jWIjoIFtBJTK0c4LiH4g6udJmp5DTkHot+XAl0VOLV8bZBdLdLqI3np+lp4iI1FZgDMpuIU2MyRrD6Ed81ypIn8dXrEYt22oTyZn190FSl9EN3jZY/28Zq/YG6rPkE0i2Xna7nUsvtULkn2TkGDeNGBk65S3DOg==;5:e7r5zYiVXfch7eqOgf8uhcxkM8m7IK7+rjTrXnxWeqQOudfBCr7RDlWwXLrkF6MX/3mV3q4thOfAmoN37Y9xuOwmLStz1pH9VRDXWx9C2uYO+/V2YcwKuavaKQARaiDQox0t0XdBtwg7ugNm5rWCaqrtExuIj8jyMmkZ/TOidqw=;24:aLar69GjRu/z568UX+h4ZQalcLUaiNximFg8b3kMGkIo1SBhuU/EWF1MFEHjlzcZhwutIf460S1kHt1ImtUuDUqcB5S8fE+qhlT1x2yU8dQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;7:5SUHwejj1XgsPgJ95fcS6+lwX9tUvYwIIJCJwASP/p5v/1HRLrrPjdVX6yGZYrQ40sCQewCRWB8rwFu6yNdTRNzmmIydDDMhGaZmhQ8fk4hf/KdJG86HVY3J4+wxxvwW7u4wJlW1SMr6PlphU/lcGSZbLdJNMCBL3C+Yqy7RPvk4wxOfy8fmPG660PIcbtROvJqPGqd7Lm1XH8BijQ10FuFavny0YVCXD6f3W5z20tf3tfBhsf6l420AnoShWMRF;20:0fBGbz6DP63qjviTCY485Rs/YRSDEzcXB/GCI9ubhNvhX3stnptfdq6hg/7smpsRwDBaRye1ROLH23qZ6p05Ia4IgKyzOp3jAcnNDjo04rE9K+v6RdKGjo8RHSJWB2lsgQMQinZrqulYym0TN9cqSaaWGns05+gkUWABpcTKFaI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 19:51:02.2671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c63bf6-d5ac-47d3-dab3-08d5d166fe99
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:40:23PM -0700, John Stultz wrote:
> On Tue, Jun 12, 2018 at 9:33 PM, Roman Gushchin <guro@fb.com> wrote:
> > On Tue, Jun 12, 2018 at 09:08:27PM -0700, John Stultz wrote:
> >> On Tue, Jun 12, 2018 at 6:02 PM, John Stultz <john.stultz@linaro.org> wrote:
> >> > Hey Tejun,
> >> >   With the current linus/master, I'm able to fairly regularly trip
> >> > OOPSes (two examples below) in mem_cgroup_protected(), which seems to
> >> > be new.  I haven't managed to trigger this sort of thing with v4.17.
> >> >
> >> > I've not had much time to dig in or bisect it - I only know that
> >> > enabling most of the memory debuging config options didn't seem to
> >> > trip anything prior to the issue. So I wanted to send you a heads up
> >> > to see if there was already known, or if there was anything you might
> >> > suggest to help chase this down.
> >>
> >>
> >> So the line where we're crashing seems to be in mem_cgroup_protected():
> >>   parent_emin = READ_ONCE(parent->memory.emin);
> >>
> >> where I'm guessing the parent->memory value is null, and emin is at
> >> the 0x120 offset in the strucutre.
> >>
> >> Reverting the following commits seems to avoid the issue.
> >> bf8d5d52ffe8 ("memcg: introduce memory.min")
> >> 5f93ad67436b ("mm: treat memory.low value inclusive")
> >> 230671533d64 ("mm: memory.low hierarchical behavior")
> >>
> >> I'm guessing I'm tripping over some path where the memory value never
> >> gets initialized?
> >>
> >> Any ideas or suggestions?
> >
> > Hi, John!
> >
> > The patch below should fix the problem.
> > It's in the mm tree right now, and hopefully will be merged upstream asap.
> > Sorry for the inconvenience.
> 
> No worries, thanks for the quick fix! The patch you sent seems to be
> working well!

Perfect, thanks!
