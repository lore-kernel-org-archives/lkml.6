Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9ABC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B24216F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KVgkZ0Wh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CZNCCmym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B24216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934335AbeGFS01 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:26:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933999AbeGFS0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:26:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66IPLRU029641;
        Fri, 6 Jul 2018 11:25:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=VgbdT04kGmog+L2R7iiGPv5tP2sFIKpoiXByiPwUpns=;
 b=KVgkZ0WhEsVA0rA2ip/mrUMj0C22gqcb7AeT/N2gvNFtVbyrMCyDyPYPQsKigLzIQIV6
 TgD3QlJrOE9Y8gEq8/P9RWwTy0XCHzVdOj4iX1B50NnRhT7ydjdCIqJShEj0FhsdUous
 YQFvLvtFE6txowsP9G+QMhcgN1AtKfX6p3E= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2bnqrdjf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 11:25:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 6 Jul 2018 11:25:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgbdT04kGmog+L2R7iiGPv5tP2sFIKpoiXByiPwUpns=;
 b=CZNCCmymuFML/sLdr3pjwX5V63AbT2ThgyfUJvxFQxzzFFH/7jRRTHc/wkh8xQHtZifHmTu6tJdfeKo/VwTCvdYuZrhzaeB7pxHpRMbu1hfPz0zhWS6ILI7kFwlfjc/pnkkIJvmurlP1SiATLkawNFwLxhVLE+R8yMKqNv9Z8BM=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:17d7) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 6 Jul
 2018 18:25:50 +0000
Date:   Fri, 6 Jul 2018 11:25:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: introduce cgroup tree command
Message-ID: <20180706182542.GA27167@castle.DHCP.thefacebook.com>
References: <20180706010521.23097-1-guro@fb.com>
 <20180705190116.7737d66d@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180705190116.7737d66d@cakuba.netronome.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:17d7]
X-ClientProxiedBy: MWHPR1401CA0015.namprd14.prod.outlook.com
 (2603:10b6:301:4b::25) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250c4422-1548-4e50-d9e4-08d5e36de74d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:CosGProA8foZA5q7KQ2DXnrJ/1dl7NLKv/Tp7jH2hcema/LBKhQd8xUf+Uh+vRQRhs1vlYPOxpgl6Wm8PEsWGlzfizljPEbPmIlNfg2NZ998xR7q2+4oWvJvPLneJ90a2XSFxJP+QKy5cGneTjT9AQiEwbmMMMm18Z7+5LE9rdc5dt5xrVIdzlmQe0003IlYScOZMs7hgAAGsddTeLdrfrOVwB5uA1x87lcCGqc2qNUnRSaawPX0o0GOyvCAfeC0;25:9VTdywxWCmPP3Oim8Fb2gMUdQqx+LgRBwhsZckatPS7yfMqOYMVC36fcB+Gg/kJrhHdrrZ5JWM3I+m/uMZZ6r4yD2XgZXeLF1/u5oKAmRY3r6v5h56BsXDR286mOKsy4iHlI3Xg0ZZ+5QCDMmo4cyiiiKlnzHBGw29KfnoG5SB0NzNlE198DRUirfz4TUDfM33swObOaISaPNrvvJsjssCZteRPYtvzTDxD79aqbavvu1y+F1y2DX+VRwMkAk40hTakgy4P6+Xa1uV57N9XeNigNj0J49OJJJ4l8kDaLukBgtMEK88/Lwti/9ceFgrHluxvKq4MH7ozCIqZ8YV7SFg==;31:xLlFgN50SQDh6a19FGRANaxxEqPgRk97h1m57p/wxI0WiB5532Uh+g+2N6fRm2iyAF0Z5oWBd0EWVmqE3OCYOfcUxpEREOtL4T9dGYTukM0nEi9P0eN5tG/Kf3+knAOjlmEp10+v4Gfb60Rbyd3ydM5MasuRuL0VJmElNaYLfP6U71FjEgZstbXo7m2KxXEocGLs1o2gRayW0TbkbEwtA6FQoGMU5CHt5cLeMCgEFpc=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:FmAFbPYrFKsfB9C/+8EA66U1PTtxfdV6CsnLWykcnsIomTNsitC0JiPcnMeMhknGQo304URe+GHkP6Yk+fi4v/IaORHerEAaOO+lercscq9RTbE69VWIh/knWnfTBQkLTpABYIQJn5I4P4Sld+HvqHgyUafaNk4ERq+INsY+/zXL8ESQgoZm4lOiEtyfRYszq+5w4aMPUPhIb6j9ueycxWYnOlxjh47BB6CyCo5tfJ2LXV4H1qqEtA1y4QMX6vHMP2Az9qLtg0PiHLEh2MYsFrCaUKNbpfyriFhy+jCzLklckI/GUNf7G3bQDyCglC65gTYiY32YJ/h9eFzPDulBYseV+/PybKxHe7Sp9RU48OaDkBQA8S1SCeU/UB8Mo9b/rJtNRqTduQyYldyxmuWxDjV4ZjOuXKQh4AZnDK6BsIvk1swdoubYzDsxnTedP84J4J+4zk6hL3TnHLbDLUCLp3rLpYRq9NLCRAIaSYgza88q2IMJJTm+C29MTQZ2yD0l;4:Iz+6+7y4vK6K1ku6F5WL93RWgqKEToKhuZtIMhkcEeGPKjXWNOtRLoS5QUVDhpFOknqcEgQJkBLerphaMjpMCwrGkraMvgXlczRKUQWaas/aILjVYTrZT7EQmYwhmnnC8E/UqeNKAVQa+aR3pnFnjd/k4rgBb/9Dustv0KSUXlRaIHabcEXiQD1Lg1W2yGa4nNx9WNwpNxyzhLHto5MXyQlOUtrB/EwuIFIFTx0Z6FUUvfLzC9KodgudSc71ZoLPqUpmGuXmCaRNcGWSYWAxc/j5bLhphnvFKLwlAUtsNEg+yiXJnXqiDQ18ynTzue7gDCqZIaEWM+Tdkl9cIdBmoRLFQ24j5nX8b5ERT8Czzuc=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167AC3DD64FD5F9F9EA7192BE470@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(105586002)(86362001)(446003)(11346002)(476003)(486006)(2906002)(7736002)(305945005)(8936002)(81166006)(81156014)(8676002)(58126008)(16586007)(68736007)(54906003)(316002)(106356001)(33656002)(5660300001)(6666003)(6916009)(52396003)(7696005)(52116002)(6506007)(386003)(229853002)(76176011)(46003)(5024004)(14444005)(186003)(16526019)(97736004)(47776003)(55016002)(9686003)(50466002)(6116002)(39060400002)(4326008)(25786009)(23726003)(6246003)(53936002)(1076002)(478600001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:uct+bVTQZW7LMh0RTZucCagUH2NUz3ApbDiWugEl8?=
 =?us-ascii?Q?3BvMPKAd8EjquFz/pGJlgmoaxyxCiP1zNUh0DJ3RvDZJdby9V8cgWYF+8/Fg?=
 =?us-ascii?Q?cqKygce2zwrQ8bA6907YRgOcJSzvo7+1302yv3w7/8yePPAry6A7SMHe7gvB?=
 =?us-ascii?Q?MYohuJmG9oGBylrLW/Pmeu14+Z19CTj/5hdP8gUT1CDUCQEOUpDyJ62eerv/?=
 =?us-ascii?Q?UZXDr6eYvBCHuDRCFw+KVYh21P3EJ1oEAKZ8468+/cD7DEAlU6QuWeysgFgE?=
 =?us-ascii?Q?ty+fjI9aAhN5jnzo1MJKeUU+rnZR53bO3XUAX4Emk1GoMDLwaeyo8w+CBMy5?=
 =?us-ascii?Q?BFbo+UgUKYFgMrXJi0Rc1XpYyVSpr1BVMusBCEhfpfH8dUuAkU8PqfW2XAKU?=
 =?us-ascii?Q?4i9ASC+y/lpFEinUSknimdTsY8OU/Hmu5Yiw2AV+s3y97gZPQYD5m2L0Z+aQ?=
 =?us-ascii?Q?FNOfI/qSTcN1l6iNE7K1hwhT2dzDJAa/MR5wFm4ObVE9Lifm9exqqMmC6+GC?=
 =?us-ascii?Q?vN1Y+29a8VBMg0bJCPyxD/OzRuEDr57lKw3y3q+ewI4Tm6Bvh38Ee/5HGdCY?=
 =?us-ascii?Q?GxJyw/gakIqGjVofzZOSb1lLZNX08d+mEJdWhco2R1Q0Tm9tcfiqXi8Ze3wz?=
 =?us-ascii?Q?eLSRRrDBCfzg/1GUnAvC8Xn4mUBCXWRJrKgfdOGoOZligp6KI3+XUbgXWrZW?=
 =?us-ascii?Q?OmYbu20SDywmyTYpJkonUHqczr+BGbODTFHsn24x3HnuaoXv1xHezNzbS0QM?=
 =?us-ascii?Q?vURsiI43JYG4nmjL0WRKvB44uqBgbFRqOkK0iDHaG5XARrsv56OGs059Mkla?=
 =?us-ascii?Q?/JxpLKzXrUuzgyxuBbh1mfQachxDrcB62CRFPZ0yd/8KmKPF2sT+/bOcmC4k?=
 =?us-ascii?Q?EaLLwDVBTUpXrHSFlZzZwp3ueLHDGOHtJClKGAadSEuHbmlLiSJrL6fIniXy?=
 =?us-ascii?Q?bQPeSbFBU8pIYNaQBO4mbwwujHIKLMHTvSeVGTWlHF/PSlfk6fYjVDz/AaiC?=
 =?us-ascii?Q?iAV2CM7jSzDgjgc/PSkIIvvkgg1oSH4WwYpR6sTKSU9dob3Ovzp86QO/VDly?=
 =?us-ascii?Q?+ReF/nGTpi7/F32fDec25d2gJoopNoUDom1ofRW+Zq8kOzROrg2s6baehZNo?=
 =?us-ascii?Q?m0HlLOF3WfYNtfte9RXao5RCTvc2Hf4fl8fKK580wfu8nNujEF7y7P2y60GF?=
 =?us-ascii?Q?rJv0NWtf8IyhFF8d6hig3FM30YyGR3KecBcXPLx0weSTE5MTocDkF4G+4o6M?=
 =?us-ascii?Q?1GueSiui/GNdWPnaggjevJeX8IkGhh5CfrMsYTFpxcj3MpW/Owlq1YzkgD3G?=
 =?us-ascii?Q?tSj+nT2u/gNxbuN9xglzXs=3D?=
X-Microsoft-Antispam-Message-Info: 1P7wFgBEMmFK/i8/oTwPNoD+8CUmlaVImcmG0JyvsT69tB/pw1FkVp15jzBLbnEwD7BYT/mbAI/8vqAff046TzW0oAk6mxdh+NG8tzcZMxZevYcQN/0lW5fB6kQMN57RpvB54r0JCs6xGSGXIdmlZ66hHxtIBI67182Uf54eNtVvD/OVdlJc86tD7x3TgXUfnecWMGYZ5mYNBYF9v3ICD0CaO3S8mLO8FiorIybxAcmyhmD6T6G1TrzBWTAw1f1c6wRvva7xblwIT4Dty+TnYn/394kjNAPRS2C4UMqs4u3+sgxuT1vY3o+R1pN+Vlc5y2fIwbbNV4VNVUq7i/1s8pFOvMHjZ6a5hS5JksjBzpA=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:3j5PYrtb2JNuYMWaLDrKzoz5My1Jxy/9UnUiQjR9P1i0PaazP+A5gu2HO75tVKDupd//T5vGe7JWUAP0c0ceII6E6UeIPg74h3dJ7LrveAujQDIi+vksp7c04n9XkrvA1f/G8rv3uTlSIW8vKEwYTtyagp/vI1ocDnTjOZeO4+veuoCNb6qssyl5b5lO7DBxe8DRgqxaltguxHbmDFXzcmg65/wW7feS6KVHoYv9AXXDQHDXiAaAshHLQs8H0i62BPkZEXITtXJfNjy4tm2DgHimd93QTaON2+8mZKwdAvvqJ4afXQduEKn05U13R4JSQdVEXJtHvhN8JTdQS6IynW+PRUNhrngbjaTHlr99Fm862/qmhq2B9Mex1HoJFBARStWd/wzZFlsZmp3Xsmw82yv2Q4O4qRcUOBBjElxxjilAY3wjRKmy6ObcjmIQUv3ZQ4X9xrw0ooLkbvw0/RJplg==;5:PtL44YwPz8A0ivovzaE+3X00w/G2ryBx/zGFHC67FQcmC1FQQm+FIDV6Xe+pfoUCdsV85qFZZeMmLnuEFWQzbebWXmx0c6dHjCWN2lWJ1RZW0PA+VJPXtbyYXv1BYBvxj0MAHwxWXyb7RqFzjXh/u8Jgs2ibK3IikacvDCTTga4=;24:o3nxnp1Ne6tmhmUMRUQ3appfMuUaDCbVS+hQZidO5Dy1uLAdlXDf/42AnFMLNeAwVil9Tvc45NtT0Y/DbXBkirqz6jDTBeOBhYf58LfkaLg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:xV6fHLW6T16KQRe/1y//K1rsaHH89vUPrzC5FHiMTNeVuxwJ1SyvWEL+eOS4yYuN3HSU5AUN1hKjpEGzNpJFfoyX25hZij2ct8U7sCnuZxdrpmd0HXYo4sDBPHSJygNxDwdyET08ULAAQG4QleWUA4jY7uR5v7wvrBjkD6yaTBUw4YD3Xa3xahOHc92icZTMHnb4azXKm0Gz1V5VqPjOrAdaRlSE3jxYxp4rom/maj2kIH19GxCKhImH/JdZtIVS;20:oCFA9edkHeBwEd7BkbU3nsFeETZkfbnktlbNrKFvvc+z3OxUn/Aa/04p/PAWSkCQ0Q2kXqpaBXBcbx0mB5r6/+XaucFJNm9xLIciLhhw7LHaK8okzKgwNWcv9ND5wLUA8IWDBi1GpXfzLdmnrcotyzL40GP8zrqA4iAqJvdsdkc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 18:25:50.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250c4422-1548-4e50-d9e4-08d5e36de74d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:01:16PM -0700, Jakub Kicinski wrote:
> On Thu, 5 Jul 2018 18:05:20 -0700, Roman Gushchin wrote:
> > This commit introduces a new bpftool command: cgroup tree.
> > The idea is to iterate over the whole cgroup tree and print
> > all attached programs.
> > 
> > I was debugging a bpf/systemd issue, and found, that there is
> > no simple way to listen all bpf programs attached to cgroups.
> > I did master something in bash, but after some time got tired of it,
> > and decided, that adding a dedicated bpftool command could be
> > a better idea.
> > 
> > So, here it is:
> >   $ sudo ./bpftool cgroup tree
> >   CgroupPath
> >   ID       AttachType      AttachFlags     Name
> >   /sys/fs/cgroup/system.slice/systemd-machined.service
> >       18       ingress
> >       17       egress
> >   /sys/fs/cgroup/system.slice/systemd-logind.service
> >       20       ingress
> >       19       egress
> >   /sys/fs/cgroup/system.slice/systemd-udevd.service
> >       16       ingress
> >       15       egress
> >   /sys/fs/cgroup/system.slice/systemd-journald.service
> >       14       ingress
> >       13       egress
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Cc: Quentin Monnet <quentin.monnet@netronome.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> 
> Looks very useful!  Minor nits/questions below.  I think the reverse
> mapping could also be interesting - similar to how -f flag shows where
> program is pinned, we could add a flag which in 
> 
> # bpftool prog show/list
> 
> adds info about cgroups where the program is attached?  Obviously as a
> future extension.

Well, it would be convenient, but it's not always possible.
A program can be attached to a dying cgroup (a cgroup which was deleted
by a user, but still has some associated resources, e.g. pagecache).

> 
> > diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> > index 16bee011e16c..125d5b6db568 100644
> > --- a/tools/bpf/bpftool/cgroup.c
> > +++ b/tools/bpf/bpftool/cgroup.c
> > @@ -2,7 +2,12 @@
> >  // Copyright (C) 2017 Facebook
> >  // Author: Roman Gushchin <guro@fb.com>
> >  
> > +#define _XOPEN_SOURCE 500
> > +#include <errno.h>
> >  #include <fcntl.h>
> > +#include <ftw.h>
> > +#include <mntent.h>
> > +#include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <sys/stat.h>
> > @@ -53,7 +58,8 @@ static enum bpf_attach_type parse_attach_type(const char *str)
> >  }
> >  
> >  static int show_bpf_prog(int id, const char *attach_type_str,
> > -			 const char *attach_flags_str)
> > +			 const char *attach_flags_str,
> > +			 int level)
> >  {
> >  	struct bpf_prog_info info = {};
> >  	__u32 info_len = sizeof(info);
> > @@ -78,7 +84,8 @@ static int show_bpf_prog(int id, const char *attach_type_str,
> >  		jsonw_string_field(json_wtr, "name", info.name);
> >  		jsonw_end_object(json_wtr);
> >  	} else {
> > -		printf("%-8u %-15s %-15s %-15s\n", info.id,
> > +		printf("%s%-8u %-15s %-15s %-15s\n", level ? "    " : "",
> > +		       info.id,
> >  		       attach_type_str,
> >  		       attach_flags_str,
> >  		       info.name);
> > @@ -88,7 +95,20 @@ static int show_bpf_prog(int id, const char *attach_type_str,
> >  	return 0;
> >  }
> >  
> > -static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
> > +static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
> > +{
> > +	__u32 prog_cnt = 0;
> > +	int ret;
> > +
> > +	ret = bpf_prog_query(cgroup_fd, type, 0, NULL, NULL, &prog_cnt);
> > +	if (ret)
> > +		return -1;
> > +
> > +	return prog_cnt;
> > +}
> > +
> > +static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
> > +				   int level)
> >  {
> >  	__u32 prog_ids[1024] = {0};
> >  	char *attach_flags_str;
> > @@ -123,7 +143,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
> >  
> >  	for (iter = 0; iter < prog_cnt; iter++)
> >  		show_bpf_prog(prog_ids[iter], attach_type_strings[type],
> > -			      attach_flags_str);
> > +			      attach_flags_str, level);
> >  
> >  	return 0;
> >  }
> > @@ -161,7 +181,7 @@ static int do_show(int argc, char **argv)
> >  		 * If we were able to get the show for at least one
> >  		 * attach type, let's return 0.
> >  		 */
> > -		if (show_attached_bpf_progs(cgroup_fd, type) == 0)
> > +		if (show_attached_bpf_progs(cgroup_fd, type, 0) == 0)
> >  			ret = 0;
> >  	}
> >  
> > @@ -173,6 +193,123 @@ static int do_show(int argc, char **argv)
> >  	return ret;
> >  }
> >  
> > +static int do_show_tree_fn(const char *fpath, const struct stat *sb,
> > +			   int typeflag, struct FTW *ftw)
> > +{
> > +	enum bpf_attach_type type;
> > +	bool skip = true;
> > +	int cgroup_fd;
> > +
> > +	if (typeflag != FTW_D)
> > +		return 0;
> > +
> > +	cgroup_fd = open(fpath, O_RDONLY);
> > +	if (cgroup_fd < 0) {
> > +		p_err("can't open cgroup %s: %s", fpath, strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> > +		int count = count_attached_bpf_progs(cgroup_fd, type);
> > +
> > +		if (count < 0 && errno != EINVAL) {
> > +			p_err("can't query bpf programs attached to %s: %s",
> > +			      fpath, strerror(errno));
> > +			close(cgroup_fd);
> > +			return -1;
> > +		}
> > +		if (count > 0) {
> > +			skip = false;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (skip) {
> > +		close(cgroup_fd);
> > +		return 0;
> > +	}
> > +
> > +	if (json_output) {
> > +		jsonw_start_object(json_wtr);
> > +		jsonw_string_field(json_wtr, "cgroup", fpath);
> > +		jsonw_name(json_wtr, "programs");
> > +		jsonw_start_array(json_wtr);
> > +	} else {
> > +		printf("%s\n", fpath);
> > +	}
> > +
> > +	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
> > +		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
> > +
> > +	if (json_output) {
> > +		jsonw_end_array(json_wtr);
> > +		jsonw_end_object(json_wtr);
> > +	}
> > +
> > +	close(cgroup_fd);
> > +
> > +	return 0;
> > +}
> > +
> > +static char *find_cgroup_root(void)
> > +{
> > +	struct mntent *mnt;
> > +	FILE *f;
> > +
> > +	f = fopen("/proc/mounts", "r");
> > +	if (f == NULL)
> > +		return NULL;
> > +
> > +	while ((mnt = getmntent(f))) {
> > +		if (strcmp(mnt->mnt_type, "cgroup2") == 0) {
> > +			fclose(f);
> > +			return strdup(mnt->mnt_dir);
> 
> FWIW you don't free this memory.

Doesn't really matter, as we do exit immediately after,
but fixed in v2 anyway.

> 
> > +		}
> > +	}
> > +
> > +	fclose(f);
> > +	return NULL;
> > +}
> > +
> > +static int do_show_tree(int argc, char **argv)
> > +{
> > +	char *cgroup_root;
> > +	int ret;
> > +
> > +	if (argc > 1) {
> > +		p_err("too many parameters for cgroup tree");
> > +		return -1;
> > +	}
> > +
> > +	if (argc == 1) {
> > +		cgroup_root = argv[0];
> > +	} else {
> > +		cgroup_root = find_cgroup_root();
> > +
> > +		if (!cgroup_root) {
> > +			p_err("cgroup v2 isn't mounted");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	if (json_output)
> > +		jsonw_start_array(json_wtr);
> > +	else
> > +		printf("%s\n"
> > +		       "%-8s %-15s %-15s %-15s\n",
> > +		       "CgroupPath",
> > +		       "ID", "AttachType", "AttachFlags", "Name");
> > +
> > +	ret = nftw(cgroup_root, do_show_tree_fn, 1024, FTW_MOUNT);
> > +	if (ret && errno == ENOENT)
> > +		p_err("can't iterate over %s: %s", cgroup_root,
> > +		      strerror(errno));
> 
> I'm worried this could lead to a duplicated error in JSON output, no?
> Is it possible that do_show_tree_fn() would have already printed an
> error?

Fixed in v2.

> 
> > +
> > +	if (json_output)
> > +		jsonw_end_array(json_wtr);
> > +
> > +	return ret;
> > +}
> > +
> >  static int do_attach(int argc, char **argv)
> >  {
> >  	enum bpf_attach_type attach_type;
> > @@ -289,6 +426,7 @@ static int do_help(int argc, char **argv)
> >  
> >  	fprintf(stderr,
> >  		"Usage: %s %s { show | list } CGROUP\n"
> > +		"       %s %s tree [CGROUP_ROOT]\n"
> >  		"       %s %s attach CGROUP ATTACH_TYPE PROG [ATTACH_FLAGS]\n"
> >  		"       %s %s detach CGROUP ATTACH_TYPE PROG\n"
> >  		"       %s %s help\n"
> > @@ -298,6 +436,7 @@ static int do_help(int argc, char **argv)
> >  		"       " HELP_SPEC_PROGRAM "\n"
> >  		"       " HELP_SPEC_OPTIONS "\n"
> >  		"",
> > +		bin_name, argv[-2],
> >  		bin_name, argv[-2], bin_name, argv[-2],
> >  		bin_name, argv[-2], bin_name, argv[-2]);
> >  
> > @@ -307,6 +446,7 @@ static int do_help(int argc, char **argv)
> >  static const struct cmd cmds[] = {
> >  	{ "show",	do_show },
> >  	{ "list",	do_show },
> > +	{ "tree",       do_show_tree },
> >  	{ "attach",	do_attach },
> >  	{ "detach",	do_detach },
> >  	{ "help",	do_help },
> 
> Could you please also add this new command to bash completions?  It
> should be fairly trivial to handle.

Sure.

Thanks!
