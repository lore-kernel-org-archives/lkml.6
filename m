Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A2ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8ED21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gO/GP/mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8ED21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbeIRIot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:44:49 -0400
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:11072
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbeIRIot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYPLql5n7XV0Hpj08a/fbTexMqZKw7t6E1bijpYP55s=;
 b=gO/GP/mkx1u7agAOkVn3iww9hE7utlZKs1feO3QBedLTCJF5K4aQfTryWM1N8BZjIsuRjOoUJf+fADquAwOy09Vw0hZixQ2w3ARc6uMUHcvVL0Sunmnu9N3n3+T1pBQTfAhx8WeuLoY7FYCqWBsbo4CwiHwtntSXPoxXnLvZlus=
Received: from BN6PR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:405:4c::27) by SN1PR12MB0432.namprd12.prod.outlook.com
 (2a01:111:e400:5865::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Tue, 18 Sep
 2018 03:13:43 +0000
Received: from DM3NAM03FT006.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by BN6PR1201CA0017.outlook.office365.com
 (2603:10b6:405:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 03:13:42 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT006.mail.protection.outlook.com (10.152.82.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.13 via Frontend Transport; Tue, 18 Sep 2018 03:13:41 +0000
Received: from hr-amur2 (10.34.1.3) by SATLEXCHOV01.amd.com (10.181.40.71)
 with Microsoft SMTP Server (TLS) id 14.3.389.1; Mon, 17 Sep 2018 22:13:39
 -0500
Date:   Tue, 18 Sep 2018 11:16:08 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Rik van Riel" <riel@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Fengguang Wu <fengguang.wu@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] list: introduce list_bulk_move_tail helper
Message-ID: <20180918031607.GA31439@hr-amur2>
References: <20180917120834.13993-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180917120834.13993-1-christian.koenig@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(428003)(3190300001)(199004)(189003)(76176011)(104016004)(1076002)(33716001)(7416002)(2906002)(6246003)(4326008)(86362001)(72206003)(478600001)(39060400002)(33896004)(486006)(54906003)(305945005)(77096007)(6666003)(6306002)(426003)(33656002)(53936002)(966005)(68736007)(476003)(446003)(126002)(55016002)(47776003)(11346002)(23756003)(58126008)(356003)(97736004)(336012)(186003)(2870700001)(8676002)(229853002)(106466001)(105586002)(81156014)(316002)(8936002)(81166006)(9686003)(50466002)(5660300001)(110136005)(26005)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0432;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT006;1:VE3Dt75/tZyKGUSk89Lr29H51QvdSZOPSRXUvH3IKuFkgCgCE61RdBAKiddhXqMTjI6MKkHFT+OGVVRZC6rb7ZiXoqKwhOErKk+QVZXCdWn0Qv9WgUQLbUhSUdLD/DZa
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46836e53-90e6-4c5a-2715-08d61d14bcd4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:SN1PR12MB0432;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0432;3:2tOYV+9pqdoIzWnHVSzxKqME/Z07q7G7S2xkCUwSqyzXoJpZ6KthJvMIfPm05UxCbROFN8I2AtI7YwX/wSQNsGK3ZrT9FbOtsDgg09iCQBhGJBQ8+aUZiHt9S3K9ib0MrZ5eogBsMzp0x0X0xBiUTqocsXFJvSJxPNYllYltjSZqoxCNJ9h5yR6rqSUMZSovglFI/PY2zXRYxWxBxQgsS1BbsOkASWbGUZQApAwIXYT6Vzq3VYhts7Ig5bRIaX3u7sAmrKHclnpOT67Raqi7ErhX7T8JGrKvFl1DlUSgFi+H4qZzbzNBUVGeC8kLRsnRvVCvjK69wB7t53MMW5Sza2mmKzLxp3uDxG6czRV/FDE=;25:cmrg1uRSa3Fh8DSdr6PMApQNCqD5/c57Jc52Eae1bLixvSOtuwZY6zmH897JgP/5Et0hNYLzX9rwvz7FsRMKkRPNWunzoAQTP9pD73m98bpDb2Sb8aV1rj0bvgJBCcgdNDS47J7dGf1jWCXWVlWqiUg3HYSmsxuq+OrZX+U+LI5PTzhFRTyWc64tEXJ0YIBZ7CUZg41A9KPzPqJNDKPXPtAmb2E2FRoxCW7OPefAqkZibeKysf4jQ8EhafRf0inCPMOqvHyocIuE5uNnYKCv1PxWVkZU4zSPS/bKXxCSgmt5UoTdvx5FQ+tncHWyIJehpw6fOxj8ypu5qnY9aW5qsQ==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0432:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0432;31:B/Ytb23MI0rbhMk7eEtVaujQkfdwOwo7tziQlkhlqqwc0KL5Umrxq98T3b0lqqQv7rdnR+ugpwX81P+jFjC2/eZFbBTX9LL5Cr9v4UM+cKCgwZM6peOxnM41rT9lIjydQCeQswMxXcx0E9J1c89bK5K9S9fTeTWiR//nUzx52dGXp/LYU+onpt5kfPOt8uYnTCl76pTcCqwk9XEgLtsPz2WyrujRXwHaBEfH2VWj+8w=;20:hrkeZg593UtfhcCH1BnlMUnAfWtK/0TCRDyp7gfz/m4t4l9VnVK1YvCxSlPydSoKQ/Bb8QOkpEkuSDqTlht3fGY/grjmICMIEZdc23Kw4Lt3zXg2ih83XYr8Zz/HLLFyJwFzwG0eW0Nl/ABkRZaWtMLm9jRHf1JmT+XSOCUGCSDuH8Gv431EsDLnqkrpvNCyiVDAZz6YuSnomBczG5Q0ztOBrRUqxJBu0BHFFHrt5t/BKPXKCt723tJ7nO8ddVeHp0Z7bvyUiFmblJFwnuMldOvOgVNKM71X8aQkQ9FZKLvxLzZQNcCdfl+PMy9N0T0m3eFAHPvCrefOeE7JRkqOtS/AzA+4vtyPFskrxQepHJdLzThh14ocL6ZFWWME0S+FAJqCFkApy60o+izXpn6EPqsRQT92tNXWYH7Ql3QNYlW9bygMctcddmhK2ArgUs2+RmjKIgBhQyT7qRVCal6aPYDW2MTGBNJnlsDS5iRcVuKnA25NMVn05B8lpCAUAC3Z
X-Microsoft-Antispam-PRVS: <SN1PR12MB0432F872618CE1C54D05229EEC1D0@SN1PR12MB0432.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93003095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:SN1PR12MB0432;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0432;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0432;4:hrUzZpLSO69MnrvSAqs4UD2sU94jeAAZiZ4bAQP6wvUXE5ucBKWT21aH2FJcG57lXHDseSYObAFuf4ViD5pug4SBVy9jTwdVrpfYZMPLQrYS/ZAYeEztEmYmrzWHt9apJoB1WuWqCU649irMs3bC+oz655TkUR8t5YgF830nvmNVWTVcI6FGXAzL3B6rx1eKKV/I36innshofL/J9Dhtv8NonQaY8dskrrz9s7mx7Hz/5mAHtucntTeq+cnln+FcWjGbTfqHopz7MbRGFBbT82t3fochDKQX4Jmm8lBMsl2NGtLsC9oyDkXqE8zNz3uiLR6+k+b1TIxoJR4PuFSH4pJGPqd+PJqD59TRzMFky2I=
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN1PR12MB0432;23:2IlawoUc3KlzGjv9iSThN6l8Dy0OFTJ07F10DU3?=
 =?iso-8859-1?Q?Ip9uihjneL10OyFH6qkJvP2rPnk+auPERb13VzcSWcQ1DrlJ10TEX9vaRq?=
 =?iso-8859-1?Q?ZAM7QEpwWDzYaEJBOwPUENU/j7LGX0VUxpEBXMp9v1mWHgp9S1fA4bFymS?=
 =?iso-8859-1?Q?SBTyMKM8skNgbtSUty4TqsxMBIv0yCzsJrO1qRDSI0o8pUkqCfkXdB4+cC?=
 =?iso-8859-1?Q?k21v4TkLh1ToFe90hwqxEQqX1/UQ0Hf8j/uYbxwLAIsX7d4xRkCk1kRnoV?=
 =?iso-8859-1?Q?mraXtFshm6WVDtoH+slzl7gNY5tYMX5hC8rkxkW2TLd9axjrbDqP82/olJ?=
 =?iso-8859-1?Q?ANqwF5VdMZHXgeg2G1OR3kUJ+L/sI9t4IG1xAzVYJ2gufQvQhhheBpiugW?=
 =?iso-8859-1?Q?115DO8FeM939E0E1yR0+cML9loDolInTQj/74nhlzLy06bX14UEWuBsCe/?=
 =?iso-8859-1?Q?fqBi5xCS9UzLrQk3sDu0IEENWsy77atXXe5iz3FwK2G3aBzC5yfmo1vE7Z?=
 =?iso-8859-1?Q?SOV808DIQucD66cruzDfzqNGRv+XfgI7FVjklBccgmh9nKVZcJOHcDEPFC?=
 =?iso-8859-1?Q?1ue9LYcu48XZ+8bzeNVoJmZB2P3+2k9RvmTit6NHjy6Bsp9BTJ+T/fWmnr?=
 =?iso-8859-1?Q?a0Ivxzb7F5OAWBbGid+TgFoU216nYaDFpmmWG+PLV+mtBAxqlyApyzvGiQ?=
 =?iso-8859-1?Q?BZncuLNKGImmaiW1VlvqX6RB66fvPRgLFCm+LumNTrrx9BjYl0Pq/ZkLAe?=
 =?iso-8859-1?Q?H+s2h5PHpSyz8/xvFYVj+JU9SYAQ19IOPqDwCHaq5ugKIeXOpPW+JpbW/i?=
 =?iso-8859-1?Q?QgLKmPAlp5XoQUUZaFGniNB4+/X/8Xvwu0QDkldky7Vgs+tKNQGEExKNoM?=
 =?iso-8859-1?Q?el3cvxb5SAjDX9hwYmlPwNIgSx88VHHF/SZtmEwVsoSmb5L2NK44WVrAO4?=
 =?iso-8859-1?Q?g1wnk8eHTly63y9uBkaXgy5QcezKeZ3IQ3eI5tZPe3n+PfOxc3at3iEDLo?=
 =?iso-8859-1?Q?dY52SDYfsbu1hnA+4Z5HlIZWu2/PDLY0gKr55h/6LHGcmGMJVPPVCKTKJr?=
 =?iso-8859-1?Q?zAYaJ3L2JrwDEXq9tOFFJpVSbEoP2g6N5xehFxYqrdx30rlepUXk6v00M+?=
 =?iso-8859-1?Q?77Xwu7fHH/NiSj1s+VlesY2tfJ5pmHz0In97gfWWx/Rkm5vV+8RkrF5iSd?=
 =?iso-8859-1?Q?6Nm9/qNvXde8IdTsLFg/XflRYUjsGCb1HLNdf+g1rViMgyCpmp3/IPbgrj?=
 =?iso-8859-1?Q?IYNEGrefP7Y/7BBEzjp3//AF9XvqM+QuQ2kanay4B7Nf2oRsQ4TbuPQkdd?=
 =?iso-8859-1?Q?9qZQYmrFHO4GOwo5kGx/GZtnMadepFjY29dxWwvKullyrHnq8Xrfofe9ZG?=
 =?iso-8859-1?Q?mVMFeRYbcUJOsRxbRKKuooKNTmND7t/8NUEKpgYZfxQS2Hej9dk+dLj2Z8?=
 =?iso-8859-1?Q?dzpk85aKB/mRc8=3D?=
X-Microsoft-Antispam-Message-Info: dQGO3/J3do8Kk8LZmeKYLg/CRCh7u0FONPd0WciIkXPJLJVodrYFrWvXmCjZxOVYfI5wq9lC8344tLCfKYb40YRVqE+xmHOS3k01ppJZ37BFu3vgr0o53WeNpmfXzo/PMvgOfe7BQSa/ohZV9rV6rt8nMwTVcMsds0Zj67Soh6BpBQkfxIgCHqdn5xQ35EZmfvFUMltLdNGqna16KsqFrqyYqPS9n2DdSsDUpWXt3bNHO78/xuXKCo7DkgXUoo4QEsmqtb6Q9NMccDNnEZjx/QDZKC0YgKHAfLouiGU9YlnoY5DZZnKcPz0cxtso5YfbEd1E+fdRFmT2Xg0IzkYja6PwfLSQRYm1XgezuvXvvt0=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0432;6:9zjsykJxXDaitY+hv5nKuBHtUZgpMetcTAJaU5tEVBpAfsPyB2ukvM80UzLjQzbwEBN9wKZQPmcE6lUGndXgFFT4/BflPPOw4JgTlwv0sf7kGqwtQfpJOPdHpJL/a5FOPTwPvT2/nWWSauzqkmBZoM4JfUgBbx6IXm5+ziuCcjL1JPu1Ruj/IuF+N3z9CwEeqwQv2u0XQfJJUGU6rcLWTulaRtF0PtV7zYYJtUk9NVKT6LDhQX7DG1vYRs/rWwN94wKhx92h9EGupBaqtFzZVDkV45wWIvc5ihPnSSBVmMvzCHdQ+XMqaHDZJxGXoSoqRbU5xgU5dYIGyHAGGzaNaBJ+8F3zri3tMRTlS6Ge/oY2rMRbsSYoRc2D4hyOrfxhLXvH6f8kwiA055gak24wZ3p9sFjKkN51ju2AbEXOy1fdxtRR5WtwxUITcbpURxHob5CCCqTxabzYkxsTtNZQlw==;5:xrfb39luRQlueB0cBXpMRgpcTbtr9roJg5hfgMQ8rq0+8abKR5uiaz0UASBJ0KHMyK5k3vm4a4BZ2ks0So3p18XAOb2DKg9fu9Oz/JpeJasvFMKjtKx9gGM5w4Tf3nVUkRR0miqT1MhdvRlnHScjuI6pcV8Y4zrFJG3Y+Irqa4A=;7:DNHiLvIfmE25NJqjaym5MQTX73iJNTFvyQWWPIF6a+FnknxJ910PbrPR7lmyWWRxr1sywB1ehTahadx/by5U+nU5MOszidxsfNAYM0kIb8pIZoDoPF4NP2P1UJoJwHXI+D2hIkh1gh5J2R394QCsBroO+C394iqPTe+IMl7lVl/0EoHi9jwbkYCPtllh1MkJfD9WKqqs+e2YM79eoElQRu1xJK03016o2uQWpGSz9qWhJYLDsduh5k3bY8UJEtSu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0432;20:kSIXQKIC5o4z4St46Mwkjbk4sfpsWFlw1fkfCjBDWH6h6Nk8S51Z/tqwHgmdwNehsl2uIS5vldFuHdI/aCPyXJxYLLDmol1axQMY+kFvv7aXanLOwHg+tLqm9JRRhvWgnivCnJXvlP/NdhqS2xPvSMsRGnM7uVMQp4Z7BdGdeH8Mqqw8ZlXeQNq7n0nCUVWH7L/aZbp3P+lDNVdt9Kcca94VrYg+u/l/LpWYh2xp1BQcN3j4f78Q7r9bqR6/8d6P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 03:13:41.8763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46836e53-90e6-4c5a-2715-08d61d14bcd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:08:34PM +0200, Christian König wrote:
> Move all entries between @first and including @last before @head.
> 
> This is useful for LRU lists where a whole block of entries should be
> moved to the end of the list.
> 
> Used as a band aid in TTM, but better placed in the common list headers.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---

For TTM change, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

For new list_bulk_move_tail helper in hinclude/linux/list.h, may we have
your comments from LKML?

Thanks,
Ray

>  drivers/gpu/drm/ttm/ttm_bo.c | 25 +++++--------------------
>  include/linux/list.h         | 23 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index b2a33bf1ef10..26b889f86670 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -247,20 +247,6 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
>  }
>  EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
>  
> -static void ttm_list_move_bulk_tail(struct list_head *list,
> -				    struct list_head *first,
> -				    struct list_head *last)
> -{
> -	first->prev->next = last->next;
> -	last->next->prev = first->prev;
> -
> -	list->prev->next = first;
> -	first->prev = list->prev;
> -
> -	last->next = list;
> -	list->prev = last;
> -}
> -
>  void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>  {
>  	unsigned i;
> @@ -276,8 +262,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>  		reservation_object_assert_held(pos->last->resv);
>  
>  		man = &pos->first->bdev->man[TTM_PL_TT];
> -		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
> -					&pos->last->lru);
> +		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +				    &pos->last->lru);
>  	}
>  
>  	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> @@ -291,8 +277,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>  		reservation_object_assert_held(pos->last->resv);
>  
>  		man = &pos->first->bdev->man[TTM_PL_VRAM];
> -		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
> -					&pos->last->lru);
> +		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +				    &pos->last->lru);
>  	}
>  
>  	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> @@ -306,8 +292,7 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>  		reservation_object_assert_held(pos->last->resv);
>  
>  		lru = &pos->first->bdev->glob->swap_lru[i];
> -		ttm_list_move_bulk_tail(lru, &pos->first->swap,
> -					&pos->last->swap);
> +		list_bulk_move_tail(lru, &pos->first->swap, &pos->last->swap);
>  	}
>  }
>  EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);
> diff --git a/include/linux/list.h b/include/linux/list.h
> index de04cc5ed536..edb7628e46ed 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -183,6 +183,29 @@ static inline void list_move_tail(struct list_head *list,
>  	list_add_tail(list, head);
>  }
>  
> +/**
> + * list_bulk_move_tail - move a subsection of a list to its tail
> + * @head: the head that will follow our entry
> + * @first: first entry to move
> + * @last: last entry to move, can be the same as first
> + *
> + * Move all entries between @first and including @last before @head.
> + * All three entries must belong to the same linked list.
> + */
> +static inline void list_bulk_move_tail(struct list_head *head,
> +				       struct list_head *first,
> +				       struct list_head *last)
> +{
> +	first->prev->next = last->next;
> +	last->next->prev = first->prev;
> +
> +	head->prev->next = first;
> +	first->prev = head->prev;
> +
> +	last->next = head;
> +	head->prev = last;
> +}
> +
>  /**
>   * list_is_last - tests whether @list is the last entry in list @head
>   * @list: the entry to test
> -- 
> 2.14.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
