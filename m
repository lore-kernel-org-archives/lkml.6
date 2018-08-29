Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC85F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="A25QUA4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC85F2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeH2Vz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:55:58 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:47168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbeH2Vz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go2rqPbkbxmKPGN+sE7/ypo8eWu8AoFpF9F5icLtB8c=;
 b=A25QUA4bSC1fq3wGmqu4eT9GU7BXgKg0f8OHuzzXRo+dl6o38/7wQI/Dvogd2B+dCzO2t7ahHYRZqXiBc/DqfiTsZPPcrVmAh20MLmZtm+BYNCwqekfAzYYvJMt/NGr0urBbE6MXQDES0W0bxDTe1ghuLwcJB3Tq2hlUhKVtwzk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 29 Aug 2018 17:57:51 +0000
Date:   Wed, 29 Aug 2018 10:57:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Philippe Reynes <philippe.reynes@softathome.com>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix computation on entry point
Message-ID: <20180829175747.bo4l36aptncduyuc@pburton-laptop>
References: <1535471570-19033-1-git-send-email-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535471570-19033-1-git-send-email-philippe.reynes@softathome.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR1001CA0011.namprd10.prod.outlook.com
 (2603:10b6:405:28::24) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91512ba1-c1b1-41f7-8519-08d60dd8f087
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:6OxTkkQz9w1i8X5is01AA47yOUnu+QtGcBgcjPTFo1Zw7vsAANHZwQHmmudQgV89lTna8cBUoPaJAjMEMVNkwZTOPgb45Qv+jEf7n9xM98gPioLIW8v64PfPiM26TMmjffFbHXEgVSrNXtOMqVfSYVnTrsrnzTOJ42gnUfwY6nKcNfYh7B7zGJLIHEC9tK5YHCGj9mfuQ7MBU8kfDmKBK/DdSRFNV9fjeidqyIqNDKkbt70IQ821fJF1VmhplO11;25:5KYx1vnbcQ3GtXZkcs5n7sDUmfREemBBWkPKGyCSk7QcrmiQDnhVdOui6ZN8CZW6lSP/kOHYLO8LRtv1v5DwYNVQBYl5oliYYfOKl4xWTEJS4yOosaQuFHpgn5pAYLw/LQLbODXjhMPDoXJ9L5B5oOW7a17pNTc55dymN+82ssBK2XXDFulVhxx+jIGdsEOdDcm03s8yTjOm5+7ldzJBvlRUuGEgnQ77jQDi2a3aML4MPnr+TeJkR3lVhXCF0GEi2r53B4RmYDrqJIeKQWLqjv8PlPB+z9elYsD8JdELMUIcPfM0z8dmSG1cWdEK6evT/o/Z1nHBK8pnkAb4R8gVvQ==;31:VHo2STxQmWF/z6+IxxVJ8jWtB66x1mlCEaZKfKCxe8YBhR2HAvvHFMSPTa9fwK+keRhQ4wr6uZVS7y1HHf0cLThs2op6R5JlOicyurxHi/ES8gJf59kRbLWA8spMcnbRqU/hLXU5xeVVPi+VeJ2gRjEHMBvrW3tIGoTuVbG+PK08cE0vdyCiPV2p7jpafeYrs7y9iG9OWpAB+XKF4rfn1FWo7+LH6TBa76ZAQA7W//Q=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:J/wTHQJGbPh1gzwPE7H/74kedc68Iv+7WMTKu8a6wWP21ApJi5qWegG+N/tfRRbGoZiMk+20rRaCSORLG6Vr7w4+zDzpI76Lfqrz15g0MlEvHrhDmem72UYBbuuU9c7ujSXrDy6JwYcX2iHZFYfdsgjN0zLa+RHwppUJDH//bW5SBn+gJd36K9QTXK9Wdb2NmzPRbWkgJu/4bW0S5LyJBTBYtXplEaJE0KyWsdpANVxh3qwpIkcWlV0ulSE3ckme;4:VKe19i4dDHEkNAPBcobWGk4SoCYG1bnyQL0tAq4uPdZ2gamQHkL2qJeh+aGE6Vu/UxmYVadaRScXnuS1+BcR1z79kyEqwpZ1XWxl8dyBOmzFZDjNnITMgp/9C/X8+bOt1uOuPgZafaWRznaWi+aUge7IsY2Nh8mwqTR/N5P4KeNhnYr2VeOk3MM2wAR0y2KpsMpUcOik3tgWraa7fNJ83BlGcE9lKc5Tn5M0kczfAMPDH6cNuwY/wx0INwUKJ7Rdr6KMKStrxT51s/gjtK7H1A==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934DC034B4C55AEEAEC3EB6C1090@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(366004)(39850400004)(346002)(376002)(396003)(199004)(189003)(54094003)(8676002)(81166006)(44832011)(9686003)(33896004)(305945005)(446003)(316002)(11346002)(25786009)(4326008)(6246003)(39060400002)(42882007)(956004)(476003)(486006)(478600001)(6496006)(52116002)(76176011)(6486002)(1076002)(8936002)(81156014)(7736002)(3846002)(6116002)(58126008)(229853002)(53936002)(76506005)(97736004)(26005)(6916009)(47776003)(106356001)(105586002)(68736007)(5660300001)(33716001)(66066001)(50466002)(2906002)(2870700001)(16526019)(386003)(23756003)(186003)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BYAPR08MB4934;23:xKqwTyN/H1gx7RD0r+i9g72zxP2fmcZoBFtYyct?=
 =?iso-8859-1?Q?MEHJEWMv+vG0EK9jBaEUYv1hGN0Qvkn2MBAe2oCqvHJuHM0g/Tr/r7EriH?=
 =?iso-8859-1?Q?/XGgTqyDhY4pRJWrIro3FAAaI4JZLDcbkxkN8SLW+ybHXTBXdv9d/iX2yw?=
 =?iso-8859-1?Q?m/oL2VDWj/YxEtmebOfYBqmdJYIJX8WKP7ce4ouU3fgQ8jTgsJpB/9mEef?=
 =?iso-8859-1?Q?NEO61Nz5gqIjknbufmcZj5Co4t+olgDf9c7w8MZWo4Jp6hKnL//QDDCrpe?=
 =?iso-8859-1?Q?HSkas4Kw5J1dc/sxlZwOc0N3DPIWbKQcFr08DhsdIBlevxmKcZYhy670Si?=
 =?iso-8859-1?Q?EUoWHvU5R+jmCc0OIg2aouAHWR6VX7Ff/bWHumIeWLAq/Xgi/sSTViE7+m?=
 =?iso-8859-1?Q?vQI8KDluwvYai528Txdv4pLX+D5Az7R7jDPaGijEq7ju9jta08r9AHGNNI?=
 =?iso-8859-1?Q?XbiaKPbzPz/wdlXo3C+Hu99LhViAFBNyGMlfZk4pdbNrQsy7b6u2se93ck?=
 =?iso-8859-1?Q?Mc4xCx9VxFEvICrnbVd8VMBgIKzeF4Aj5XNWHPkp8mFVm3Tz0Zt8qy9Qhl?=
 =?iso-8859-1?Q?ra3eGgw7ZHKZUMuACbkRI17RYBqDeC8HJAF+lZABB+6PjSQEen4K8W1Aw+?=
 =?iso-8859-1?Q?XegktN/xCkvN7JlYXvv3dNoHmRpBEWiC5Jir2ncdqbUrbfWFgn7UhkoTNF?=
 =?iso-8859-1?Q?593h63mTxMl2sBB+HMBcRVQ7YiThcXLc27rbvcSl/v4+wgNa/W9W5nbL7f?=
 =?iso-8859-1?Q?2jJjgu4+DIyyszCd5WPVRB1cwiRWdRAvXqJtEAwyKIf8OaJCUSY47C02hk?=
 =?iso-8859-1?Q?C9335mtv79GfWRHIpBC0aR87Djqe++ELqh65jjzb5aA/hF9I6d1NcxBpjR?=
 =?iso-8859-1?Q?nMz/lq7F5ifz6aFw6eIg3L7nB1MfrCFFz0wk2IcBaW6AmkcCKK/s8DP3+3?=
 =?iso-8859-1?Q?Lv4p6RNUy+CkviXzCIVMu22FRqI4kFqWfVG+483cKH+EOo5SYbgLHmLLEL?=
 =?iso-8859-1?Q?0F+joOZeyo8/nIv2Br4oxaoH9aU3rWBB2d/FAvy2xEdjYomzM4hmSfUkqa?=
 =?iso-8859-1?Q?Z3Dtn7wSTPjB1X5WEywRhSLcOEdlP7bu7b6yt/5i9wSxbQXj8+ErwW8V6k?=
 =?iso-8859-1?Q?M450UvJqrlNy8zyM/4LImpiTTh5PxM8zOSLwbmjrXtaYZbBet6zvMtu9Zo?=
 =?iso-8859-1?Q?SWA4t1NbEOa30fR5HHXkFS/VjjXq7EevUJtH9s/FRFx7KCmRLKj5E/R/fO?=
 =?iso-8859-1?Q?rqFDmxTRt80C9vd8FkxjfOv7K765n4ulv4HacKEJbltYUQcoCmqFJgnEFe?=
 =?iso-8859-1?Q?RO/mD6u78eTWjn7D3MUNbZyLsT+p6R2vyhpWa9qb46Hza+U3eOumxQvfk5?=
 =?iso-8859-1?Q?GDdgPFn5n/FpEAm3SEDfPp5d0VkCL?=
X-Microsoft-Antispam-Message-Info: 4UP0IPrN+2XgFym4X8Hiz7A4E+Ry21+TxXWqM6bhEXEhFEJpvC0XkSfjWfq0XBg+eoeA3suY+8UInR69kf9L1rlcyrswDP0IVbGncfUqE5B2lUjbH11tKhi90q6Rx/JR/t2Vd/wHeWGZtSm5Oc4K90KVnJxSWD/zYaipt2T1jZc5ZIhLcQYTDjgsTIFglwcT/5ok2qPlHSPZDyot/eR6kBUmIhEIj2PymWzOI/RVaE0eRzzMqTYewhqv5tX+rV17AhMbUWIQ3cZzU1YQl9mQ/3ymtoNRbJUh3enFqSBHDAwTsK8FatfpchtS7JwfeqHNACGoVsI+H7wiL3/78OhBSQOtGMFP1cOvOOWUyoFDI/M=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:Jo51ZKy5gQl8K2sN05kvDVhBWLrJOBNk9Dg0n4k8o9I9NQfCmgTgjDIR2YCowupaVYKPO2ygffgsATdZK4ejylLEH2DxKb+OY+TMaCi+Tu4zqJ5gLO/OD3F8a8idqISHUBZ2putdnCQlLEFjihRPoR77/HcmJdqRhH+HKsfKqR14nVluOJKQKDTRFmadBwls+/SlEjZuoEU/BhAuI95BBeLPCk8QXwAZS2AM1LiMjOVgmR5vqQtmWL3VR0bKFeJnOaXBG1tcSVKdTSxQFbPZ6hD/+ZwtW84R0K775dX3SwVthgN17iQBiFHs6jE7JN64OBMhWGAElrDE2t+Pf6Jd3SH3o9+IY7wPDn+33qHUtSh2ZjvohlS+Jas3YoGsftEwzj83Q/3kjL4xPbgNo89KCznJKdW9WkbSyldujg3fF1dv8gEQEmjFvctYlJXwKXVEyZFvRptgvv1/ebl50JifOA==;5:BWCD1egZWI91KRM0aIBq1L/EeJlVZAquDby/J3VdZYHcBdnH7bURd4IDNpuHBxgDUfMw1wL+9Scaa7kn+SqJbTFQKKVBDYVGRv+vRSzdU3+voFMQRGEAgLJJV7wGMWRvUQsQjFXmFFbQMI+QDr4e95NpKrPVNXjXXi2ICYT6bOw=;7:L2+gKkDZQqIQqyiYb+a0kQgV/+NPAW3pn+vSAtn07+WzJECDXQ0eA6WgEZYfx+at/sO142BozUf9TcRir7A7XxEoOf30VvU2iZ66Zg+B5D9qhkAmiUEHv+3yqF0POrD5P0nyOnIJO3thISkHUqHmsw+YAKvXiMkapk319ATjdJ+BIk6atS+D1laXiB3nxhWU8IMTqWax+nTqjf6tcwqWSbacoppnrTL/xPYpNWGReu/oUzbUQ0kVuSE53DzBMP7N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 17:57:51.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91512ba1-c1b1-41f7-8519-08d60dd8f087
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Tue, Aug 28, 2018 at 05:52:50PM +0200, Philippe Reynes wrote:
> Since commit 27c524d17430 ("MIPS: Use the entry point from the ELF
> file header"), the kernel entry point is computed with a grep on
> "start address" on the output of objdump. It works fine when the
> default language is english but it may fail on other language (for
> example in French, the grep should be done on "adresse de départ").

D'oh!

> To fix this computation on most machine, I propose to force the
> language to english with "LC_ALL=C".

I wonder if it's time to bite the bullet & just write a little custom
program to do what we need, rather than trying to wrangle standard tools
that *almost* do what we need but not quite... Patch incoming.

Thanks,
    Paul
