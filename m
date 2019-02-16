Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDBCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569E221A4C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="hXPsv6VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfBPSYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 13:24:04 -0500
Received: from mail-eopbgr730097.outbound.protection.outlook.com ([40.107.73.97]:42754
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbfBPSYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 13:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJlsHANkQe+uHpN286Lh4iB+MCmRwB7Nbo+/+8yDtmk=;
 b=hXPsv6VXLwhfq+1H8IRSpZ7pVNDL29K3neW+D/ZJ75LuMmmo4do9zUUSYaj91yyHUqCgsA11mzaM8Bfs8XThgaYvNyaSjvgMSmI1epunLdqn6sn3TVGyq24jZ2KjkD6ZZsaDTHWfC4GbD6GpjnPQPriI/Na9Q2dmbFn73BtaegQ=
Received: from SN2PR01CA0049.prod.exchangelabs.com (2603:10b6:800::17) by
 CY4PR01MB3287.prod.exchangelabs.com (2603:10b6:903:e9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Sat, 16 Feb 2019 18:24:00 +0000
Received: from CO1NAM03FT023.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by SN2PR01CA0049.outlook.office365.com
 (2603:10b6:800::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19 via Frontend
 Transport; Sat, 16 Feb 2019 18:24:00 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT023.mail.protection.outlook.com (10.152.80.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 16 Feb 2019 18:23:59 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1GINtNO004555
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Feb 2019 13:23:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6B86E7A5779; Sat, 16 Feb 2019 13:23:55 -0500 (EST)
Date:   Sat, 16 Feb 2019 13:23:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] random: Make /dev/random wait for crng_ready
Message-ID: <20190216182355.GE23000@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(189003)(199004)(76176011)(5660300002)(1076003)(47776003)(26005)(90966002)(33656002)(97756001)(14444005)(6916009)(476003)(2616005)(6246003)(486006)(446003)(336012)(126002)(11346002)(186003)(229853002)(23726003)(6266002)(305945005)(103686004)(4326008)(106466001)(8676002)(26826003)(478600001)(8936002)(36756003)(246002)(88552002)(356004)(58126008)(36906005)(16586007)(86362001)(106002)(786003)(46406003)(50466002)(316002)(75432002)(2906002)(45080400002)(42186006)(54906003)(52956003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR01MB3287;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c6d17ea-ba2b-4c8a-e49d-08d6943bebce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR01MB3287;
X-MS-TrafficTypeDiagnostic: CY4PR01MB3287:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB3287;20:SrkWFUXHK5CfMwksUSKyOZIRe4TIInGglTUlVajNHkYxKIuikoi6zIMz6SRnrF2jWBzH8pnqVCbXJfzi17A4o1QF/qgfg9VY4TDltj5vUKU9YdZb0IIVqWo5iMkO+ypBllnWP9CBfHMV4jSakXqhPZUKqf6+d65S/vhkGmbYkAOhGeQUApqpsxdt4kppkyjdDEun6ALbKxRuPWAbymZhsPxTSQ4JszrQCtDM4p/hFfrXSr0nd5c2cvehHc7FJXSLKpLgTM23bGvUAylKWHxH57MimIwvq6rhqQYYclkmwJ+8JsOAXcFKx3dW25gNpfHa4rg/91YxE/a80dCvYNE7Bh+cIYHK3D+whNFWABmphPPK5Y66flUu+O9cfyC9HEdsJT4kLVpmfEk+X1OOAz/kecTfeUcoK5cBo/Ev0pSSffpOfMy7d9dWUPf2o6yx++rJGKxhfR6xHC7hq8zB3r/bZF+g9jySCJFDHfOcnBzRCYg5kxYHzCP9YiKsYlhtLbqHeZmPgl+rU1aq68O8FIu9LQlFGPg3p8yIslAeSxSxZQZE/91kS7KqGKGwgTJ2HK55emI8UaukhyqjmWgqLZr2jXu9PDfkdhmF9SXIcA1bAXk=
X-Microsoft-Antispam-PRVS: <CY4PR01MB32878920B847433576C009F9B5610@CY4PR01MB3287.prod.exchangelabs.com>
X-Forefront-PRVS: 0950706AC1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR01MB3287;23:G0dd1Xa8G4Jo/4Q4ToyUpxDkE3ZiWO6EUlwqybPTY?=
 =?us-ascii?Q?FYxO2wM6QLqHw17DDblhQFN9EG00Hk4dNkGxBhK7YV9KRGTXEX51f7JNBMys?=
 =?us-ascii?Q?nLaw5xQUuMPFrvr0TUmo2nDgVufN+2MxEW1UEHhsgc8r2FTpFsaUuFf4tBFN?=
 =?us-ascii?Q?BN8pjwF/9F2KxlH8vtKMtvh2A9SqzU2B2jZ4zRnjgSzwUp0BGiQLdXoWFV7V?=
 =?us-ascii?Q?auerpSOOmSFk/3nXDMvTlLizN5U6kzpotrOUqI5OnHfyMC1fg8aR2jrph4yZ?=
 =?us-ascii?Q?oynbqLpnXxmohTO9Sj91j4K5QQc8UZdNFzgz3fLskrcv7fT4TiVoDa4jZ/4q?=
 =?us-ascii?Q?a5BCTkjoodMtTVzY87nlHXJQdM6tBQh0R7UT5KAxhm8VOejHhvQD+Tx9idO+?=
 =?us-ascii?Q?PtOGcW3Y9VJjM63AImQE0m1yQ2ptf9OHVJAGkLfJ3k1IoxgK73MWHKS8JIVz?=
 =?us-ascii?Q?VEN9VfvilAJfl1jXYAuMWM2itfjPHlRcVujnmJqVdL6eGitLab4YuR30ps30?=
 =?us-ascii?Q?EN85DyI6iowHZ3IC7lFyCp87sofOAtSPFqHrZA8qTpyWGXNHVfs/vR/oqvk9?=
 =?us-ascii?Q?j3k6KRraiB92uGcmJFuinyf5c4535c4TzrFqfEW8cGh5h6HEc0VKjTA3FHFV?=
 =?us-ascii?Q?B9UO7E4TC2TckOzjs7u1XBmB27Egae+wVC6lxl/o1mroqdfAZ3HVMMiLGtwV?=
 =?us-ascii?Q?CKp0Mig+cLLTwnesCoPckisWBjg8tL8MVFNSpurZsIhV7kcMM3JjvNF5Nte8?=
 =?us-ascii?Q?MGkmxGyl08/oRtGJtCC6PQQhLHeCnlGqCjBmg9W5HTmKVj2TV8xFXPc7da/o?=
 =?us-ascii?Q?g5x51WNTnMYn4TJqa/A0m2s/0bgFTsdZXi84mqetVlkIEaIvYtqFA8rQ6JQy?=
 =?us-ascii?Q?D+5lt+o2B/+TNA4Jr7gk45OqTbBCFYBZlqIN/EHZL+hxDTdz0meailVrj+/q?=
 =?us-ascii?Q?LnVkTtW6dwtVzYUgEubgykDuP76xPuOjsAc6j8ksR2JtUgHetwEKbE9TyCRC?=
 =?us-ascii?Q?KuQKn2pHd2H/mlbx+ETW1YGKEGSIkECwJpJYOi5XjZ1/ThtDBRy/0xJKdmw2?=
 =?us-ascii?Q?V15caCl6rS2ySo2T05W02uc2jk41DiYSPvxBBzOTSxsCZuTwiY5aKQJz3YgG?=
 =?us-ascii?Q?yGNXI1bzeZ1eXxNN7HbmvRgZhQ/dA0wBCx9mWr0AHYNKzZdeIXESOhQ/+DT0?=
 =?us-ascii?Q?WSUPknmotlqOvxMtL2dbcZi3QwINKG6e+0TB1KU2QFncaBieZfbgwKebx70k?=
 =?us-ascii?Q?N2ASrKTexk9Lwg4y6kNx52rBvuA56DzgK980XlQtMEcjLDT9LsaJ+xY3tN/1?=
 =?us-ascii?B?UT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: d4xZbFcSFEBiZOklf7L390XDrxdTAVabEOtAs6e4QMOKGYdTAU1IbiI7ZiH8yaGxeo4/ITE7dmPv3v1+sImKMYrvnzhUlNn2kV6oVwIS1FgFhtM1Lop/hHRinuxFqpGzYiJ+Bv73wpk2w4NuBUb68r4RMciZgW5CrC/5s04cZuhLrbVgIyFLlvkNKhqkybU18ZpADSAR4EW7+TMZkOjlDe9+dx9dhib0d4b1N0XFsFwG3RoAVARF91USDsxrI3n27UoMbly8DaC3y24pOIB1LERPIRqIF1K84WsSAXxGbtp8oG1GmnNJd+lSaVSSmXkCQSx3sifWRSPV+qmGsl3TsEYOxefIACPDb6ht3TPSKNAOx/lU4V1AuxfgQgwS+1U+L/P68NpJgjWkwTaskD1Cz7llBFM6LSK4S3HfpoO9/vk=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2019 18:23:59.5606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6d17ea-ba2b-4c8a-e49d-08d6943bebce
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB3287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:58:20PM +0000, Bernd Edlinger wrote:
> Reading from /dev/random may return data while the getrandom
> syscall is still blocking.
> 
> Those bytes are not yet cryptographically secure.
> 
> The first byte from /dev/random can have as little
> as 8 bits entropy estimation.  Once a read blocks, it will
> block until /proc/sys/kernel/random/read_wakeup_threshold
> bits are available, which is usually 64 bits, but can be
> configured as low as 8 bits.  A select will wake up when
> at least read_wakeup_threshold bits are available.
> Also when constantly reading bytes out of /dev/random
> it will prevent the crng init done event forever.
> 
> Fixed by making read and select on /dev/random wait until
> the crng is fully initialized.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

This really isn't a correct way to fix things; since the blocking_pool
used for /dev/random and the CRNG state are different things, and are
fed by different sources of entropy.

What we should do is to have a separate flag which indicates that the
blocking_pool has been adequately initialized, and set it only when
the entropy count in the blocking pool is at least 128 bits.  When get
woken up by the reader lock, we would transfer entropy from the input
pool to the blocking pool, and if the pool is not yet initializedm,
and the entropy count is less than 128 bits, we wait until it is.

    		      	      	       - Ted
