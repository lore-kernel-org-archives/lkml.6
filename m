Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09763C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68D62089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BkW/gBWS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TfwYcN9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68D62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbeGISyO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:54:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932607AbeGISyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:54:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69Iio9H013421;
        Mon, 9 Jul 2018 11:53:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=Ldn/OwBNTcuETvgA6fyxYFbwzhWb+H1uc08mmBuC+gs=;
 b=BkW/gBWSHemCWhLZWXXR7ByV2E/UT+esz2lgipIQqosl8pv1kIHr4jnbdrPj1Qga12An
 RQZrf5D+ffWhe8yb/F67LWT/YYNnaFW1cDXXTkXqinTE+UNxrg97YzuNNs6Tv4qIs4Xw
 GFI1amKd1a9xIphJ+Q8E613wYVi1ji1LMS4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k4at9gjhj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Jul 2018 11:53:44 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 9 Jul 2018 11:53:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldn/OwBNTcuETvgA6fyxYFbwzhWb+H1uc08mmBuC+gs=;
 b=TfwYcN9UX0zUGICRbodPyZHnMmB7OAdThJPjd7q7yBTUeeuZLiR46zkiek86iQ2wEQW4GornBoo7zsn7mVYph4muRJbljzkP55AI46E5UW6hjxiRb5fZl6eYo2c3MJfOih1ovQTF22cYYRtuWLtr+YFA4c47pwCqujMsn3dpMoM=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:853b) by
 BY2PR15MB0165.namprd15.prod.outlook.com (2a01:111:e400:58b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Mon, 9 Jul
 2018 18:53:38 +0000
Date:   Mon, 9 Jul 2018 11:53:33 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <netdev@vger.kernel.org>, <kbuild-all@01.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Sean Young <sean@mess.org>
Subject: Re: [PATCH v2 bpf-next 02/14] bpf: introduce cgroup storage maps
Message-ID: <20180709185330.GA11938@castle.DHCP.thefacebook.com>
References: <20180705205139.3462-3-guro@fb.com>
 <201807062214.O8pQxWve%fengguang.wu@intel.com>
 <20180706215229.GA27634@castle.DHCP.thefacebook.com>
 <20180707223532.k5i4h5xp4lj2pf77@ast-mbp.dhcp.thefacebook.com>
 <54d9f3b6-a449-b5ee-a55b-c2cd983c11d0@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54d9f3b6-a449-b5ee-a55b-c2cd983c11d0@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:853b]
X-ClientProxiedBy: MWHPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:300:c0::34) To BY2PR15MB0165.namprd15.prod.outlook.com
 (2a01:111:e400:58b7::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed6f683c-d2de-4cc3-55f6-08d5e5cd4873
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0165;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0165;3:50P/qwSZOGscWlnYYpoZckxr8gvHaKTsHzyXgNEOUVg7EFYLr690uICfkjZaJxYka0Yx+jghlvpPNL+cwZN4DfeY17Gh3EKYwEj/y1LBRIEmfJ24tKPqwgZaxVsYNhABn5gTfiE4+saIp7XcX0LbmGjGNzTcqf3bHIvF6lz1Wr58Htz2M6erAhFo0EdhvnJhUQImfun5+V9mbDDvzi3o/ekQvYma8Jku+NACFmmrtnGmizOwfjX1qr/0DD8ogHxS;25:4uCwZfzQS30+8rylqxhDLLW7MgLuYgfWBxE4K4HAhJV0wBdsa5bWNuaRECZsGMe83EndMFYYIOmu5xAXlIv60rywBsqP4FC56z12Kc7FdyVpziEGfpeRGO6U1FjBUX4ErVUWh6nIssE+7vcD7S4zxYFDiWQtwRZWUaEugy+feOg2h/jNG8880DT8utqA1Goooss8PcZFFAl73TilKSzAI5HHsz78T4Qa6f2Syl/jPIluToYbK4AuKtlDuCjG2jGIK86SLHDmfi62WDhe7+AC6tADu7rbQ2UGsxqkbwzCtA+Ab0CprXHhYN3RCHUYQ+GHapRdrGh+gGIMzz/UQo51Gw==;31:TLYyC4nqDoFL6NMsaI9u9wK0PXdvEqIanVgPe3SmbeQ4m2eo7xRL9Qr+oNLe+jn4gifRBTUX8V+2m/wVwmh7iR+DRRsjOFT31W8i/x0KIfmzByfHPRFBfyglCJE7whgsxVbn7SnHSnThVIraHAUEN1piFOkHujV+ViWyik/4kpoEzIlFxYsXunuCwPjttU9NoGxH7qZCcu3MmSdJ+jtrabbC0d0R56tKTWKK19G0S7Q=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0165:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0165;20:QGBOKzAriK05KDzUyUQNd3uUoKWfW2eCePUHEffWKVqyWY3qTmXL/aD/7jXo1Hc+tyEpdwrTMDKy+PUt3Q2uhvTrJ/FAUOfKWSyjqyqT4kv2IPogiOMpKaah7O8N8KcOUUMx3gPGxUh3t5GKZo4GDP2JQn9OIP3uG8I6QGBlaVTfO0DITi1sSLl9eDVb8oJhZ+j7tPPaOrAMWqfvyNbawToIQMMCGshGJ2FtvDYMIIkboQCFajqcTR6dC0zv0r9X1ygqSWstGB0ZEkycSdOUHNvIU8CT3yUhRdg4owEClQtOmvUk69OzscXBy2GFBPwgLGxXMpiHaCBZFYvdiS2932pk4bh/34KVXVKr6OD9pOLu9cTQa69/5UvctApLVbTj4ICiQIaKjhK1mGFeGPukq/e6sQtBtqJlgztXZGqRYYAJ8w9g1iLANLA6s9zKUfBf0PxyxKi9zzVLGYEAMABdq6UE8ztjxPCmK3aigSIvyCdy1CnjNIhwiiNq+ltA3AOM;4:5N5m9HM0lU1awAFqMRRXbPm+sLdDIMKZM6iF7Jj7B6MjLCIEtvkiWddfVQIHE0HMJ1Tz4rIxZzy/YShnmeAXR7/e7gos5ksIPm1sNfJEuZFzSvpH4u/r0A/aBCQBFD5VhlrptVYO79v+uLXhBZoEcnAcnOh2l7y4AUcLJyCKWStM2vHHKOY8XVa5Gq4sVFTCdRaoFonL4dG3ULJoFgEGszvSNkEUE4t03TXmFGnuLyltyLZ9YE2a7zXsP+cFR00h9fLjwYfxrDFQujW7JTWZ1dxRP/tqCbiwpBdp0xMgARoWQvrD1x5eTIds4GJ7GHG0cHcQp9lGC9/DVPC/qswZ6px7MDXX3aA+wdaeuiuXRwkQFPiTn6Imx6sDvwlYHr97k+qsIL9CkN5FWGdUMDDJwHGWXDP8GfZm9U9HFpbo7t4=
X-Microsoft-Antispam-PRVS: <BY2PR15MB01651E1A0CEC2C04CB4AC87CBE440@BY2PR15MB0165.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162)(166708455590820)(67672495146484)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0165;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0165;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(199004)(189003)(39060400002)(53546011)(5660300001)(6666003)(9686003)(6916009)(229853002)(575784001)(52396003)(386003)(478600001)(6506007)(76176011)(52116002)(55016002)(7696005)(6306002)(86362001)(6246003)(966005)(486006)(14444005)(5024004)(4326008)(47776003)(25786009)(53936002)(105586002)(345774005)(93886005)(50466002)(316002)(106356001)(54906003)(7736002)(97736004)(1076002)(23726003)(6116002)(81156014)(81166006)(186003)(46003)(16526019)(8676002)(2906002)(11346002)(4001150100001)(33656002)(58126008)(16586007)(8936002)(446003)(68736007)(305945005)(476003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0165;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0165;23:+tV6dKb5dRgTbQ7lep7kz0j2G0YEzuVRLftnZiPMP?=
 =?us-ascii?Q?Us1ctIPam8YgLMnWW1HIOR8cyUWEFmth9QUtUBIDjtja8078s+bBEiqWIDVJ?=
 =?us-ascii?Q?4NdivbO1ZwiEtnZX1/nZcC/jkCNg3uUZd6Ihn2AKMoRAu5yMtaBftn5F8JfC?=
 =?us-ascii?Q?ZTcRiKDAJmkzkXCFeMK7x75/hF4at54jWytzSYcVoe0uAkM0FRWob/izdB3T?=
 =?us-ascii?Q?QUXxnorKeDdoMOQDEvhcT3XMBZPpHSLXkZtFJFjaLjmWgK25cLstFBc0zeMt?=
 =?us-ascii?Q?NKceBoPyzF3UH+NBTDx9QehVpIbb1qWPN2NwbHr9jHKQiuIrjw7gVYGMNU92?=
 =?us-ascii?Q?brsKRh1NYh29mS2GjjHJTH+tLsyCb7GCUlVQ9s0x5CJB5BEC9lozaQI6LnSP?=
 =?us-ascii?Q?1xQ66WdKJQJ/IGdXoeSpEkPC8TeZCH3rseF1os/FNtjwjUCg6KGeZkqjBtlY?=
 =?us-ascii?Q?Gf0crpjm3v720la3WwJJi8LXxTmE3z5k3osNRgwFSyAOBuCzMt7tiECsMbUD?=
 =?us-ascii?Q?NmI0vnJF3FYvZHkdXW19RUDzllPQfoniBxo49rVwxwpRMae8q5G5AFrLibz7?=
 =?us-ascii?Q?v5Hb/GYLBmIr+mMUbWtefbnQabRq44sKHPOrmnDsSgG1uXKCWyiiAu2P/ffJ?=
 =?us-ascii?Q?juERyrIYFhODRQXrxI4IldVQphgOxD5k+RjvvcnlGQ76RPYXRpn2fnipzr1s?=
 =?us-ascii?Q?G3eoYpd7XVC/jLlSLiFbWcjScjc7xu6V2uNEPPN4mC2lL0UrOTTShJaTB0oc?=
 =?us-ascii?Q?u98xL6h7vAUr9LYsPBu4mCbcWCTh8O/BW4S83dysyAnR+js81I7JNPk3FGe4?=
 =?us-ascii?Q?A2JA/B7YuQKBsRB3LjGRvah9yjd/CW/zPUQvGa0UHIHJcGh/SGpzmUjUOl14?=
 =?us-ascii?Q?ZEmxMyuz2pcXy0rN4fqZoeTLO/1RPwDJlZ7lSH19FCX33a8lVR/43h8yVW7t?=
 =?us-ascii?Q?+b7jHaRwn5clRmoy93DIYh3YAyjEHXNIaZz0tctSyt/f6TVfNNAFtC3907vC?=
 =?us-ascii?Q?y1/RbyRw8M5x8Om7PNMD7xuMiRDoJiVKGtWJ+kUcO9G0+iW6RCC7QJb3Vv6L?=
 =?us-ascii?Q?Ty9hSdxkdfyCkUcfKWp86tAZQyENa97uQdhIDsPgBrUrQ7yiwZgZ0jdwIJsF?=
 =?us-ascii?Q?cMOn2QyEg4+ryZ6f6nF5YpednQPCo4xMVfZsuN5SXTa7JFsecA8N70Q7NnRi?=
 =?us-ascii?Q?5TiBq00Eaa3t9yDNZM2FCJLlLuaqrLeLTstmAglE5eOHh733c2TJeqWPk7TR?=
 =?us-ascii?Q?eTJEgP/erziiU2J8aqhngV+qhr4U7TLpqxuKtcuod1pFdkAY2EeVA6Hk/Wk2?=
 =?us-ascii?Q?poftb2k8d+NylLdKB7SBh+zOMYKbhcKbbum4Pw7cCEEGmuVOa5SVmP9kG8qP?=
 =?us-ascii?Q?Kl+eup18ZDDHDyCbDESmcBMNRTR/r/ZoIZ7fBi9pom7NYAoyG8DvhiceP8L5?=
 =?us-ascii?Q?ofWIVFzW1UH9JmN+bVmzEILvZJ5L9V6gu1vr4j/d7+Q6RI8idmu?=
X-Microsoft-Antispam-Message-Info: +s/vP8U+tIaugk24jefLiaW8GFZlxsfzv7l8qaK+Vs4tl+NaU144a2Yyk0M3rcLgVhKXGhOFB1cweJB1fY454mlHUue8gospYD8jyGqQ2OMMw4o5oPhg8fCiU0Y89t8kzDqawuzvc5XDt7KJ5BzBuZ4yii3UEp3Ia91DisvLtdF+algzjF0HNiYg+uIeFTCIztGEaNy+k+YRMU0Gt4dKTnwFrZi15ehv8a/9K7Q7dSoLCJbFg6P49wKpD3N+BUd00JFMHU5sfclNJ55HMEOjchC6/wy2Rwn2O+/RmMjf9JTWqO8he/4kHRc3iktnUmHpfRPC3t4v+XPt4gDH3pzvw7E1TIkPih34s907AoKe4HM=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0165;6:X2RxTq/PkAERZEAUKENRR/dC2r4xJtE4YFtOoeSacZNTsWuejOVWI2y+Oc9b0g+2n8T5cTG/qrZeDSM5eVXWkub8nlTz0w31hDcI4ECJX3IMWfPaaVK/Q8tHHQe7eS+iN31oCl82wzSR7C6yazmwqJRgu4b37qVoNDZF6OWWuimkd9ZSf9LluANp1hV2kqU/otf/fdktVvbvf8xVdm6/HK+Lcg6yuxzXTpqDwmeUycokRcEVPQWB7pYZuDF7bgVSAhsrcFz8pzloIMGCU5H4ts0q0sL/q6a7jRUns+kxpk/Zs1XG/P0LwTOq0Mbhgb4jlPuHps4oFGWRdmshYkanxjUxYqVMNvk5VYpLMOUX9lSwjXE7m9k3zbcJbK9kYpKlup+Jux32U5tSFvF55ud1hAX04nV+zcmfyhzbbPOPlgo1AMu8eKBak1HAA8DmQ1BMATpceamvBpMyO1UnYfAKMA==;5:ZjKwacysEakM+ewJq76WeHSmfvAhUmkBTEMhPKw+5nQHL+mJBcHDhjh4SzDv7FrhFL2O5BviWNMGSxt8QAlBSEvdFNeL9ZcKbbMhsQqSUXWCzJeX0LeahlCkRJ2SflD7Gd+LHqw55L7aHdajlTbfY4e6MPVdTIdw/ySFQ0otQKA=;24:TpOamhUzJKeVVfMDYLOTxNPnGgbqiX3S08T/D0aMEgYICS0aDjkcXSTY0sg9UO7dAVG9uyqaERA3VlNSlVHBT+pk2ZVO5Bbkge3zYc0TONA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0165;7:TtMixgCr5q55xQZO5asV3ZqtGQKbykK/CJE4EiRoFivLmBgZzrOsYbx6JrzqY9T4ebZCCl9DEioMi91ZlA2PTudtqz1w51v9CQCs0e3VjlHSCnBhF2i+DOI83E6FZz+m5Y6r1WPuWAaLM+kOgyTtqR4EIFZzhepeulkljQJu6IXoDWqJkRZpsnXKKqwBd1mlQCpEFZfu255FrnwVhdJhyvHWR7AMWFRz+B2GATWtKqfvy5z+mVD+NBKou6Vrv0YV;20:GeTOaZ8nXaXq6xem/Q5CHgsdBVmrMjL4nEsWQbmLyjO6nfP00mGq/I+X9YyY/EvJgpnFflFxnocZLlRsCtI/6Rxh4BF5Uhe5wyjIRm4nnt1JVYxV/a7lQr0c9YoltdxasVt6K5AeHJOgu3ULzJ2gok4jQJ036lnCor0NfiZnqgs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 18:53:38.0870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6f683c-d2de-4cc3-55f6-08d5e5cd4873
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0165
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:37:45AM +0200, Daniel Borkmann wrote:
> On 07/08/2018 12:35 AM, Alexei Starovoitov wrote:
> > On Fri, Jul 06, 2018 at 02:52:32PM -0700, Roman Gushchin wrote:
> >> On Fri, Jul 06, 2018 at 10:42:39PM +0800, kbuild test robot wrote:
> >>> Hi Roman,
> >>>
> >>> Thank you for the patch! Yet something to improve:
> >>>
> >>> [auto build test ERROR on bpf-next/master]
> >>>
> >>> url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/bpf-cgroup-local-storage/20180706-055938
> >>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> >>> config: s390-performance_defconfig (attached as .config)
> >>> compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> >>> reproduce:
> >>>         wget https://urldefense.proofpoint.com/v2/url?u=https-3A__raw.githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=ImwiAAR6DVyf5JEcIc5VLF9xY4lfFxVuk8_4BN6I03g&s=r0S7gFQPOZVZagshsK0pL3eU8_GRpD1ywrvYfXJ4yBQ&e= -O ~/bin/make.cross
> >>>         chmod +x ~/bin/make.cross
> >>>         # save the attached .config to linux build tree
> >>>         GCC_VERSION=7.2.0 make.cross ARCH=s390 
> >>>
> >>> All errors (new ones prefixed by >>):
> >>>
> >>>    In file included from kernel//bpf/local_storage.c:2:0:
> >>>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_attach':
> >>>>> include/linux/bpf-cgroup.h:237:10: error: 'EINVAL' undeclared (first use in this function)
> >>>      return -EINVAL;
> >>>              ^~~~~~
> >>>    include/linux/bpf-cgroup.h:237:10: note: each undeclared identifier is reported only once for each function it appears in
> >>>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_detach':
> >>>    include/linux/bpf-cgroup.h:243:10: error: 'EINVAL' undeclared (first use in this function)
> >>>      return -EINVAL;
> >>>              ^~~~~~
> >>>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_query':
> >>>    include/linux/bpf-cgroup.h:249:10: error: 'EINVAL' undeclared (first use in this function)
> >>>      return -EINVAL;
> >>>              ^~~~~~
> >>>
> >>> vim +/EINVAL +237 include/linux/bpf-cgroup.h
> >>>
> >>> 30070984 Daniel Mack 2016-11-23  232  
> >>> fdb5c453 Sean Young  2018-06-19  233  static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
> >>> fdb5c453 Sean Young  2018-06-19  234  					 enum bpf_prog_type ptype,
> >>> fdb5c453 Sean Young  2018-06-19  235  					 struct bpf_prog *prog)
> >>> fdb5c453 Sean Young  2018-06-19  236  {
> >>> fdb5c453 Sean Young  2018-06-19 @237  	return -EINVAL;
> >>> fdb5c453 Sean Young  2018-06-19  238  }
> >>> fdb5c453 Sean Young  2018-06-19  239  
> >>>
> >>> :::::: The code at line 237 was first introduced by commit
> >>> :::::: fdb5c4531c1e0e50e609df83f736b6f3a02896e2 bpf: fix attach type BPF_LIRC_MODE2 dependency wrt CONFIG_CGROUP_BPF
> >>>
> >>> :::::: TO: Sean Young <sean@mess.org>
> >>> :::::: CC: Daniel Borkmann <daniel@iogearbox.net>
> >>
> >> These errors have nothing to do with the cgroup local storage patchset.
> >> They do exist in the current bpf-next tree.
> >> Here is the fix.
> >>
> >> Thanks!
> >>
> >> --
> >>
> >> From c0cd59b969e060765514224e31595763213e40f9 Mon Sep 17 00:00:00 2001
> >> From: Roman Gushchin <guro@fb.com>
> >> Date: Fri, 6 Jul 2018 14:34:29 -0700
> >> Subject: [PATCH bpf-next] bpf: include errno.h from bpf-cgroup.h
> >>
> >> Commit fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
> >> wrt CONFIG_CGROUP_BPF") caused some build issues, detected by 0-DAY
> >> kernel test infrastructure.
> >>
> >> The problem is that cgroup_bpf_prog_attach/detach/query() functions
> >> can return -EINVAL error code, which is not defined. Fix this adding
> >> errno.h to includes.
> >>
> >> Fixes: fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
> >> wrt CONFIG_CGROUP_BPF")
> >> Signed-off-by: Roman Gushchin <guro@fb.com>
> >> Cc: Sean Young <sean@mess.org>
> >> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >> Cc: Alexei Starovoitov <ast@kernel.org>
> >> ---
> >>  include/linux/bpf-cgroup.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> >> index 79795c5fa7c3..d50c2f0a655a 100644
> >> --- a/include/linux/bpf-cgroup.h
> >> +++ b/include/linux/bpf-cgroup.h
> >> @@ -2,6 +2,7 @@
> >>  #ifndef _BPF_CGROUP_H
> >>  #define _BPF_CGROUP_H
> >>  
> >> +#include <linux/errno.h>
> >>  #include <linux/jump_label.h>
> >>  #include <uapi/linux/bpf.h>
> > 
> > good catch, but please resend it as a proper patch,
> > since patchwork didn't pick it up.
> > Also the subj should say 'bpf' instead of 'bpf-next', right?
> 
> Yes, this needs to go to bpf tree, since the affected commit went
> there as well.
> 
> I just applied the above fix into bpf tree, thanks.

Thanks, Daniel!
