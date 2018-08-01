Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DB4208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="e5nRTwiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DB4208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbeHASBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:01:17 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:42320
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389854AbeHASBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K91I24r9ZsDA2NsT9bD2PMb8R1YVrVjcJ2uRDZcfa4Q=;
 b=e5nRTwiK8d3TFBAcavzfsNDIDttiesZ3OybNNcEV2xeW58651pz050Y4PoqVv+lyktiDjS3h9qEUQqvQTL9Y0WcjOKtyrwT7b7HvNmIrU8Y12k0myxSYSgUMbXN8dJnFRLahdjAnEYRV/ub44YBx4wej/HbMNrJyfwRF6KN2Lrc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4452.eurprd05.prod.outlook.com (2603:10a6:208:5a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Wed, 1 Aug 2018 16:14:44 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fktlf-00043V-RC; Wed, 01 Aug 2018 10:14:31 -0600
Date:   Wed, 1 Aug 2018 10:14:31 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Hadar Hen Zion <hadarh@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Michael J Ruhl <michael.j.ruhl@intel.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Raed Salem <raeds@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 08/12] overflow.h: Add arithmetic shift helper
Message-ID: <20180801161431.GC10665@mellanox.com>
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com>
 <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
 <20180626175435.GQ5356@mellanox.com>
 <20180801093603.GI2530@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801093603.GI2530@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CY4PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:903:103::12) To AM0PR05MB4452.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d42d3d-a96a-453a-3d7d-08d5f7c9e4e7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4452;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4452;3:mOJJTq+Oi0ZiGSbyfA46At0sHGpmyRJhlpUXG+HmA8oAUV/M+0lMtBkGtJq7h9sZbIpn0gfA7sx22Px2LerPic15ANJ5EhEoM9oa42VveFzlBi6sjGoW0szllWuIvVjGeMos/VxgS6JKCOzrkcpAGc5doVscQv1cfu/jHbQTNMdFAfx+OsYk4AmhY6M//YawZ8o+L2MjwnkPAndNEy8gsVMTiXbyBeYMUGhH3hGXilMNLXDCnxIsVKEDqWwyw113;25:luyX+NqXv3z5sIuk5RYB/869RlOmB+33MBTWooqVH+BAWVmfMkok2u7aSZ/x8umtBTOHlpsusD0MCKKV51Z4q8ZZvmUku2kpMkxYVEy/vAz04R1WWClYA4LEEtJTPaolpkMtbYa3GEZCCibdkLqzGbTOEEvqv4SqbiEQYxr7dp0tstgLga4zrpT0vCp7EYkhWWt0PLKIIB4kWw/Zve8gezjdenhqZMZ7KOPCSKOlUrP5u0VT5pPBCGKl2opHqx1WWhZXz2NhEokeL8U0PpYRwSFuiU5c/0UBnpjbTxawKZSJpuk+4Mi7pPwhzSfLA/Afdml8GyzIijStyxsnppXdfg==;31:ixuLTsHWxsthbIUBCYy9vdbcK9bTIneM6pdMXFJ41FlG6F8bJpPRqhDD+UPci1V9bnAXtCl5j3W1+qRbUK2FQLq+ZKq/1mnIv5gQHGOqDAEIFOK6ZAWI7SmC730vqc3yYCiT88LxHtspcfAus0fOdD0MLGYHYfjNNmCps9tCRiQSDmpH/RpduFsVXJgswzYmPlRuJtSwWvISFiNBHTz/hrOtZWV1p/YyZ4RgCPNGFCk=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4452:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4452;20:ODDfvDmJGEOOFmscAY/sAvawH3p1JLMW2a9GxjLaqiJsG937vHuumQYmFxC6j6Jq+EtDp2vLv1pYeRmJI6zA5MIlermbUmuteYgPoYPbGrRMz+uJX5A7stx2X/nvIA8s1HjKAvFNK3zDxdu1qhY1Y1b5ICLMWqGo76juSAwWuQ4D+CO1ms7qsrPcil+kaV331mEybJdIs7uQJuTTXsnKI0OYiXLwVkSTdDXw7Jekvw3qFEfA6VmRZ5JICUz5ukEgvlcXLuHF4zM5hVWARvDwpJgb2zCEQWFv6vPjEM4bXPPqii798cJAYk/a/1nQmr3Qi1c68/bCxkyFIuC2K9VnrgRyk/CKVHkjTRyioWJk08jnplotTqJydm7P4/fCXQ3QmWF9kOCy0ASOFM3hQZ6OBT6FuMYedr3Qo+gHO9m2pHtmYAC7SOnjiN1M0eGmtohCSRaFOvaeihHwzzJinygmM6RdIquj4EoUToSYVWSfBrXTBpWA0S7COl8WjcPDzbUR;4:Im5ArBcb7mqcOREJLLCL/WO8CIMFyNIcPftJA3MNUPdEAGvpeoDf8sJMM0rv81Bd1peO+iqs3Kgpp3rJYC5IyVkK9iPiDE4whwB2tr/cnRXamJAO7r4dCQGTzVcr4MfB2eVtnzLNR5MwrEm8LwKOvy7zAJY9ltX2lzkNIP8iteI09iHR9Jg+dyLtH0vvhsqb96TjHm6U3BeCGzIIJ15SEDC11ZOy87VrOFluK5M+FAzqW4y8b9BmYVyswZFYRakEP6iMQ4awdTlUhS0yuTZbJg==
X-Microsoft-Antispam-PRVS: <AM0PR05MB4452BDB134B23B99ED3920A5CF2D0@AM0PR05MB4452.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4452;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4452;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(81156014)(8676002)(7736002)(76176011)(52116002)(122856001)(23726003)(1076002)(8936002)(97736004)(33656002)(6916009)(476003)(54906003)(486006)(478600001)(16586007)(50466002)(11346002)(186003)(386003)(81166006)(305945005)(316002)(36756003)(93886005)(2616005)(58126008)(5660300001)(3846002)(4326008)(53936002)(57986006)(9746002)(69596002)(9786002)(229853002)(86362001)(2906002)(105586002)(106356001)(6246003)(446003)(26005)(46656002)(66066001)(68736007)(6116002)(83796002)(47776003)(18370500001)(24400500001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4452;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4452;23:1CSHlNkpvMvQwFT8xzNZt8/ThgdF0COpQc8QYtTlQ?=
 =?us-ascii?Q?ebdREKwFnpMz/t/0hz6zIwNFNLRZpZgmrwJs+ZdRhUimzlHw0e0Pp0Lpc9t3?=
 =?us-ascii?Q?JSNC+iYqzW4M8VjNIHCzWvJAhCkuQ7vPm7g+ZveoIdF7GfAsSsIwXWW0XKo0?=
 =?us-ascii?Q?HHPhIarLT/ZC0fRhaol5Yzx6pV6bLF0p2VYGNeGn3DeMVp3cjF6gCIvF6zvy?=
 =?us-ascii?Q?1Jdhn4//k8ZT7WGIdOk1P/8eQU/5ob93ZNQXKa+oChSrOEvPxp4C7OOFVEHO?=
 =?us-ascii?Q?wuUWbJZLEcalzSdMYuuRY5/NZkThMz0sSUywsWtRRtL/w30ce2FCEcP0M1DV?=
 =?us-ascii?Q?rjUx326HLpGVPu4L5SPD/UDpa0Nkde0+8XHD7y7UY3QJ9Hj11o9w5TfNXKEv?=
 =?us-ascii?Q?otHC0e3KCE/lR6/rIxlH+tClwMobzC2Pw0pvUR5FK58l33i8pxIwNV0bU1KR?=
 =?us-ascii?Q?9XohEECYilbNnE/Hr6f1mseXWKTmbXHYcdfJBbEkFKh7XsgeEdSrS1niX5LJ?=
 =?us-ascii?Q?rugmN4MUFjWGqmJMQrp8jxVPHfJn8CjJJVwRDMv5BmDKdqDuxOUnfS6GG1fm?=
 =?us-ascii?Q?XXs9lSH00EBF09ImIGJRTfcM/wTVQs2IRPQRPwp53eWdAEmM1+/3kBxDhSNq?=
 =?us-ascii?Q?3wOv8zypc8YVyJzaU5+CJVUl3hPIxVoUbZ+tuMJC056cTSaPtQBqgfQr0mqI?=
 =?us-ascii?Q?jwHhoBRSlN0t9t4e+/uoLgjEPlJebv0F4sOFuue6dt7+zF7iG7HyCCNTrvvL?=
 =?us-ascii?Q?pC+PN3TFEtSEH+gg+HANPpCmQ3jWMMo21IWzJZ/2twksRR7D+c4ZSCbzv/bI?=
 =?us-ascii?Q?JJiMtoLx1CxElyIGmux5N9bxAou0EDawDrHOFiwiiQZUm7Wr3a3CX7fi3zOs?=
 =?us-ascii?Q?EoUWI001kj4XbWMSd3mg7q1vT+Fue4cyfSVe8FmmZVg3YypwqmjO4Z6C+Ix1?=
 =?us-ascii?Q?gpFauHoVWzRgx9LDauJZ+D9YDOyK1w0WiDL80LZumbeRcRT9VCsBttMRupBu?=
 =?us-ascii?Q?sgN+G+z6CBhdbtqfm8h2wcv3MYTA26LCMX7SoSLBzYet7uttR/uLfJdjAj7y?=
 =?us-ascii?Q?kcFNL34ljrgMiy70rQrMMAmiDFJIlxmU0Dq5gy3beyfZWif7EeepVrJZcvVb?=
 =?us-ascii?Q?DNyCpqgyThZEgjIllpQ6wxrGDqKgZp3PAW3rRnCqcD5Ow6tv6nW8E+BgWt7i?=
 =?us-ascii?Q?wt4NhGryBU9vBtZOE94rqh0v7Y2nSMVDZSGoE4UKnoF0Ako21hHoMlbImguW?=
 =?us-ascii?Q?0xy004boXqTgMh5pMgap4gpVcJiJV8ownKL8caBephW92+jmxg00OO98e7/y?=
 =?us-ascii?Q?l39gl5pgyW2qyrP4wp86pZixVnM4NXasVWJFCOgT0BCLjUtW2IoxkpAeSAwm?=
 =?us-ascii?Q?z2rCUlRTrw0f6CgliVb3gxG3rDB0eod9/2YZuvnruSD6NMgnGrTxOqYQ6vJm?=
 =?us-ascii?Q?0JnZLTTdD0cIJO4l6jTXrakVDb9wYDXW9EuOt/FOzxOcjmTMk5H?=
X-Microsoft-Antispam-Message-Info: 65cWZHr370gBywSDBPFDuajrnFMHlV0Ufl3I8k3OQVmY+zKcsW1cD5ysVMDCTj3aPdnhjgSPA5W4ES+QLWS3lK9u/uxQM3CmFre+qftlrMm8mqIf5eCes7sM6JwEFpDyL6vOJF2fV6mU1HHY+fASEssjncw1PDnMI35OQeDnFDeZJmTsFXWShkb6p0dzNh5Q5ee3kVYoKhdwC6GP2vWX6FYAgIs6f32eMu9MWE3OznVSAYHDH+NVcTpHnOCbP01OMj3xdfcArTX5n7koD2zpvl9idvAviq4NmrsHTnfaTlJHF3aJO7r17WiwugBMBbMgtpsE9FRF6MCo0q9a12+saGMTNG7jiC3Y0Zl6nmQrRkI=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4452;6:QRcX6JsQJaFV5CJyYkQT+uO0c5WMHbUHSvA/EmgyxGBKkz8ectv4WzuCZZmcf/bn0Nb2BQWj9U1rUnE9YPEBSZ+q4vrqiC2vsbCBLS1s8vuUieabLgV/t2f9GNv8t6H06RF5Iwek5cpH8JOYtq1Zpzcc2Rxjn7uTHxozvBYsaNNQD8CltjAYkN9OIcV2uyLDJOJfKGn7+OjyF5UhOJziON7fcRCkiXPB8+1gYw6hs4Q3vb1E2YW6z7uNoCRpSzbrXShDIJlQ1ct5m0/OQjlsrpH/NQWjJO2b7sn6ooBcRbzSkwIJ25hrBD9Xd0yI6imNVLXGb3rD9G8UKDp9SI5xTqQ7/BP33F5YCwPjKB318+gbXH2Pj6klOcoo0fvOKPHIcAzeaJsF5CMqPTYySiOy1H2pPPuw+/O/49WNa90dZpq+bVST0RerEORfiivO4jMLoF4WNsVCo12yL6rSwOK3nQ==;5:x/zKTsHOFWaWEiWMIHOpYe8xudKtXQ292hJa3dHtx2w9M02G1+HKFhQeWMW6fUVzwwhbBc3PArN4hjHzPHbjt5vC89UIVCjMyVb97UDGThOvqkOIjP3TIFFCeLSBd6OVxhIeXzO9s0/iXRX/JsDirF1mueBQl1H9m3D+R4K1kU8=;7:fgGDwDoYT8XMVXTeJO6oJUEJTpUY/gtloymmNigMdP+l2QBBmDzL8k01XYGxIbZyK79s0PE9mR0KdjKbif5Q03WA7kv+tIMyNxHDEH7Vyr8uzjaUouygxrsIjA65Tz/HPNZZ8TF4nCLIl9/AwfMWh3HW+7BxUYgC0X5P0H4K3UoepLiRjln4QVm8Q58S/TJEBcYgMKddSt7Bgyxsq4/1z7VoG21OjTXFkd6DXD+t/rnuJ9yJeZotGExrRvVDh1tX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:14:44.1678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d42d3d-a96a-453a-3d7d-08d5f7c9e4e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:36:03AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 11:54:35AM -0600, Jason Gunthorpe wrote:
> 
> > What about more like this?
> > 
> >           check_shift_overflow(a, s, d) ({
> 
> Should that not be: check_shl_overflow() ? Just 'shift' lacks a
> direction.

Yes, that makes sense.

> > 	      // Shift is always performed on the machine's largest unsigned
> >               u64 _a = a;
> > 	      typeof(s) _s = s;
> >               typeof(d) _d = d;
> > 
> > 	      // Make s safe against UB
> > 	      unsigned int _to_shift = _s >= 0 && _s < 8*sizeof(*d) : _s ? 0;
> 
> Should we not do a gcc-plugin or something that fixes that particular
> UB? Shift acting all retarded like that is just annoying. I feel we
> should eliminate UBs from the language where possible, like
> -fno-strict-overflow mandates 2s complement.

No idea, if someone does this they can remove the above overhead..

> >               *_d = (_a << _to_shift);
> > 
> > 	       // s is malformed
> >               (_to_shift != _s ||
> 
> Not strictly an overflow though, just not expected behaviour.

'overflow' here means the math didn't work, ie
   C = A << B
has a C that does not match A << B done on infinite precision. It is
not limited to checking overflow.

> > 	       // d is a signed type and became negative
> > 	       *_d < 0 ||
> 
> Only a problem if it wasn't negative to start out with.

> > 	       // a is a signed type and was negative
> > 	       _a < 0 ||
>
> Why would that be a problem? You can shift left negative values just
> fine. The only problem is when you run out of sign bits.

These are both a problem because of how the macro is setup, nobody had
an idea how to make this work with different types and allow for
negatives to work properly.

You could define this, but since there is no usecase..

> > 	       // Not invertable means a was truncated during shifting
> > 	       (*_d >> _to_shift) != a))
> >           })
> 
> And I'm not exactly seeing the use case for this macro. What's the point
> of a shift-left if you cannot truncate bits. I suppose it's in the name
> _overflow, but still.

It is basically a specialized case of check_mul_overflow where the
multiply is known to be a power of 2.

Jason
