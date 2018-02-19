Return-Path: <tommi.t.rantala@nokia.com>
X-Google-Smtp-Source: AH8x226WVVTMPX9FdntTyLHBsMhCf6GX8Exxcc5N+KJJki1ZY1wkyg2ySWIbBXiH7DwIAKsyamvD
ARC-Seal: i=1; a=rsa-sha256; t=1519046806; cv=none;
        d=google.com; s=arc-20160816;
        b=bsk1eF+2Sf5mO1IL9zrduTPUOfeGZRMsHeWZf5s0CfJr2lbXoC2JOjaIdsOiqSoqSo
         YJ2ax4LVgFFhWxUOP763J7ASaSrM6Phiq9eUEKcwp3QMME5BdY0QUOgpCDfCxHrBM9IO
         OI9tcFPI1bHX/NXOJaJfog8P0O+Hk8qYYRaqoCz6nw5b3xP3JTEdoeGO1VdnobzVPEcg
         3cQUTC5qd50BLKJCMVBQo9NA5sMJVvqlbOodjPxQSbV9jKkU1gX9w+iu4e0XZhzW+PAg
         aPEjwzs8zG1/8CHL9rAHiKBjQmBeExKxPT/RdrOPaL9AgACFdD63HoLP1PBi+0CxtcKM
         LhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:cc:to:subject:from:dkim-signature
         :arc-authentication-results;
        bh=Q6GpJ6VLOLAIHPixdJuwIMVnwn6gfljXACR5AXJCmLA=;
        b=loIrtAj/qxitfqww7vsKykKxYNu8DOjHm8pRrLxCaleOF7Q/F1i8eWK7PeOdJc4o3A
         6baYA6zF5ekuqW81+ET+/oy9xZuJKRLJKGgM5hRvnb6va3RJZsdFUOvSNNoNJacYDGcP
         7NuKFpc5D5IETkXCkKZz9bkaDULuqUtys7ayRdhVsTG+NpcWhoQ4biauAQUMJxD1d4WX
         h+vQh3ZNymgTpw/YTWqpC4xKNhF7WeecgIhUWauVunqSOwAgoeh6hhpjbdW8qnkUF6l3
         vDadTtes1rLlK/eZU6fYa42/CYGKlevXG/YYWIT+mZePJux1JmFbzlrdVFpvRRUcmszH
         xKnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=c++gbC/n;
       spf=pass (google.com: domain of tommi.t.rantala@nokia.com designates 104.47.0.131 as permitted sender) smtp.mailfrom=tommi.t.rantala@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=c++gbC/n;
       spf=pass (google.com: domain of tommi.t.rantala@nokia.com designates 104.47.0.131 as permitted sender) smtp.mailfrom=tommi.t.rantala@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: backporting "ext4: inplace xattr block update fails to deduplicate
 blocks" to LTS kernels?
To: Tahsin Erdogan <tahsin@google.com>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <f3db4b3f-9cb6-c96c-8d31-f2a5f8b4082c@nokia.com>
Date: Mon, 19 Feb 2018 15:26:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.176]
X-ClientProxiedBy: HE1PR09CA0056.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::24) To AM4PR07MB1313.eurprd07.prod.outlook.com
 (2a01:111:e400:59ec::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c20d58-acec-4273-8f1c-08d5779c6af5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:AM4PR07MB1313;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1313;3:pQ0W9zTTSzV6aWxR1r9URR8LGR4PvyGqZgMC4GWDBiwPDteWnfGdk5nYhvGa6nweWGPFKH2qAY0RWarRV6m6yHyPb9bObuIzzeJ5klgngA+rDgmfO4t4tJgEn1RJeO7HSd14EAu1vx8DjWWulPeUr8nmhFG2ji78pmEiTnQwwS14Fpo8UA4fYqQyYRaluqV8G+uPn7akOkn48+/9GuMwHG8u6z6bnShreHXuqjXKH6/mgfKNklbspE7kKoSQZMjv;25:FplRIvMa4WH+td268bDxiYgDNyGubOC1WGGoExbQ7f/huy8L48niPxtzhZ4+SuotScuXSfNPsZtxg96L/ZhjGyWEktfddYFTs5q4g9YhFf82oHk82r8GFfo15i5t+ZYxjzYFdQOYqVVtSa/21N+BR9lNxVpEhcMy9zikA32rZZ8x2EyeKqZBz3MEB2Em1x8V8M65P3bNMEalk86obMCSSu0cuyHE8ygrzzb4fAY3n8G9WFZbfyB7eBzIcFWnrtQZqQofr8pGsR3rylxrK8yPSjwU/XwiEK1MB2Pbbp7FHZnLQORbGg7woQBINVeF40O3/lODtkbwOSdLjvPO45sbiw==;31:Z/PGL/GgJTdI5NXx0UKekXlvhsWm203ftXCNSqz/XiV8HBd58ZckYfgP5/CK+DqTdZwJuh+N7/teIMc8kwlFBQGPYunuk0A9w2RQrRWXvhVAVK9LF1rjEnrB3e5U7eglhD/woDwymoihK6Xw9wGRoicfG5A2q7BdQjWTIn//8gzIkw7FnM6ltBYditRsqaNqIFZEhTvtALKmDKeq1VWjUOY0XfnIRz35PkNWmJZXveg=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1313:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1313;20:EjWrBP4NF3py7Dz/+Fns+kHNS1SPHrNU7fYuTeBJwxk7CuGfHW4KYWpIwAKC9esmqhre3OGNuwSfyn2ZdgrajqWnfVxH03jgK90ck4sKeGlMpkFupN6449W0oJ4+0jr8TKTfnrI9d6EumPKrOVNbOEbNHJbtQim25QWfWBJy9QZq0dustwc1VZUS2DRk9yBylSZ+5/LMIdHIJTv/FJ9U2IRuU7yYP7PNhl/tbj4q0JWDpl5y00W5qAQmBlMxeNnw+OuyqSJo2c21WY9Dv965IFzZxViuUJFKKj3B7jeHwByHPkuVEgua5a4XY36mvyln9jFNjZYk3PGSFi3QEN+sx7VGUi6v1DUhbVWLIJDRW2RqSTGiKDcBXnnUKji2V0K08C4YsiiTEFrYEVmxmJ/CdXPA9mB1KGnpGaJYqG6EEi+wbZbncg3cW+kbDew2f8p6b3tSDj8bAy8Opodwj1XHveacpbXMckAqrRWwvjFp1UjW3dtZVJsx2wN5y+etRrz1;4:yt1qnUgJ0l+6eYAnqzFI1RHKXJD9uGDRSo0y6xdqd2KN73DmuutO+pn/i9gRHiPONGM/H+gD91dCaZiTC5CAv5G6abO2xD/VqWTujwEyFezX5bNcHHC+a7ts+B3cLnZSjB8RVjAbGgEOFfQcq20qbI4QWG1I+HM8bWDYHwElHh6GMwdtpUCuEE7nDOm24ZCukUiGTKs4kN9q3qnSkb42G6JebpJnMxNADWjqX5AIjcj56peSRiavkc7WwS7IN74wl4XMPnKE8zU+IXO3N6M/wkdQTKtEZGPOQ2fhSsTO1aI8I2dunQo9BTbHNlzVuw3OtqnqJIlAoFUsMR9YlH766Dmdg06YFmLU8RK6//RYfgE=
X-Microsoft-Antispam-PRVS: <AM4PR07MB1313D00CD4B6314C1D6F3EC5B4C80@AM4PR07MB1313.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(11241501184)(806099)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM4PR07MB1313;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1313;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(189003)(199004)(4326008)(66066001)(65956001)(68736007)(7736002)(26005)(77096007)(6346003)(47776003)(2906002)(25786009)(106356001)(6486002)(15650500001)(105586002)(23676004)(2486003)(16526019)(52116002)(52146003)(36756003)(186003)(6116002)(3846002)(5660300001)(2171002)(8936002)(50466002)(230700001)(386003)(83506002)(478600001)(6666003)(316002)(65826007)(97736004)(16576012)(58126008)(81166006)(81156014)(110136005)(53936002)(64126003)(305945005)(65806001)(8676002)(31696002)(54906003)(59450400001)(31686004)(67846002)(86362001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1313;H:[10.145.143.144];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3TUIxMzEzOzIzOjh1UnFySzFGWWxiZE1FY0RHaDBhS2RGd1BW?=
 =?utf-8?B?bEVQV29NSjZCVEl5MzhPWnM0U2wwd0NYdnFYZlE0eUNyTklmb0ptZ3NpOGlD?=
 =?utf-8?B?WXNYTFVxVG9tYjkwNUpaN3lESDlxYzdhRnJhbnV5MWJtazQrODVMMFlkTEhl?=
 =?utf-8?B?TWFPaytBZ0ZDRlByVkY2WFhzR0dwcTlkNEtEeDdOSmRaUW9qWVEwK0xDRSs1?=
 =?utf-8?B?djJVVHNlR0Q5emxacHA1SjdpZlh2SVdROTBLS3VLV1RoSW1EUXFqZXNnSFdr?=
 =?utf-8?B?dEtDZWFJTWdiNHNYakdxVnhqelNaRWp5NytsejFZb0ZlK1F6ZUlLc0FpeEI2?=
 =?utf-8?B?ZFUrSEQrMUx6SW0zenVGSy81VDNnbm8xQzZmdmE5R25xeXJjWDFvYitlWkNi?=
 =?utf-8?B?eTliU25MKzBaUFR1STY5WWNrZFBFUUdQK3Z0azM4VXhIb3NvejRnQ0pLLzFh?=
 =?utf-8?B?TnJFZktnRG9ISnQ4VndQbnJESG0vQXhxaE1CQjM1MWlvZDh0L2EvZVUxSTdl?=
 =?utf-8?B?RTFaTnBXaDNIOUVpQlNjYWFRdEVTU0VxUVVEZXlXUE03UzBCZWRwUVpRdWxa?=
 =?utf-8?B?M0RraFdHTTRrK2k1dENWZGxEcHlYNHR4NXArRVBMZW5rdnlHYVZ3RnZVVGd2?=
 =?utf-8?B?aGg4ZVc5RmR3ZnN3TmNNd2FUUFJCaU5ibmc4MXZRNGoxS3FreC9vMTQ2U2hG?=
 =?utf-8?B?bzZXaUg5RGt0bTA2V2pZclpob2R6YXdDaTYremQ3b0YvaVhKRmUzNjBZcVZs?=
 =?utf-8?B?N1RUb3dZMi94Zk1lRVBjallwUG50dGNTZnBHOWRZQTVDVDJ2d3FScnJiVUZ6?=
 =?utf-8?B?eDFXcEdqQ0xsNU83c1ZuMjVMSm85VmNpbm5QT2o5UVVqVitpbWpoRjI0NHlM?=
 =?utf-8?B?S1BoT2pUVnVJSDBxQTdvYmRiSndhbnJSVDNINW9QbVdaZ25XVDFxbHVxajJi?=
 =?utf-8?B?d1BTc3oyaVRNZ2tlNUlVWHdTQlo4dldJZmY4RHh3THJZOXJTWWdFRjBrek91?=
 =?utf-8?B?S245ZEJpNmt4VEphc25yRjg4UmdEZC9kUkgya0lSRnlrcUpuK2RRNkQrM0JJ?=
 =?utf-8?B?d2s3VXpMcFlZT1FZQjRZZmVxNGdsalFqME9PNDNReGdvSkdabFRlWkQ0eS9l?=
 =?utf-8?B?bitweUcrZ216cjhBT1d0MlI2V0huODgvQ3VBeXJtbklhMldHK1pFUEFrTmdZ?=
 =?utf-8?B?SU8xREtHbGtWZWtBb1FycktSMEVjcWZlSW16VEQveVMySE5KZkxFZGRMVVFn?=
 =?utf-8?B?VlpLZVJGRXF1UEhGZ000SVUyY3poazhHMmhnUVlLc3RrekliWDFVZGNrU3FF?=
 =?utf-8?B?Wk1DTHNtSzRubWhXQW5KQUF5S3g3U2ErRm9yNlV3ZlVUQkZtc3JMZGlmSGg3?=
 =?utf-8?B?dnB0RHJ4L1JEdWlEZGE4UXpQQzBOeVVyM0RrZHFuYk54cU0wN1FDRkh2ZW01?=
 =?utf-8?B?QUxIdXpTUDFHbFFEeTV0QlFzT1JpcnZ6ZUVMYkZ3YmkxbTJMam5KeElSZWxq?=
 =?utf-8?B?b1M2S296ZzNZZVMrQ0ovZ3J5MS9pbHZDeC80cFc2RnFFTnZrNk9xa1JtVjYv?=
 =?utf-8?B?SG13RndiQTIyWm5mT2czQUFaWEJWLzkvMlp4SXhKdmd2SDlFSGdQRWZkR0Uw?=
 =?utf-8?B?RGNUeGUyK1I3QWZrekU0ME5QTWs5TUJXQ1pqMzNBaWFzR09id1hyZnpKVkpE?=
 =?utf-8?B?U1REVlQzTWJJdiswV0pQNkI2OFJrd2ZLem1xbUh1WW5DM0M3M1Q1VGZVYlZJ?=
 =?utf-8?B?Sll6eEN3TzFuSTI0VkxUbmVrd3dHRnhFMWxQVzhyMjlGcDlCZXQ0UHNtaGJz?=
 =?utf-8?B?eDM0WlNHeFJZZHlwYTQzQk82YTJ4WGRGK3BMS1RncjBROVhWQ1d0UGRYc2ky?=
 =?utf-8?Q?eY+t5KHUnGZCsoGuzTGC6NPvSC1seH9d?=
X-Microsoft-Antispam-Message-Info: rNUlC+DEvTg73nHjyNvPdm9LggVTq5+lTtl7Hkjzr422S36xvBrb6NfewrstnSkDtu/idpejO7xv51lCvd/6nQ==
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1313;6:eimqa+04Ovmae4dHnqYJsCO2MfAunp5RiNp8z+1TZjYat9r29MDUT2M8EYRFzW14lfswEi/Dso9ChXlfiTFzthv96UP5gJn+nIIKHi3CSKsyxNs3U/jDQXSNH0QQE0iCUr3PLv31kfu/CfvT4aGCudAnWjrvnkyRs0/+UQ9EoQ6NzzOq//4sBu+Owj7hOBwSoaAJD1VvzVmUSPHReAXvEamAmre+AA2SiwlI0dd4EqMPPcnXNQo+163HJRzINhUiDpeQZCTJj052usKiVedzLZR01cgBDa7UqeH1KbOMAxyp7wiZdpa7Hwvt88kt2SUTIpP3h5HOWv9UaT7xfy1C3MWt74bvKHAp12ALg+SKlTE=;5:Tvi4rrIC8PfvE50UqwIJZ5Ru1Qv5YM24DAOSQU/1qS047M1f+2XqgWp7zG2HX4+G93A94pIslS8K7PfVrpGO/p6fK8ipWvt8kyAiUuqKhJmrHhoANERJxniriQ9xBZXBkF/5Z/42p9RrHEC/BNHEB+tG37Rdjs1Jxs4H8iGOUVI=;24:WJrKLhey4+RZPjB5oNX2d2ndZAN7O4y7CNvrUrba67AfUg4dAJooj/jGa9G95EEx4ZMBZ8caiW0SxhWWt7X1BRUYVqXmKVpNZRaBXb8PPto=;7:GSRMrG1hIMD/feCQrZwRZHmVmTrEMyRxz3rALjJCFtBpizDf6sTm5E5uQL4cUhR+eNweWfus7PW+vOGFZuBLssrQci9sx+0p/7u1tgGUbWcR18SADK6x7SFwUwyd9LH89KHQJbNwBthDN1pKSej2fAnfIcgCJndiprmYdSJw6SJsFC/7alnPGiPoRJNteVLSItBHI8xe7tkG1LOzASB+LzzFhbKp49oONZstXElc9FivtJoAWrP9CFJg4vYgD75n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 13:26:42.2143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c20d58-acec-4273-8f1c-08d5779c6af5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1313
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592836024079579824?=
X-GMAIL-MSGID: =?utf-8?q?1592836024079579824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

4.9 (and earlier) LTS kernels are missing this:

commit ec00022030da5761518476096626338bd67df57a
Author: Tahsin Erdogan <tahsin@google.com>
Date:   Sat Aug 5 22:41:42 2017 -0400

     ext4: inplace xattr block update fails to deduplicate blocks


OK to backport it?
I tested it briefly in 4.9, seems to work.

One of our testers noticed a glusterfs performance regression when going 
from 4.4 to 4.9, caused by the duplicated blocks.

In I understand everything correctly, in 4.4 mbcache uses the block 
number in the hash table bucket calculation, and the hash table is 
populated quite evenly even if there are duplicates. So the mbcache is fast.

But in later kernels mbcache puts all the duplicate entries into a 
single bucket. As the entries are stored in one big linked list, this 
obviously makes the mbcache slow.


I tested this in 4.9 (which still has the ext4_xattr_rehash() call that 
got eliminated in commit "ext4: eliminate xattr entry e_hash 
recalculation for removes"):


diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 3eeed8f0aa06..3fadfabcac39 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -837,8 +837,6 @@ ext4_xattr_block_set(handle_t *handle, struct inode 
*inode,
                                 if (!IS_LAST_ENTRY(s->first))
                                         ext4_xattr_rehash(header(s->base),
                                                           s->here);
-                               ext4_xattr_cache_insert(ext4_mb_cache,
-                                       bs->bh);
                         }
                         ext4_xattr_block_csum_set(inode, bs->bh);
                         unlock_buffer(bs->bh);
@@ -959,6 +957,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode 
*inode,
                 } else if (bs->bh && s->base == bs->bh->b_data) {
                         /* We were modifying this block in-place. */
                         ea_bdebug(bs->bh, "keeping this block");
+                       ext4_xattr_cache_insert(ext4_mb_cache, bs->bh);
                         new_bh = bs->bh;
                         get_bh(new_bh);
                 } else {



Tommi
