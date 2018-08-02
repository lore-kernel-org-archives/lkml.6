Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36AD21534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DMEcP66v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UpTLDlfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36AD21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbeHBStB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:49:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59106 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbeHBStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:49:01 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72GhiVg009346;
        Thu, 2 Aug 2018 09:56:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=CL73mrKra3W1YM1sBAh0kqXfh4JJ8pFy/BTSbJyE8Rk=;
 b=DMEcP66vEoK+ukis764IwqQnEvQZ6AosaJxB/dLi0SggngnHn5/nsmHR1thxjcVzTxKC
 kqoqB9sJ51jnBk+gnN8SVpvSXM7fjVFFLiRQ9MW/D3Sv3LE+c1eGeFr1owRcChnA6624
 OxLziQ9AWGtqfzE1eP8UbbH+lB3pdnVpQG0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2km46a8dc1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 09:56:51 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 09:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL73mrKra3W1YM1sBAh0kqXfh4JJ8pFy/BTSbJyE8Rk=;
 b=UpTLDlfAIMcFdsyzXxvck9shXAndd8DvaVx1joVOqqo4HB8lqppHBcjqeCCfZVvCWQXpA1bfq9Oor3IcohmipqtvOa+Hm8zoDbyOttlw7T6lMC5hagimmXFB94+Gb9n5+ik+oOA4dbHDSvA8/9BQ+tdwAMLHCsK4blxqUo6EuZo=
Received: from castle (2620:10d:c090:200::4:bce2) by
 CY1PR15MB0169.namprd15.prod.outlook.com (2a01:111:e400:58bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Thu, 2 Aug
 2018 16:56:46 +0000
Date:   Thu, 2 Aug 2018 09:56:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180802165637.GA17401@castle>
References: <20180802003201.817-1-guro@fb.com>
 <20180802003201.817-4-guro@fb.com>
 <879f1767-8b15-4e83-d9ef-d8df0e8b4d83@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <879f1767-8b15-4e83-d9ef-d8df0e8b4d83@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::4:bce2]
X-ClientProxiedBy: MWHPR1401CA0015.namprd14.prod.outlook.com
 (2603:10b6:301:4b::25) To CY1PR15MB0169.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d5afdc1-f58a-47ff-8c7f-08d5f898eedf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0169;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;3:+l6gATfYRm8Mvr0Xc5lYKASriGbixoV1bsapUmDLFLo/NEEC/BmW1yciLEjP+QyF6YMBCB0203RgWCZTcWYRChHlHZj8V0dkmpF8EsvLLkfW9uODLgBw7Yaw50AQtgsZsgQOwzqFmgunOAx9/TFchMeajXEOtAWwEgbzdB10+xjg4dvhjXCW1NZ9Binc+KaGdeG7TfIbBvtgbjNmYgTTfU38Aq/FIOQ0oCPKI/mJGLi8EnXffFzR0fQFhLKwiY4P;25:uNM63mmKo4opH5L3TZ0V7CN3mOqwhopaBfOL9xWWAw0Jba8z9OsIMQ4VhgwsLyNfFdUp4QMvbF9diENPq66pMlKrQDZQ04uR6sJwkRqVGu9yzlDlOTWZ6IjTMLUNkIL2FfK47es6vhIMb2nOmCAKk6ILrPp+mNSf/vIAsnK6AXtfFqKiNh2QdQ4kvLy5dzqXjzy6T9OL/RtUqIKGfTqy7mtigT/lFYJ6CSLyEdDUBH9ckf1lHkQr9WoCWwyfEhwgsTQNh3PNWAWMd/Ug8lKZfuDKn16D2r+BnoIOAOEGl8LYbRvn4oLBcbFfcBdetwK/vbr2RvUWJGQzT2pKR0hW9g==;31:MS8Ke/2f6ENYJ/hOKV/X3o/+JIla6pgPsCkbkKfI1y8mjdlbcyyDC4ijhVoea4GoQTqzC+t9NGhM6LDR37KDDRw7KzBzRIkpLvx3ib3Ualu0dMCVlaMschpfsWTFKINAhgolu8pqzFuqVAVDFy2yF2VDc8TvAIAAwySHBpPr4eZ/op6fGMo6+pFN33gji13MzK6bKd+KXAdp4BiI0SLYjfycCeHwUIbJ7hWlEuuZrt0=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0169:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:F4QL/IygrE1e48DKFZk4W6g1Z+m0M7N/8aowcIo98RgXidCv4427TLfhJUHoOoJBAs9L5W2o9bgXXFXidjjW5DrD6R/HN8bxjXeCq3S7VDk1LKy9h4nZvTZpc+Gc1G6qMlAmlqV4uApK/c5n4wo2/tb+szpy2cwyNFTlUL0rCS3hvSMWwfJqdNyj8wEWIkjXXNMmAamNsBXj6hOjPybjGdKM41n8qYXZ9iazY2rK4hu3gIp5jHG5emMllg+R3W8AnzQNGSRhMXdbRBYpoCi/1JV5I+FVxv4Jx3YIpMCpXQkY/3fyd25qSjtRWpiOUU/hYGZ7onTwS7l2ousBcXniBRcTkFYnz52ZkLO9xFNBvHWnK0u9P2Hb7jBMGuFieZTIuXkNx4/Hbg5ob17YTXMyNtah8gIvLH0NJqdQ/ANf/RRYvrdzJuZd59XzLGvDZE5q49D8gaya9VQ4Wpdk/pd4utBo7zvVz+bf3caA59Nmc+GBEIGJ/dszui+6hSVA6Ar+;4:vRNMTdgA9ci/rmU3R2StivDZOBRcw4I8CbNtwyfu7zBW9WFBzT+zcLloftIAGmoEXb7HrdniJLB1eoO8AfpzxjpzjkUnsQU7p8KX8b4G4wodsOrlYz5zVPS/RvTz8EWN6HGzgiUGeZF0Y0q1iq9FdGcj++7775VupzICvu+q4ZrQpqmVSCwH6CgzsWMoM0YrfkrIXDunuRzLN0o/blaAg8E4RWz6e/NTyUeQV+ukEmeVViSTfFaU63Io70GnqLU3S3uS7NdnyEZlQl9oTx8/zQ==
X-Microsoft-Antispam-PRVS: <CY1PR15MB016903989D4F9F96E2C2F2E1BE2C0@CY1PR15MB0169.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0169;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0169;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(57704003)(23726003)(47776003)(476003)(52116002)(33896004)(97736004)(76176011)(16526019)(6666003)(1076002)(6916009)(46003)(2906002)(478600001)(6496006)(5660300001)(386003)(229853002)(7736002)(86362001)(305945005)(33656002)(52396003)(58126008)(54906003)(186003)(16586007)(6246003)(53546011)(316002)(6116002)(8676002)(11346002)(8936002)(9686003)(55016002)(25786009)(68736007)(53936002)(50466002)(14444005)(486006)(106356001)(4326008)(446003)(105586002)(81156014)(33716001)(81166006)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0169;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0169;23:sdskgckpsFtyLuaBpTkj+hTZSuY3DVYEnSaokvVF3?=
 =?us-ascii?Q?CDaSdigm3nqOODTRS1WrZ4LsWn0GBcsyuNakCIWDIy7samarkMBVZ0o6m07x?=
 =?us-ascii?Q?A5IwF1Fbl7d9wRoPvCHaMP+8fbVWw3VaFPVIOo2IvLZudhCCJ1OWZoPhRiwi?=
 =?us-ascii?Q?L43naRG4tsTjca/sxP4qCM3l1Z3u7wBwLGetTvDuhxtb+4LaR0afe11nVIT9?=
 =?us-ascii?Q?U2NzXw5Pgl9BFBYLUYziAbMWIF5WHBnRnsZdcwOjVcPE32otq3IgzYUed/Ta?=
 =?us-ascii?Q?RJ6e6HkWGDwsShh4QFy0V7fJqZsTep8qp6/kj9B50bNo2fU5X6MMdf0jqxEQ?=
 =?us-ascii?Q?XxP59dN4eHGbfCPUDMxxY4PvyEFwBAFry6Q9yBfb/9zB6qSjInNEa/5PoTCL?=
 =?us-ascii?Q?3TqorHZ9X+ji6/pl2I1HG9H+U2yTqfcTWFuVtqWOdA8MjRX6kb37JS5jTWsf?=
 =?us-ascii?Q?Vox1EtAyYtuLsDcoXj2KtsqkhUw+ss1NX5jXWRf22lh6zWzW27kA8sj6ntTT?=
 =?us-ascii?Q?BowX/5c0mt9KH0F88fwWi9uWsEsssHOO5kTPRLG3/5cYWWuHCwu5QowXQ0Wu?=
 =?us-ascii?Q?Qjw2m6dvGtav5/+i6j4t4hvm74QPcFe7X6Sg1F2vcPMwh0f8XqaJK15JeuOE?=
 =?us-ascii?Q?kUVfzORFKrYI2r2sUOGUYTpmw7Y+9Cz9lt9mBbMgEZvY8MJsgC9qATZj/yiz?=
 =?us-ascii?Q?OoNyT8MmfIyUX8cmTvW/MXsr7rHe0uU2cgsNZypG49UnEXMj1d0F0Cq4HPyO?=
 =?us-ascii?Q?fel3rJ5XrKOzV1WDtSI9WFzlHY155TQWIPmZvbhOBz7cF5PRAHErr0/gEW1O?=
 =?us-ascii?Q?3t6c4XRSGwMTExSb+2dhEI1Mfjk2TxKDupnB3qGudmd/a7A74iJZadCPT5/E?=
 =?us-ascii?Q?Vs2/lwyVTST0GMAcLXbi90TI5EmyyjDjTq459QIwLAqV0iak9Hz6FbuLHIGi?=
 =?us-ascii?Q?r3qVIsYg7wHMpJ10KYV86vM7S2mATevslep/FPZpocl1zUq09F5Kolj2m3+W?=
 =?us-ascii?Q?VXjlSudfcJ9vHesUJOrHc/2xCijEhfgWwU3RRmtj3bWzsvsruy7ghLCtej2j?=
 =?us-ascii?Q?8WtjBjVGpq8KjZW7tGAgBtn/zlkbyVBTvUxiD4jx9upkLINQlQsJGpxbmspS?=
 =?us-ascii?Q?uRp6HcZKSlfJbiGJWaKMSRfVC5PREDcRV4VgDrgMDC8VL4v10Opqu9Jy0TD6?=
 =?us-ascii?Q?E6j3EvQPFqhH2QnIlRnyyMpxBfUFlOOo09YtczceLuSdaIrvZVxN2GNTbS3H?=
 =?us-ascii?Q?c517BZvUoQpYE/RpGB/PdWMng5gXbbMJlzuFxa/7TQTOxJUTfpaDp/UuMnCu?=
 =?us-ascii?Q?AmRLvp00Vpi+uUV2p9QgfsV4KARtnX+yMJiJGFgkM/s?=
X-Microsoft-Antispam-Message-Info: UtI6qF6zrfi8ULTdNOdLpkMa/wJmohYzxtMaQKfwdlJH1t4JKo3fVG8y0iHvTWLjmfWaOAouBQ+Sgs225wmN4h82M3JUyHPE+INZuVL5CzDZCPYgW5bhpgbEXZDazr8MZ0hrsCHMCMpjIvc6yyqxxUUmY6/UzrN06dO7lJKuDgqvxbm75eK15te3wLw6ue7/yIHYyFpkwJOs27oxXrAed7KzgsxxG7K0hPWfp62ek3Cqifda/9qeMjoLqkcVOjTRkEzv2OsR3KVYGVOgv6Q1w5vZtsn13gUcnejAATg0wYFwU2nuVS2EJHxHqawwUkY8L3XZxYpGjEWqDHS3jZD541aR18/y2prVkfjnZIMJqco=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;6:y9I/Lq/IZjQcCF52kz0ypT5R2hSgaxZ0HGvx3zwY8NGTxI6dRDDne2Z3lcchjnSwEu3/kKv8ZHnG4CjxAfx5CjMD2zUZbyV4qqpOB3unXa2B57qAbrxJfoYvydJp1beStwpl/6Af9cHX41Wxj+B9QvW7dWGDBfE5vGHd53LCb1qlpBj/5uG2nY55xCfiEM1AUgKl2HpXcXft9jB5wakYOzmvF0arTjBroqRZ7i4Q3Pd4LwBnMTq8TrhtcINtsQ5IJg2UV/EVMUkd7u4EklTOJ1wBkqIgkOkPutVetvtZMyZAR+oSIwA52qtvcQt2nLPMBA1gXiZYqpi6vj1e3946EZ/efs7N35NW9HJXfXl0Vi9tfsXUL9f3VtDGW26mW1S/qeAWq3wwSFr380GHxD9oQKU3gnOnhH+H0KMnR/KjWN/wq3q3Ugxy857tdIme3qWCv6Y24ewmAn0NiUMRw/J+Cw==;5:Z5oYdW2x+Nkt/aaye1JFcaHjjqKdes2h/UpJ+2OZTu3EHHKsPBU3lcZ5Mr04haQu746dvTHU6mLzh1VvmBZlPLhirZdbjou51gXPtoFiysItGozifuUIWZlnxinJsshWWKx6VY/uictY0yjf/BtdG3R04lPTOySFFjsxkgP1CIc=;7:2Hu8zw5aqPs6sVXOgNDs7UrTXTs8seXuU2+46YOHUnk2zbNBDi5sx9XEri1pQ5ZfSrQL0LXKeMIxEY+4lJrOK/2c8I4+LRkeJ5SGVJ6BGBPM22ViGNMEvJYNcW48RO7SXy1RnlWtMC/WSxgRDGZMvWP5h0yCyLuy2p22IEPEqI98LaDxyA285xLFfvon6LkBxI3I6mhDApQrF2uOFvecEH2GyRrw1dWsZpGHImloj9kJ3nKHO+qJOLD186Zohh6f
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:TecGwnsColXKHxYaBCkQY2VMqgEzPPaz6h3l0b8nyQoC2nz8wj/wKT+q+LgLRymLl1/rIOFsuCltd8E3sPpnTnMQidEQbV8njE+OfiZ5OfEBAfAm74tkwuQIJW5PErxjFvBJgwqswu3IKLTyVEAySpBExsvEn3vSW+Qokwhx3FE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 16:56:46.2592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5afdc1-f58a-47ff-8c7f-08d5f898eedf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0169
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 07:53:13PM +0900, Tetsuo Handa wrote:
> On 2018/08/02 9:32, Roman Gushchin wrote:
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
> 
> We could start a one-time userspace agent which handles
> an cgroup OOM event and then terminates...

That might be not so trivial if there is a shortage of memory.

> 
> 
> 
> > +/**
> > + * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
> > + * @victim: task to be killed by the OOM killer
> > + * @oom_domain: memcg in case of memcg OOM, NULL in case of system-wide OOM
> > + *
> > + * Returns a pointer to a memory cgroup, which has to be cleaned up
> > + * by killing all belonging OOM-killable tasks.
> > + *
> > + * Caller has to call mem_cgroup_put() on the returned non-NULL memcg.
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
> 
> Isn't this racy? I guess that memcg of this "victim" can change to
> somewhere else from the one as of determining the final candidate.
> This "victim" might have already passed exit_mm()/cgroup_exit() from do_exit().
> This "victim" might be moving to a memcg which is different from the one
> determining the final candidate.

It is, as well as _all_ OOM handling code.
E.g. what if a user will set oom_score_adj to -1000 in the last moment?

It really doesn't matter, OOM killer should guarantee
forward progress without making too stupid decisions.
It doesn't provide any strict guarantees and really
shouldn't.

> 
> > +	if (memcg == root_mem_cgroup)
> > +		goto out;
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
> 
> 
> 
> > @@ -974,7 +988,23 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
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
> Isn't "killing a child process of the biggest memory hog" and "killing all
> processes which belongs to a memcg which the child process of the biggest
> memory hog belongs to" strange? The intent of selecting a child is to try
> to minimize lost work while the intent of oom_cgroup is to try to discard
> all work. If oom_cgroup is enabled, I feel that we should
> 
>   pr_err("%s: Kill all processes in ", message);
>   pr_cont_cgroup_path(memcg->css.cgroup);
>   pr_cont(" due to memory.oom.group set\n");
> 
> without
> 
>   pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n", message, task_pid_nr(p), p->comm, points);
> 
> (I mean, don't try to select a child).

We can do this optimization, but I would be accurate with changing
dmesg output format. Although it never was a part of ABI, I wonder,
how many users are using something like "kill process [0-9]+ or
sacrifice child" regexps?

Thanks!
