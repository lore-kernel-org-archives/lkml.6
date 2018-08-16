Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF26C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF33021486
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VszRz4ll";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IDG/BgjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF33021486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391938AbeHPSX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:23:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387805AbeHPSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:23:28 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7GFEwGS000540;
        Thu, 16 Aug 2018 08:24:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=fER8jY7RPAvfT4jTMstHVm3CkoINEaNUNounH5pCIGo=;
 b=VszRz4llQz0dGbnUF7T0or68oTsVpXMBiSFjNKYP6hPT9aNtr/ioSj3sWjJSVgnKCqwp
 JF4qR9pE6w70rLnC4XnC/bDCT6KMujTBDBi6BkyPSO6Ltt7YyMrU3IRMXIQUyp6yWhqa
 LDBXyaWyqMjjLNg8r1cH7tWcM7wO8evT27Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kw9ufrcf8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 16 Aug 2018 08:24:14 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 16 Aug 2018 08:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fER8jY7RPAvfT4jTMstHVm3CkoINEaNUNounH5pCIGo=;
 b=IDG/BgjXfrKFqniLUl1bi8fHtjckpcIvNNc9Bpc0/W3YmcwMewInBF4MLcnzkWKUJRSNgL9/lLzmImz3VWDq+uHVMEL9SRyTz61YhUWAbvruokjU8n5dpyEViBdUi54OxPN/MhmyaADnQUt7mxJ/nHsRNgV8E+qeIz1CS0qj9qg=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::7:fb72) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 15:24:08 +0000
Date:   Thu, 16 Aug 2018 08:24:03 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180816152356.GA5978@castle.DHCP.thefacebook.com>
References: <20180815003620.15678-1-guro@fb.com>
 <20180815163923.GA28953@cmpxchg.org>
 <20180815165513.GA26330@castle.DHCP.thefacebook.com>
 <20180815172044.GA29793@cmpxchg.org>
 <20180816063509.GS32645@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180816063509.GS32645@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::7:fb72]
X-ClientProxiedBy: MWHPR1301CA0002.namprd13.prod.outlook.com
 (2603:10b6:301:29::15) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46285420-44ad-4504-a8e5-08d6038c4fc2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:c+IKO1b1X7Ff+JOMHmsFkWFB2C1jY/ADA0FYwf881Dj40wgqSD67jbxQf0elWrpViqmHO8NoUfrmvxdJHFh0BQfNGevurLs6rfiYPVBk/ILfLEgwAPoeBQ+9aRXG3719b6LFZV4hq6hY2APCn1S88zJzSM095BoL8+bP9kfx4KPH12qigrk4g7r6/OD76a/okx2xeXS4z5hbsnCaOCCckN3kJKwzVaiLXM8tCwxp1DgtiMQ0kTW43eRw3e4LEKSH;25:5kLoSd062vV+uYGGNuP0pB0wWYEMkpJ3AYRn8cJwiWZ+viUnM8iPCfF4JqmTFR1fQj5eUUTYIjyvlFRnAZjv27aNxhy3ez0HwUyYqfQC5h9L/nN0uZAH2+RmrsXKsoHFwDF49Amn4qaHgPbtiee12U12rpHC2e/ryFVj5hlmN5A9l1Plmp8eIlAVedaeHfoaIdOxNlgvqkdsDi0MZJpV6CzE5yFDkoSsY08XmHP3Ix0hwHwUabitdPaYe/YO7GCX/91qS39XuMu6EdtHlay3ziJmD2J/jcP1M7CUcMMGqXEv87v76zU4G631DJzX0ysUeEAo0Qc8CHarYwveAkwl0A==;31:WAjI1TENHZD24No/cTyXDZLKRN94P1uupuDmqbGz6PkJbh9K0jTUcNdiaqKpLl62Ugord+RfhlxdouD++DjuE031K4F8piqn8R+xTmOPeVWzmSLIIZvQ7MtiW4HgFyq8alXRNSArutSFtbOhGOiebT1BCWYT/zZLR89cpaJhfjx4VTHyHv+XEfXxDyQjZj4iia9tFRtqFurSTSwQcSQJV5L0o+q3eM7vW3CrU4/uC8o=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:1oGU7QNfZF/UjMUmXSTWUE7XB6sQSFO5gxEqbTRUpSRbclOuPWQxufXb69SbbFEJ0jZpAt/ZPZz+38QaF6nmFY2c4YxyPZhz9N563DRw/6jrTI8hIoZhq/m5zGgM1faJUcmexgqOI8lxmaoP8jQelVAT9TZDvcT7tvH1lMc8O0z861TOj3xF3BZNzUX1RPTT2eMW8QhlihtEzUeXt+Fm7zO0041BVR1qzFe0cnRLQhEMKaZ3+o3wFdJiAAmWQf5l+mAe/Zut48j5feqmhbromyI4qamNBEq1J/ASwHJYG12iY1diR29OhwEIfiL3TELqlsadd3v4PlrOp4cHxGCyZKPFBzV8PGI20DFuKzuSxTMBwWSre3EPAE911K0o0pMeFkqzJAgyu/Duw2122hLz3TmPr9F2MdPo6KpUpLCrpBqKoF8mJQ56CJ+L9ACzSU9ZmeHRmLeNowyiA05+MChed110gxfO63A0+v/JWTzt9qlaWfVzyKBqYPjUc46eDmIE;4:KaT/HcniJn6cp7+C6jsLj4zOfc385wEslhPlH1SX83cEaXCExefFLAndLNdqu2Za7ofh7Tm8Pp+WPML7OUZPGheJiWDSxU/sBv+2SNi7iJq2V5KGBhlTL2iH6C31KYbn48Yw+d4qWasIrSSuZ6Qj0voFPfTi57CnZ/HzsLdLTp87tbvDiClgpwl+XjyzNF1tlKHH7UkRbgozj8DBGh+lZ3KAbKJG3tCWV0KAjKx/259FEBKZLTNo26aufdUUHikMnZCTK3Cvbn1CORYD8zRifQ==
X-Microsoft-Antispam-PRVS: <CY1PR15MB0170EE6D2298A2B09BF8D9D4BE3E0@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(54906003)(39060400002)(33656002)(55016002)(53936002)(16586007)(9686003)(2906002)(25786009)(7736002)(8676002)(52116002)(7696005)(58126008)(305945005)(229853002)(5660300001)(52396003)(316002)(50466002)(76176011)(4326008)(6116002)(478600001)(11346002)(446003)(105586002)(106356001)(47776003)(14444005)(23726003)(486006)(68736007)(1076002)(97736004)(386003)(6506007)(8936002)(217873002)(86362001)(81156014)(81166006)(6246003)(6666003)(6916009)(186003)(46003)(93886005)(16526019)(476003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:QKOMRMvnAHmLJQHTpp2MoRfwUyqE3BADrAfATYPeS?=
 =?us-ascii?Q?R9eN5qzdUnyCkw7oDxQE3xdSn8TkjGAgB5DdB+BMyn/u+LENE16hQvvBWQ42?=
 =?us-ascii?Q?QXe0wkaujKjzsudgP7Rt3n+6ahPg7Me7Xw6RaTMD5ezuD9IE8e1+tR/1SE9I?=
 =?us-ascii?Q?+8PkqJ+TUd0d5RKNIUXlPHxsLsL6d4nqQpzBvIXDtDr9+H409yGbj/7VoJFK?=
 =?us-ascii?Q?kcn88dGxDJ58Dr05gJmeUfGSW/tWnA1/GnfVywjsfnqfHNc9KAVx1VZ7sAEg?=
 =?us-ascii?Q?RKIMG/Reg4qEagM7oDQyDspOldBybmxUxUFVGvPgcMnxfBH9HjVcFK344aNI?=
 =?us-ascii?Q?tmHpkgXguCBZLYNWNM6FenzbZ49ejNxsWZe9YLCKUsP5otybaf5PAn5eIbuH?=
 =?us-ascii?Q?3lLVKn+WLKUq4BkvLROP1dwvpVLK4WV8Y9G7c+1MFksH7RKfiJx2hY7SCAr+?=
 =?us-ascii?Q?HF0Lfh3KDXrynWTQsFAYc7DOSubyI7ClARWwjG9apemG90T/MLBcgN24O9+E?=
 =?us-ascii?Q?7TJlVuTYykmmbEGlmeaQh226GKYG7PRDXRjw/dtNWTUG+ZAfUO5Y6mf8h0dj?=
 =?us-ascii?Q?WhFJMp/prE6cfF6j/okLuuNav4IxMs99PTUwlg0fvP423Hsw9B/LyBHXiWf1?=
 =?us-ascii?Q?7C8y6zILnWwq0c/uwP7vZdlXo0pfnshx1MojNQu0VzM47Wue3IhU2xh/nO7s?=
 =?us-ascii?Q?uY8mxRSJiyxyXWBakI6r+OgxIZkm8TO2UBa0FYmojUn45cpr89YF2B4lvdpN?=
 =?us-ascii?Q?0WJVeMPxW0CkmjQ66Op/fNTAbXQpDxkCEhV4sn8L2Swv/TR7THO2oiS7leN5?=
 =?us-ascii?Q?USgmc80ObZsNLoEQsBZuX28ifQ93qrXy1Zl+q1JP8nANDqdfrlrqmKbD+xrR?=
 =?us-ascii?Q?9LoUJwvXwac98DUPmxLvynByGHqYt/Q5v0I/jAv1FHq6GbM5NorgRImU+x3J?=
 =?us-ascii?Q?72AMxB9LZMhO63LuQAZfAiCPhsNtv2Ob0OyoEdRZTt9pi+4cKTgnQ0eEk4MP?=
 =?us-ascii?Q?aNTPY1K//bkj/rDJFrtyogbUZZI71AmO3cRV1rv4uclyY2PElTZQv3QXSo7L?=
 =?us-ascii?Q?BTFYCjRCAgZbRV2zeTK/rBkAtuZcBUiG0YU2Kuktp0K5AsSupxB26moZMRP/?=
 =?us-ascii?Q?L3/HziZ1oY2BDwrST1oQ3WAsYSUpvv76pzrSKx8691qFqX8RHOJ10+uYGtB1?=
 =?us-ascii?Q?PVA0KLryklLXtnWbQPhNHbciEnJrLNrii7ehcQzKH1HpB3rKiDZypo4yARS9?=
 =?us-ascii?Q?lKJ5gXvxkg4MbA1CgHxNeGVAqHSLwtuO8018eSdHw5+MMndKu7N5Klebpasu?=
 =?us-ascii?Q?m2A08LJZ/afYmokpZSWTYYqgJX4pT8JDxXez91nKQEn?=
X-Microsoft-Antispam-Message-Info: Kan1MmYxzuKsFyC7I/XY4VdTLjnoFq29+lmV5I28ZGXGs9JKdIAQ1I0sGPWWMkH7BwU7u9qflkMQ5sJyiNZE3FY8naC82A1qUfg1W1EEYBiKgI+5uOVoRwHKMBtSD2yoex2DIU6J9tX6SsCB99mXWc6EavnuywuBfaI6Zthr39+g7kifyH7nsTpBFkL3DwJVnJM/v66EgssVUQjYhK+RIRgHY3551pNFXFvAS0DaZtuzQ+F0YPfnFdkm3X3aNRFX87JplKdGxBfeBA4/E4N5+W5cpewc02JQ3pk2EoiiPM2RG+2RXa9T0AFXnhEf6XJ8jm0wnYPldSVpJYl697ZHsTz5MG7sd+DfCCyD4vm259Y=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:Vl6cLPmg/MvvDj/j/HlH627Q88xBCLrafyEkAEBgwYVHQLPu1hh0mGkoNmahcG7mjOG1aQQFltz8TmYiFkiXY6BRAQSnDaO9ggD73A4rnmQa8o/D+xsDNuTpbw1Ze2s0YHMm7YyNoIHFUgYTCQ2uttDuoAYfHemeP2H/l9axio5z8xDLDtqz29TmUNo9wpvOQ32TKxcJqQ64FBJgSwF7+GtM+ea6g6AMgAIqLmi+5fTLAgMaIEMsGytML+cudGVqb9QJhducoYgczBby/DZbbxulnH80zQX6dOn6U5isqtEWxlyXVHJRmesCvIiVBYBmBApRvhwpJ82PgKnbc2nmSUjxNAPXgp5DqCOcxy4n/LJRvo7qbFdvSxoYGFGYrzQj4j2/sXpjNf4l5yf6uBJNUgJ/nu+zXqiA35ZstuWFRkn9BpubuBmdtd8ctM5YL+M/IFelQmte4fQyfOtpuMrxgw==;5:UhfXNYdwJ1+DZjOJ3qMP0bsDpllNKTlbllSF7SMcCsEysauyWnY0w4qISaur04pTx9fsr2O/itMdQCr5+NYyKQ9Y2u6GAK1XI7cIPjsvtE7i+NezbIqA8IZlt28FnOe13/M4j2jCXsHXX23GUoAyWn8sIxm74Lq24pwl3LzyiGM=;7:ThaHPpcozyqS562dOrRlwVBIplkS/wvSLh8lNUrK22/f/+bj6Jfqf17SUitczjtzqix7Eci73xXoKR3Z2Cix18f+3FHNrfH3D3brK+RbdJBmWyk9PoDB8lAB7Jak+jtUqJXZb2V3aMvEj/CVN4TQGAWBEijRYLbnTM8zk6c92ocLShfEIjQ1t7oq6b5jYBvCbG9b7PXXjZ2lrPRb9tXzu1PI0RaIN8PUtIbslQfcgkpYh5AmlUGX6q/YAV/wVxUq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:CVSyZJcpxyEikR28ItFD1R824OE2Oo364OWd/9Ylc0L2wwO8dSH/DV4wL1dEgeVEwp0a9j3N0wNs1HnXA1Z84zb96rVFLDREUbEA2lNJNLQQ4C6YQxc6hHSHfVVPv1cfiug9hmXYInsvVMwDqBhUQjTPK8Z/IWXlvqclj7ttu6c=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 15:24:08.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46285420-44ad-4504-a8e5-08d6038c4fc2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:35:09AM +0200, Michal Hocko wrote:
> On Wed 15-08-18 13:20:44, Johannes Weiner wrote:
> [...]
> > This is completely backwards.
> > 
> > We respect the limits unless there is a *really* strong reason not
> > to. The only situations I can think of is during OOM kills to avoid
> > memory deadlocks and during packet reception for correctness issues
> > (and because the network stack has its own way to reclaim memory).
> > 
> > Relying on some vague future allocations in the process's lifetime to
> > fail in order to contain it is crappy and unreliable. And unwinding
> > the stack allocation isn't too much complexity to warrant breaking the
> > containment rules here, even if it were several steps. But it looks
> > like it's nothing more than a 'goto free_stack'.
> > 
> > Please just fix this.
> 
> Thinking about it some more (sorry I should have done that in my
> previous reply already) I do agree with Johannes. We should really back
> off as soon as possible rather than rely on a future action because
> this is quite subtle and prone to unexpected behavior.

Ok, no problems, I'll address this in v2.

Thanks!
