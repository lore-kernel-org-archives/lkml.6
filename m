Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFD820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oE9yfhRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFD820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHAFpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:45:08 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:59856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727785AbeHAFpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqwtrneQ1PXVtL7cP2pnBxOQ2Mbew8EVWtbxMb0mj6U=;
 b=oE9yfhRB3WlbDzfZsEza3xdoKDL04K88Kb+KiahXBJag6HKawvAuqEksAoWo/PVZwwilsdcxnIb3awpkFSpPmJ+XNNDcsCN4mQTtimhQRcwFZQyeOnjA6Fv0lAE3QUbwsmDs4cc46cJO4S1ivH7NQ1DknO0yDgJaQ98MR01MQrM=
Received: from [10.136.131.27] (202.56.249.162) by
 MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:7::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Wed, 1 Aug 2018 04:01:31 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de> <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de> <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de> <20180731131246.GC5719@sirena.org.uk>
 <s5hin4vpm80.wl-tiwai@suse.de> <20180731135115.GD5719@sirena.org.uk>
 <s5hd0v3pkyj.wl-tiwai@suse.de> <20180731144052.GF5719@sirena.org.uk>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <12bd6a6d-53ec-46f6-7f0e-af20e219d630@amd.com>
Date:   Wed, 1 Aug 2018 09:31:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731144052.GF5719@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::21) To MW2PR12MB2362.namprd12.prod.outlook.com
 (2603:10b6:907:7::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55fab363-87b6-4a65-d579-08d5f7637861
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2362;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;3:XfOjZIXqCrd3RlAuPxdOjEX79uiui7H83ngBS7EAM0AguvVf87M+LSFe/ncbftSeg2/J6biGWPREk+B/0llEqvtX6Ini87+Qey+ozcalYnsvgku5LPP+jy3Nc+oFUwaZ8EG0ic0W1jJGDa6hhNNVn093cC+kO4m0cIDD7WnUcWI6RsHNcwIEUT3sIR3j8KmAg3Gn9HM0Tj+4euELFNqZ0oZfCN5feUGKL6eg70DZSjQys9IkV1HE3dHngcMcFtAf;25:a1yyjEpr0n7O82lvrB4MhWttru3AvzARcgkjlkaFfEjad6fnB2aew78iso3PrfRZa1A5LquUVnSZeQeSHk47qOSjd0ytBiTfQGbXwD10JCEv9lmxXCasUranIet0azS2xEOQsP6MANkUutICDiVxonVwyyYNZb6nGLqnmheYN3i+SzjQm/8s+YddTwOsD4TXIu2yQCQLdM96g+975ZLAtxMqTNAnDrgMMUl5rOSWhToXgiI9AQuMYR6eUlq7O5O92wDPxkTCr8Qo/3x0Z63XrrJ1Ot37cUWDhJUUUx9hqB9TxiOe7Ym7G/GjsIUf0IsH1riU/RxgaCwvTJNyKLMetQ==;31:zOBE8o05dwPnZw9UBMb2r8kKRjgElrIf3Px0gZXFh27bi2wz3AFQKQHs2uFu/gGZXIwVfFGRdEIIcBw/wO8b8mA9o4jnHnW+s//UBXFGHvtFYGC91/biw48P+Ir+qkWzOw+tfRYqWoy0bElqOL2urWjxXf+SGuq4JnuApQUa19S3THM7TmzdHqoawxBhfb89//evehB2WrECzN9TDTgM8uY5bT3CP7GRAKfK3mzcX/Y=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;20:Sg2bc8eHXNxKvFp/+dtjTh87WTCltZn/G2ABREVg8xFSVziyJvMsdxhSk4pzLXA9NpxTYyu9YBvynIUkzUQBqNpHAgV1t0OhVMBPr9yj362GzIyfJaTR/j/u+I1k1a09CBXt9zC6dMEFVbHXfg6GgpEnLbmjVtQ6/yrr6bxnwTLA6Vpk5TOTiv3lYCyXAjv0ztBaYiMGyjHDH5mvJ4IyFccdONyY1r7Bl48FG06NeCKO6JKGnZ3NHDwpNFrHAOFNBon1akKCbBN4qFnEe1N5iGowvVufROE9b/YogAZv4xJSHvD4eOhXNuzUNHZfNYaZ/eiP7IYbYdO45ws2A8Snm9EArrisvV30TKI1Ax8LfS1G4fWuaMBkQkFxJQ04cLvY0C9eQ3eM6IO/Z4nPOA11NlHZRD7SMlS8ohOvLGZ/oCPrJAnW4d3FezBWV75iSlS6jtKCCXqgDssWePNZIYnI2hgOGOqI5TXtJq8/jIlfywLdWidl4NS4pnJVQ4rjOXqx;4:qrhuAeLL7BDlum7dAM8jG3k9ioEGF9fhibyPMXElfjjfeQAgaprzis/CH1ZSbJU9ds9YIdeOdn6Rl5Jc5y6ihp/wqLgBQ2mNdzarhmvrGhFc2OYe7fEY8QroemuStRpYdX3h6uYNG6o2IVBWOTpTQ+X0aRtAW0ZaV94GrWZaNO7NhjKoCcDTw0jp3wYTpdMJ8YgW6A1b82+dUE5ZyXV5vbZr0C4AgEN+dK3jaahxMFZQydrtQue95ZeHBRmUU17bOYGsbEr93jBkxmT5CBuW2A==
X-Microsoft-Antispam-PRVS: <MW2PR12MB2362CE8096355829C6DA291FF82D0@MW2PR12MB2362.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2362;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2362;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(25786009)(11346002)(476003)(16526019)(31696002)(26005)(229853002)(77096007)(106356001)(186003)(2616005)(6486002)(64126003)(31686004)(486006)(23746002)(50466002)(956004)(105586002)(3260700006)(446003)(65826007)(47776003)(53936002)(81166006)(65956001)(93886005)(6116002)(81156014)(68736007)(6246003)(8936002)(76176011)(6666003)(3846002)(16576012)(97736004)(39060400002)(86362001)(2906002)(305945005)(5660300001)(7736002)(54906003)(58126008)(53546011)(65806001)(36756003)(72206003)(52116002)(316002)(386003)(8676002)(478600001)(230700001)(4326008)(110136005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2362;H:[10.136.131.27];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MW2PR12MB2362;23:M1it4o+yvmWuKn6Va0T8lMlbCb3ohMsJurEHb?=
 =?Windows-1252?Q?vekjVUZ67FFdIJo1M3D3OHerZC3XAWy2V6gCQQ+NZnqkC1ke2IrmINr1?=
 =?Windows-1252?Q?wvinig6vyOEwjDJVL6EtodbBXwo/V8nmrnWkG1/vXyK3qJarGuPXfu+s?=
 =?Windows-1252?Q?YhF3Q9Ysq7XjkxapdZ3jGTd5p4j/jz4Q3J5dXCbzEnG0x0oUk1p7iasG?=
 =?Windows-1252?Q?KfLvn6JB/O4kzAYuM/axW8lMpbOA+DVtwOw3TmzdGCcdLgEXNxKoE5nn?=
 =?Windows-1252?Q?DmgPoDLoAZNferbsTyPFKkvs9O8KwenTP0nJEjXptaYLge5d18vB4fky?=
 =?Windows-1252?Q?J7YvJr4qGnsc+lj3Ar8G0NpEGAW/d+Q68RaYf+nuXkrc0cRLJGXul7pM?=
 =?Windows-1252?Q?3JG3/sQIbtd6Glm6RXRx/FeH+7Hd0uGIWsLF2XVsVFgQpRuFaya2U29a?=
 =?Windows-1252?Q?SZZ9EjowKPtTtXuU2LJk/ZAaNThSytOe6wGhE0KYVucZo7g9PGhowKLG?=
 =?Windows-1252?Q?1UnVcOzcVtOgZqf1UwtmbI1QE4D8/FPVQRcwd3lznZ/zU+nnLH20Takc?=
 =?Windows-1252?Q?+YDKoh9dKxmF1OdyxzuJYCpTAKSWOp0YS/osbvEaABU1convEIkwd67O?=
 =?Windows-1252?Q?9oFURTmv4e9BkKIMyzy6GVI71sJ1dB8UFMfY+illyEEd1Omd0+tHvHEX?=
 =?Windows-1252?Q?ydBMTo3+XqCtql9NE9NSELh8KX4MAnDJRV80V4hLA7KbPzSHySeqZdvp?=
 =?Windows-1252?Q?tXOM1HdPbOnfmyjNo41VFf8VhDJ8XYhGRpnSckB2rr0ybOggNk20Sn3c?=
 =?Windows-1252?Q?/bJ25mgZ9w3rF6AiR+m8Dk7iiQAl21cIogzMW8oTANUKkjOUnW9wnlxN?=
 =?Windows-1252?Q?4wzb+21r6V4dcklg2RnJ9S3Dm2Y7tews8S94D7JtqTSOyQLfGnwG1/i7?=
 =?Windows-1252?Q?7aHpyVBmAWFsmWiZPie0MBm30VBuADu/zmDow9FqvVWiGJvLP11aS7EJ?=
 =?Windows-1252?Q?JJ5Pz8BVQmDtFu/GcbPHiUDqf7z1i5OV3YBlXZwrgmftyPBpBa5YRoVc?=
 =?Windows-1252?Q?WY5jUYnUXKaZarlGzqgcVxK5DVFuEOPDQ+gzc8eyI8qArm2WcHvtXvbl?=
 =?Windows-1252?Q?vjajNQ6MRDl6F4BZ32UtRwRX3c3PmzMa7A4eV3phmqOxdUxl0asnx8PX?=
 =?Windows-1252?Q?X8UryeBJK7nT2RJAzCw4yXcy2CXUhQSno9GeauKrzNYV9wj2uk1vBgY+?=
 =?Windows-1252?Q?P/+oPC5+btrSt418FLOXS/YCnuI7jFEgHa6qEAHMHnV9UDsbTdEDDC9f?=
 =?Windows-1252?Q?picSMfajo2PDiPz3W5x/4U4eQJVMA04wGa56iHS9aHoNG8I6gb9crFhn?=
 =?Windows-1252?Q?r9n4xvdJWF4F7w5q+G6xHKhfl4+gAB7ukdmnkjNfHmpQXZSU+nKkS/4D?=
 =?Windows-1252?Q?26aBpPV/efrscF22Lxzieir6fZcBbaL5MjY68vW38BcAT7edeYsNezcx?=
 =?Windows-1252?Q?D4oFIPQiATZUKUqqQWV4bEdDDcv46qOvlWw6kpNxHVsRitaJkYMdGQIZ?=
 =?Windows-1252?Q?L6raS5yk7IIWwvMWyTHmMW+kqx4NBl6y/4WDUOUXONLjc8woZ+QFsIRR?=
 =?Windows-1252?B?UT09?=
X-Microsoft-Antispam-Message-Info: pJyXmnFuIWxDWr5SRq+Q5/U5iQpRRj5X9XyWeGhrcdgcyiSD9SioIrw54IaR7/BC/bFmekYaVcZJIfZLkkBgua7WbXcHDkGaOnByURYPddOfGu90DMHKQflSlC33Uv9ioXeExG5GC/aSIIzCgDBCuCe9QmLkxYAvBXdq/KCQUyK/EIbDI5/NblOwrwriavmgtc4LfhpcmzaCFJvX1M7Bax2EZYYXKwyfCJJH3sVQNg3gbbRJc1LqnkfO2AF2EU/ybt0ZyXiBP5oWv88OkcKQ7mLn8ivpWCRsbp7wIzNyjxCQbc1udowws7qtZ4K5mXSb9GGDkVh1uFyQc+eaXfbRkn3GwOoiL4rN6hQjXeQ/Q/Y=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;6:JS8uCKYM0uu63inYoVj9LhYmGm52g9YMtnT6+Tfbr7LNkOJ/xxnzYfETa/E++vY1US/DTHPAIS44I/pQdDXjOMg1nCy3hSIubY9273WhSuBw7shNovWntXgG1pNd3q2CmFO5BNqz0UBQQypctQSh4XXm1PEZF7q25ZDzXghhwWHUnsDFr2H9/+Fc22GkM187XzEAITX2Bm3hOAAEsLdLBJ9GDzWSiIU8dKXxBo/tLXPAwLKzWN2AXWL8PQrddCEcM47C4tVvOZ2WOkJ9NJVtx/cHk/6zyE5QmtDeq/UPmVvHKXkBVGyYHDURQPfStVxbpyv8aqD1oD9P040gn/z436BObpVX8wJHFhiP/BSbiwjrb0CPBgyqu02WC+sBDkIU3dD5C3kgKpZk2zoVl/ZWFBgP8QscXXg09AkNU5JvyONASXgIwhgZi+etR4/0whD1nmx69bh0/d+cQiAvZe68IA==;5:IQliDwvXLV+0sfgelermeQCquvXYf2L9/l4jwFrlCDVHLhQUw31JBjNmIunNS+EC+TxljWCTGhA0idFasYcz6ti3nTllGXwadaSEDWXqk2AS4aLuUtPyjwmHs68a+v3iWbf/xohAeR8jfGdx5YYFyDdV3ub9VDwqR5LLr4qXn4Y=;7:NpMDTf49dQhsof3G8PCcNGXEgQ2xGE83/vvrS2rRQhAFm7BREu3zSpfj0nuA9Qh9ZoV+kjzom7EMpvoBN146ta7Asdxm3pRjV03g5kR/QD1x59Yr2tICdr3Z4f0NSnu6WEFQvBwLzJW9yR0AWCLb16bnM7P1Gu4Qo7OX3yvjLXnOZ70auFBRRiOmx06u5PzLB+A/Bc2xJVzEG16lhPG2R08HpU6aMKZc02CUg3tDiy+WyRz101Yb7zmm4ck+x/7+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;20:tlv6bp6IjfiGDocSyAVyOgKIVCnkGlZfWv3UTO1CZkpLXsLpCIwsw4rxKIdVA7WIg+owgll3C1elVmkixp+afFluYI6JEMvRvVQoaULLucYZMB7mUnfPti/WHBaxG4HrF9rgQJ9uqUWlx/PB5pCRkL4SaQWJtYAhGoYZkZpV8QHcs6V6lk+7fibzR8whAE7maLa/4sUgSl61imuXh/0fBcUNNm9/ldRTgvf5h/cNex98/P+XFYXDhh1FcsVFC+2Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 04:01:31.0055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fab363-87b6-4a65-d579-08d5f7637861
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2018 8:10 PM, Mark Brown wrote:
> On Tue, Jul 31, 2018 at 03:56:52PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>> Yes.  I'm saying that if the CPU DAI thinks it can figure out the base
>>> delay something is confused.
> 
>> Then basically Akshu's patch does the correct thing, I suppose.
> 
> I think so.  Could perhaps do with a little clarification though.
> 

Ok Mark, I will submit a v2 which makes it more clear on the intent.

Thanks,
Akshu
