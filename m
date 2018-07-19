Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B93ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3932084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="iNvLvOie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3932084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeGSVl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:41:29 -0400
Received: from mail-by2nam01on0105.outbound.protection.outlook.com ([104.47.34.105]:59104
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727706AbeGSVl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WCGlswDEitIpwyseAFFAtNNEEDNFaIlEt7/1sO0RCU=;
 b=iNvLvOieiwCNFMg63OtfSBiiHjxJhiuuI2zF2RsCmzLTcy/MqSLNqTeJNQfHangXzQCI/Dz/wCbac89Z7yiUDxVS2YtYp8W9FXa0SB+D2lGms+alYbQNeicqPD4167/lHMpv9jn5GVrw/+3vBdUufyE8v0yOR4fOIM3OSoW9PrA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 20:56:34 +0000
Date:   Thu, 19 Jul 2018 13:56:30 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-fsdevel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: DSP ASE regset support
Message-ID: <20180719205630.osfdzk7gqv4djvqc@pburton-laptop>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR19CA0057.namprd19.prod.outlook.com
 (2603:10b6:300:94::19) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd747d7-2a35-4344-49bc-08d5edba1d1a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:z6/UGt3pQj8yHRfPKTHbanRbWWY06RTJdPTWR0Re7+AXUyyF4sj4X2t6MlcmPM4aKXcZ/hxWNlCErn7ljee0YdUQC18ppfjmytIMHfWecGt6kaRZfJu/OaNGc6rlp4sGheOgzaRKE6udzVSGTTfVO0rZ7ge2tuOHe3XTTBh/LBVoj3TpYLW68il+jvdAQrRumyDYvA2RozgxnKaH23xcGQdulqbMcM+wcfomsC3zerE0MnidOwdEq+v79cvwFDg8;25:gahIum/dVwfiKiMrJVVBIlW37li0hmYpiPEBVHe+GIR16g7zwN7m6oCf0p8j7eevP0Vbg+ksct/MeR+H08juL//WFIwVaPd+wGXKaDqU+URZORwgRNoYzxiTbWa9ZSQfwi8d9YQF3j2Nak2/1VdgQMgYAEq+56olJNkPI/+b/m9LiUuk75+goOwv5epYSs9NgSK4HRUlYqoKKlF4kQO39YMz6qVNr9z/mffRqcNuNHGtj1lOgvgDSYoVqmGm5Sgt9UrX9BqvHX5w7QIP2aC5iJg0VABqRHdHqpnUk0KWGjQ2Qv+XH85Vm1hW7YZkmG0nxzBATQiZVz7R9hN8q4FrxA==;31:p7m1IaEpMY3odBQ528Evp8DKQR93daIzQnu/cG6nq/DN6ZLGi1UnNqy9ahkChPeanlrU096u0Cw7tJlS7+4hDnCuMwf8oay8rs99A4LYQx/7sApgRatnmTFp22jzjZM/cEh9F+KJFJWQC9Y09zYT1iN6yK9eNtJI5QqM8oumpkWtWcbuydX0AvkqJS8rDTLfMf+SQdQ65E7yXr5y77xweGv0gq2OcGrsEuef7qykJi0=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-LD-Processed: 463607d3-1db3-40a0-8a29-970c56230104,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:LKnCYclcaDZfYSTJgiEKP1zuzq1iwvgZpdRYwvOaQhotlWXtFQZ9LIqcybTRfeQj3oV0mhKudq1lKdI8Ud08ozH6p1z552W6MEbeyrSEyAJWKcSGf9RE+L0Mvm4qTN1sOPzIoIdnkB2bA5Blzf55nCZucCIzsWSaBFXTXThAt/rqKe7vtCwssCclSyEXJU7gLMlkA7mJBVv7+uZstqx1Lr9jwkc0QR61RUNSLY+LNImctXUnlVqtRoCln7nxiP+G;4:K1zQ+ME4E+nYhgrFZNcu6hLIxhYrhLQWsrH1kNnrHZswDd/ZpdIxcbY5iBK69nbQv0thY8/eE9DWXjI8urMQkH99gZwvlsqHrHm0mq5nLwAnutW1omle7AprYa26rzStHEL1wWEJkauglGCfS1Wj+gG+MlRHdqS5Geo6GuLD5qi1nSj9JPYToDPJCV/HJDWp5irh28RQGOl5HcRITWEJchIDUe21c1PILIb/siPDnFmZ1Zg/AbNxnFEPRjf4zVTIQYQH6VyKge6ommGAYXZZxA==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929A4ADCC7BEE247625F4E6C1520@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(39840400004)(346002)(396003)(136003)(189003)(199004)(44832011)(8676002)(6666003)(53936002)(50466002)(52116002)(6496006)(26005)(16526019)(6636002)(68736007)(76176011)(33896004)(229853002)(106356001)(6486002)(6246003)(105586002)(97736004)(386003)(14444005)(81166006)(6862004)(81156014)(33716001)(4326008)(47776003)(54906003)(16586007)(58126008)(316002)(66066001)(76506005)(305945005)(486006)(956004)(1076002)(23726003)(2906002)(478600001)(7736002)(5660300001)(25786009)(217873002)(42882007)(9686003)(476003)(11346002)(446003)(8936002)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:i0nfr39jF0HZ5U+uU7rl8YAIM0YAuwTaDHjxl+ATm?=
 =?us-ascii?Q?3ct0vPUY5oVnZwKPvSrthyMpMqKLIEYvpG10jV0LSYGPdw7dde5gDHUIF1WH?=
 =?us-ascii?Q?mUgAMpJ5JP/sfNRkY2lRQhU0qvpxyD9g27OhxhO3RuzIWonUXTuvEWMLGBSx?=
 =?us-ascii?Q?zXJf8If3oIiMtIVspMEPVA+9F72WZVifs1jUD9ktIBwzfSMCxhoG0D/yRhRg?=
 =?us-ascii?Q?f/zzhePquIK5obBsRDUz7awIuDRtH8/cg4DRqHF5K3bGk+ka2B5G2SZYIemy?=
 =?us-ascii?Q?P362z2l9uU5ocIXTOM4isWX3FQQqOg4JvaBOEeoO7CSV8T37BlIEt08ApDPf?=
 =?us-ascii?Q?t4lPnjsyDrcf2TPWBe2ZFKEupvIGtKuaZuALC4Je623zAEr4BpvgvkdU5ps2?=
 =?us-ascii?Q?r/L3lGrAg1xxtohV3PaA54m2rS9x6CpGBmJpTsyELHTqdfsrU8r8fv5SQ3+6?=
 =?us-ascii?Q?1jNQtrrjJ8oPnTr7yHUwE9tUMKt8jUZzwbcDoxtvDclaHtoj0N1iHZg/RZnd?=
 =?us-ascii?Q?4u5QTDEOkLzQTxzwVycavL8OzTjkUWWQ4MRyea7/NyhPhdUDD8+rWZ7bc0Zf?=
 =?us-ascii?Q?CJmIj952tCvZqbFim2jvDlIZBO005P64PlLOWdrxgNv45HcEHBlNimn3oKsF?=
 =?us-ascii?Q?XwlGLG+dC3ARvakcu+pM0LBl8GCu8bDZq1OeeH+9L9MY6LYTdFN/FSljqPFV?=
 =?us-ascii?Q?ws2WjiTwNYnkoKKzlfHW4YOGy0+VgTSQAh6tbjtgzrZ3Gb6kf0IkNtQ8WMaa?=
 =?us-ascii?Q?wGB+5Dqeg3fy9MaghluEpLdC/ZJTvHFVrJ3S4AIcTsC7vIwYBGsnfD24SlmI?=
 =?us-ascii?Q?ZM+iM71pxjk+JnHwbg5mkPDN9Kq/fNsYiWcMNuA5pRGBVzIj6A304eKxnlxI?=
 =?us-ascii?Q?3+U2c3mdaHg3tbxIrCv+c8zDm4Raj6wg9pO9hD1QJxHswVGVevFBzxA85mh0?=
 =?us-ascii?Q?7noKR2U8UkRQN6KseLm1vU0Z8bX0qrmkMBQCI4Kpzid1LRyHBl2/QQMX9fml?=
 =?us-ascii?Q?KrXp88+mDJ0m1pGnHwit7OyuLQMSLQzUNwvRtdFt49APpjQPEwaN6mpIYNCM?=
 =?us-ascii?Q?4fSUZtG1Ny5x6fZhxgYAAZcOdP9Aw1Eg+nAAzvcfoYGyKzWMIL/TPMfjlSry?=
 =?us-ascii?Q?3Nfw+i8+/ZySkMTdFKC9uHaQTFW00Tvid/pmnAtri9kR5oKWY+xKLH54rhnn?=
 =?us-ascii?Q?oP9b3ZGQM8qskXM6kWe3ajbNxNpTABCSTaAjQjJbJkf8rcTplUV+bfwp6tl6?=
 =?us-ascii?Q?6kbxjAihUmSJlOcJaxw9eYi2WTGhvxbTH2H51vU6QwKnTHLEHe8WWntnr5Uz?=
 =?us-ascii?Q?fsnqoB7SX6SVdWG/5Iat1vXHWNSjeg8t5DJxNIzGSkhnYtuZJAo2R3o7Dm/d?=
 =?us-ascii?Q?oaZfQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: WCbAFDKX5DayE8YR8BwKy/ZCLgnj43Sq7MYYak1GBJDR+vGgAwZAbrVTPOOCyrEPXEwVpkcyz54DAg7BWyKd5JOZxwOHGQt3qzrBs8H8oet63f9FgD8EWSr/VWHjs6vcv4wv8I2R9hAC6kar4X2v61h217CroNtsd0UpLtfey7W3RENq5hP+0ijo8ghpi8jcOQGE5DJaf6QCZdckRBOgGwyXfzRuefMYg8mLVVgGgWF3OhMlI0zoGp6442k/busKNrGCPAMwPNS5MmfOd6DttU18JNwT+7vBs6WKJJ5pgorted33SpMPdJL7Vl2i4xUnKKL68ijJr/K6FJxbVvJ/6KkQj8JE1LT/8GxhkvNMNYQ=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:ojwrpn6zMW7yhV3U7KgKqZ/HEmixm2qnpYPRguGSjQnA2K3DXM7wJqGjtxP6FXFGiPNaKczr2iE7NVuZXNIxo5YdgzwWc10IGJ6VcI/VBeiwCsmmMYALuRNSg/MHC8ffGjvfm1JgfwGWQB+V68+s0eKTnxqfzjUNDD/BDfjLkc64DA+q9+bLbFXEYIkHf5G2M3effVl4WnBEs4oiGTH3siDwBhXLy4R2Uf4wS4aK2nbmJaZ+NcxyZVwKy2v4pSdlWSnrhS+m2IjGr0VPpmm2aB+7laJQEYOekiFcF0BYe178pYSsE5dPuAYtm3uqkwPIHG1zzfFccS349nsnrZAyHirbiKycGZAwGJF1MhtO7K02nlt1pc5Q4sJ+JB7ljpd+m2o7b2NFTbP/0U+NKK8L6ywubs+598rdW1wrArYjNjZDSxhEaYtvyfgqgiX9208wvdjyIuPQ14xQnCZfRNKziA==;5:MAqj8wv/vRRxmVD+qTxz9/2YZmxcCQe+wHZuvHPMn/5E0JILHz2r35BDgmPtAPjK6bpwRMmx8cYwJ1MsZsPCRmvHER/z1U5upSKmkHJi2n+QK8sOZCln3EnQXitiodKZNCWOesQ4vj+C/1Tg+1QvTTG/tluraaHuXZIdsQ6jn4k=;7:OUHWTzgMeuwk1POII0ozYksXaogbG1BC4JoUWm8baPmvaQgvvSZTYfRbPxXPsowr8uciLsNiO0V7cQK7YWIQwWFq6MT3559wSkhWDTJL+g2udyqhsQAaJFkLv02eXEHcW/sxzd9GL1r3Nbyk/1lIQ53ehoUGytSXpK7UUxfoh9UKZLS2RvPFgSHyhIlKn3GqyBu5+ExvdF28Vk2UPVX9R55j8D+TkxbtCaVROgQhPPYHvDr28e83qZ0YnP6IG+hS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 20:56:34.8411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd747d7-2a35-4344-49bc-08d5edba1d1a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Tue, May 15, 2018 at 11:32:11PM +0100, Maciej W. Rozycki wrote:
>  For years, quite oddly, we have been missing DSP ASE register state from 
> core files.  These days regsets are used to define what goes into a core 
> file, so here's a change adding one.
> 
>  As a side effect ptrace(2) can now also access this regset, however no 
> complementing client implementation has been made.  Eventually that'll 
> have to change though so that DSP ASE registers can be correctly accessed 
> in n32 processes, which suffer from ptrace(2) 32-bit data types truncating 
> contents exchanged by PTRACE_PEEKUSR and PTRACE_POKEUSR requests with 
> 64-bit registers and no means defined to access partial registers via this 
> API.
> 
>  In the course of this implementation I came across two bugs affecting the 
> area being updated and hence this has become a small patch series with the 
> audience wider than originally expected.
> 
>  See individual commit descriptions for the details of changes made.  
> 
>  NB there is no strict functional dependency between 1/3 and 2/3-3/3, so 
> the order of commits does not have to be preserved as far as these two 
> subsets are concerned.  However 3/3 does trigger the problem addressed 
> with 1/3 (and gracefully handles it), hence the grouping in a series.
> 
>  Please apply.

Thanks - applied to mips-next for 4.19, though I removed the stable tags
on patches 1/3 & 3/3 & it's worth noting that the ELF note numbers are
changed to from 0x70X to 0x80X, since 0x700 has been used already.

If you really care about a stable backport for 3/3 let's talk, but I'm
doubtful as to its use when we've been missing this for so long.

Paul
