Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91988218FC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bh3tIYe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91988218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403904AbeHGRyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:54:36 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103]:39506
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403889AbeHGRyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpY6Q6iqU9qbYbRcjvh1dP1lXspTE+mMdqm0dAmnulA=;
 b=bh3tIYe7mn/XKikdX7iPR4xUD2MqA8MwCRVFQrCi0LAxqodUptKjcnpU8YTD/krgYhFe0R89zX1jhKF4SvX1px8WzVgWX9neRmYDWxF5yvak4O9oFd/z9mMbiV6yWk8Gik97Ncx0pJngRQjy3usFkpjqa9o2yo9Bxt/SUkQmTI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2032.eurprd08.prod.outlook.com (2603:10a6:800:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 15:39:30 +0000
Subject: [PATCH RFC 10/10] fs: Use unregister_shrinker_delayed_{initiate,
 finalize} for super_block shrinker
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:39:27 +0300
Message-ID: <153365636747.19074.12610817307548583381.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0016.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::26)
 To VI1PR0801MB2032.eurprd08.prod.outlook.com (2603:10a6:800:8b::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a61e6cb-96d1-4380-78ae-08d5fc7bfba6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2032;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;3:4wpi8thsO3hOYWfZpFCW84iglbdEDdwzm1tkrdT5jhMCXzH7pqBkjpx9FUdCSM7wdCwAMTPpwOVmD5mrGSDQnjY8YzrTu2eclUc32KAMH5I3WXW8tnqz+krii18pMuX9QTQY3UUaR+0InJce9bqGlEVMIHxlSxIiq9OV+BgF9u/GqAKhuAUTG6YVpF2PCeWjdSl3+h9y1ku0F043z8mxYDX2FA0xLyK6qrf2kMWX+9AMp3FSwkh8dv/zrORJA4ta;25:30igJ9Zj39XwMENlc/Wr4zBKarlPlL+ki7yBJZ5MpWc4C5K+R+Eyv/b5huuBl68+ZcTHICIyFVvaPmIO96Die4rjAO13Oean7Opntdm0YEdZvwG7Mg0AXvMbcIPY9wOdgPhHkLKNxAzRJrye1+WHRfd1NgAMMGwHoci83Augxc2sZZRGydkK2b3MoHKccQWM0vLl1SIJP/JdONd5z3k3hpR6oHBXwfaiR80SwEZb1oMhTcRJ7UL7Xudpahtu7TroAnQksfEcM0E7brrb2GdaoCTveNWvpXZkzwK2NUWTqtwGPjUh/jiq0vtHtAChfy/pfs5hYyzGYXdD4bpOwERNSg==;31:zD87Tdjqd2LYgqEvopkz01NJpLA0l0YJIj2m4wRdefSVJhoNaBwuukFvKDAIZgKzNgdqNot8C6fov/sni4psZbs/9siLfQ1uCyY/+oNZX3EKA1t4906Gye3ODAa9P4DOfaZOOXmHMvSaN4M8vtAhKlLxLk7Ygu2seVzG8wemR13L/tU7fjAJQjZYkCyu9sbntra62Wfj4D6Fb2G6NtVQrcaDU4U1OeqHgJGHKqbtXQQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2032:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;20:/d/sN/+3ss50XhiEZ0vw2n9cmjK28wcVZjJZ46Vj7m66U68fkvba9HUAQ+dS2EIapV3vwU0Hs5lsPwB87lfURIc5Hcz1umsutZEiPIEIO52GydkQRz9vQr2jhJo5+pMCpHthV1YBne4kgYjVOr3tItXxuK2SRumv5rmarQ9jTV2qK1+TW8VGUXwlWrk1cBA8WUTeR+073nYlzYJG0A/mqQCap/px6liekkM4U3lmJTnnx83+M7uG30J7/4+S3W+wO+/FuGXwoZ+FYMQIuU3LgWthfrz+jhSaINA9kpDvmHxuuP6pfA2GHXWCrlXY4/AQMkXV0j4IyGp7CiDtjybQMtD+Ffygfd7/A9VOa/cxHIDnrY84kJz7jKliRrVcDgX8Q34R7qJElTWvwuAuOolNHTQaGkIKXK8KPy9wLPXYbSYZfDnStcBlKumN160R9anAfYcDorPzfloAG5QFSjgQgvgFH/sh+1nHjiu4M+99P15x9TYUhGLT62BxUxO1exTw;4:QY2iMMUw1DCZlJ6LWfSrn9WrUDOHP9rTwRL9inc9n5MSaaFugn2MHKkmPIH7b2K6ZIt6isLRjRF/idra1X0GUADv9rbF7eGMiR78JQn5FQfXRYTXYd/GS1EFf24JE8wpF8wV4tJx7ZauLSaailJjkzETXR6BNdHpS6GQXQju9s6jQA5dng2ZYTz0yoiDJspFGVOdbGqWwIDCZoaxLkrOqQhAksTX4RYrgERirp3QisXnpjmcjBN9v4Lu4D4V+2g1NOCXLZme7I4M2qpD5zJZpw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB20328522D3FA8FCF064FB9C9CD270@VI1PR0801MB2032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2032;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2032;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(396003)(376002)(136003)(39850400004)(199004)(189003)(106356001)(105586002)(217873002)(956004)(61506002)(14444005)(66066001)(486006)(478600001)(11346002)(446003)(7416002)(39060400002)(7406005)(26005)(186003)(6666003)(86362001)(575784001)(97736004)(230700001)(476003)(5660300001)(16526019)(6116002)(3846002)(53936002)(103116003)(6506007)(68736007)(386003)(305945005)(7696005)(7736002)(76176011)(81156014)(8676002)(81166006)(2486003)(23676004)(9686003)(25786009)(55016002)(47776003)(8936002)(50466002)(316002)(33896004)(58126008)(2906002)(52116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2032;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzI7MjM6QytGNndjcU53alQwNGhlNWlaRVJtdFAr?=
 =?utf-8?B?MTNBN211WlZ6TnloSDNWaGJ4a08xQmZqU2VDakVyNUl3T1NKakdHY2dudHdp?=
 =?utf-8?B?QXBMZ3FWOFRnak5mZ0tDQUFpWWFXWTFraDJ4bmIyNk5yUUdpWllIWFdzU0lX?=
 =?utf-8?B?ZGNUUXFaTmdmZzRUdUVnT29xTms1KzNlc3RBY2xyb3ZBbDFkTjBVQXh5U2lW?=
 =?utf-8?B?ZDBwTnVtc3NYcTE2ZFhESjhPWkpuMGFuTi9FZld3ZXZvQUtQb2JrQTRIZllp?=
 =?utf-8?B?cDNCZ0JGQzFldVFZZXhMZ2tvWXZJQmcwaWJ1aC9kVnpGSHprcWo4ZVNvckha?=
 =?utf-8?B?STJsUFBHSktGNHVIMU03RzNIN1VhUi9jZEx5WlJUNVNpaFhmM1lrYWtzYTgz?=
 =?utf-8?B?ZXFKdFZRR2FoNmpHQnhnb2hmZEpZNS83ZG9jQkxIWnYzT2sxMC9kQjM5ejEz?=
 =?utf-8?B?dFJWZUJacmdlcjUxY2xPdFdsUFNDOTVwTk9NSnJkQVBFNWE0NGQraVdIN29F?=
 =?utf-8?B?bVRRajdZYXFVN0FTcWlaaGhEMDZMMzMyVk95bjBXQ01WT1dvQWZnRXc2Z1JF?=
 =?utf-8?B?dTEzQmRpQ2JSL3ZKRmp4aER6MjY0cGE5T1hhcUUwcGFacVd4YlZNdXo2WGZr?=
 =?utf-8?B?T2pmNnEvbHVVSkZyQmwzRkM3bjRMQmxvNWdIdFpGN1NoNDMyKzd6MUxiYTVK?=
 =?utf-8?B?NDNVYVh3TEpFbDg5MWQ0VUtkK29yclY1a3VDWXIxV09sSjJjMUFjWWIrMUF0?=
 =?utf-8?B?MDY4T0lrM3IvdlNDTEhDYS9Jc2Rtd3FXSVUrMjVpQlBuMlBPRUt0cjlRSG94?=
 =?utf-8?B?aCtOb1BGSmNzTEZ6aE9NU25vdjdaNXhRcEdTOHU0QlRQc3BLa2d3bDFkSVpi?=
 =?utf-8?B?RGVlbFF2a2VKSWNmbnlDRld6UEJESnkwTlE5YW1qYy9td2tZNFJKWHdkeCt0?=
 =?utf-8?B?MDk0RGFBSEh0SFRTbGdiY2FZMzVHb2ZSVTBPNkRRSzdmbFZZWVpaSzV1aDZ6?=
 =?utf-8?B?YzRnQjcyTkcxbWFTdVlMR0dFSGFFcGRUVzNpeWJLU0VuZ0hNQkVycWZrUDY1?=
 =?utf-8?B?MHdFZ3N5YU1DTHJjaldzRitsRnRrT1p5c0ovWEx3YzZ5VnhiOHIva28vaUJa?=
 =?utf-8?B?NmxURitQSUpFWDJDZXhuQWZieTJZMGF4UmRJc09XQVY3aWdjTUFoUDRJcnJ5?=
 =?utf-8?B?aWZ3R3NiNk11TUhRWkEydkJyR0syZXdmYzdycjB1aGx0Y2c4aHRBc0VuSmxo?=
 =?utf-8?B?RDFYaUNXYnVMMnFvK2ZCc0VqOTJTUFROWm1tb1JUN21UZHZDL25zekVaNVQ5?=
 =?utf-8?B?bDZvQ21JSTRPLzJUM0I0emcwN0NwWnhEMytNc3ZVYnYraVlQWm1jaitZaXBI?=
 =?utf-8?B?dHJhSXRGYzVTaXNTbjhveFo0QTBqTkg4QTJ2YllYbnhVREtNd1J3Y2lTRERo?=
 =?utf-8?B?cWFoM2M0WFJLQU9ydHdnMS9GRkhvYTl2cWhDOW5Da1ZzaTFzVWJQc003c1ZM?=
 =?utf-8?B?RUI4c0ZEOXBkMFVTQmlrSW9VNGN0OGV6ZHgzU2h6ZUNDRTFwRE9DdVF1cm1J?=
 =?utf-8?B?ZTBWSDQzcGV6RnJaK1I0eW81Vys2RTByOExTcWYzbllMVGkwQ1RtNlhUSDB3?=
 =?utf-8?B?NDFkQmZ1QXRVSktBd1BvTHAwYlRraFhZTEoxTDRDYUV1SjhIZ051RDJnQkZZ?=
 =?utf-8?B?cFJINXJ2dXhjQ3JXb0lsckpsWU1lWGIwS3V1b2k5QWd4aXRsRGlhdDZQNTM5?=
 =?utf-8?B?RVRYNUszNk1jZEFhcXhORC9JSnBNOWpMSzNVSUxEVWtEaFd3N0pjTzltRnp2?=
 =?utf-8?B?b0NUNUNuSkhQMG5LN290czRxZXo1aUwyQTQ3OFA2SFgxc0FEQT09?=
X-Microsoft-Antispam-Message-Info: 6ZsEJakeWojrEK24NFVcRShq6jgoJDGorlfWScagdU5vLhVub3wNmibCMXAfBnUuUfvzqAznDI5VuYcVOB2wAO8Tj0pUn/jpbvO1eS60nAoJHk06kxPZ5H/XRfYsArYq/V5H5kIIHql5/TcT3KvJLd6tqh+nmkBE6MdoYXvophqGLbw9X6lT/Q/Ajb4Yp/YEZwztH4Pd/IJa1p7y2kugtt3tDIG68it108yDs3xhKi3t5agyNwZ+suIT4whqbUy5MS1DmdrAzrbi/0mGOYLDwAGb1/cR3mtJh9MY6JYfUAmCu8RUiqIVk+8ThfMYRO7qU46RKXm0h0R27PsNOmBy77blehZi4P1oWE/ML4/5cdo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;6:d+atE1RLcy5R/oMkGNNLEuxXrpM4mRtycjxOzpGRj5p2DDdEFCJsynesVCIhxDvWd46wegwurwmR19ooGhLvAAPQ/bNu0HSvPE5PY2QEEC935XtXAN7JvR7cx2RbARcuFnLFkOM6/vZyj4nOcWpkxh7/SABE7tSV+ZP+rv9W7vCvGig6aB5530yykl7vIMq1A7lTqS6/5Cdg25yjRbjrDd2OG/btyZgK6jzqtQbBh4lxqOBtmhtfbXOEWqTiHBq6sGt9KWaY98IcT5+PAX/JzQEbRqlfj6iGL9ewmsLfpaTNyA8/tE7iw81OLtk8HJd7Ix4sOkKhc1WX5ob2l6wJlOsKybn9lTeJ4bMtzpPpwQlDN0TJojufDpGwaiS/My5+j0gJ3y2tfXCXkllPROlCfjOmnQn/82gcaRdNM15XTsuS5LXA83bo6cc5JkMkbH+oojvQEmj3l/bqRCozm3phlg==;5:YfYMhqdkZ3Op8IjW74IHO2d50UhHuqXPGZ4uVwJyQVBJ93IAgLDh0pvfTfpo0EuSf8rdnqzbEjYMhAxjcsJNjS4IM25eZx4egctcLqSLctmRXiyppkHBXdX9H48UJRphAakfHbmVzG3bihCyex+DGhoDvelJeTdqocmZqJSKn90=;7:jmnjxCVhobgFRlAE20T8RgDhCUaDMUMlT8FPI1qmHe7k88XW5AIvRS3aW2s4Rofb3pARVjK26KNUgsB5X5DRqGEA9UEKfTgKilPmUDHESJL1eeRJXpax66izN0zNt6R1yVnu7bA7hCYMCRWHJf6iSmSeuQlvJJXDRF/dvbpQJDOFpVMQTN4P94OB+cHyGEMJHbVy6M08y7hoa+lRnSrId+A2NkMUXD4DmMcYOjkTvOlLtAZfviWIBBGiuxfZ/QuD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;20:umyMl2BNKxz61NYa8ZIs42Emw4BgclTsfxCVNiA/Xh6iaKmJyU6INIkWaf5IHOVd7xF5cjdVv5e//vR7twU8oS7wKKK1EJQlmWUp1dHQovH6eMmwdqBUjYpcNBvnXB12E+tjTN4hazLwxG/rm1SxTmwvW6wIH5pyTWfXep2iOu0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:39:30.9644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a61e6cb-96d1-4380-78ae-08d5fc7bfba6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patches made all the data, which is touched from
super_cache_count(), destroyed from destroy_super_work():
s_dentry_lru, s_inode_lru and super_block::s_fs_info.

super_cache_scan() can't be called after SB_ACTIVE is cleared
in generic_shutdown_super().

So, it safe to move heavy unregister_shrinker_delayed_finalize()
part to delayed work, i.e. it's safe for parallel do_shrink_slab()
to be executed between unregister_shrinker_delayed_initiate() and
destroy_super_work()->unregister_shrinker_delayed_finalize().

This makes the heavy synchronize_srcu() to do not affect on user-visible
unregistration speed (since now it's executed from workqueue).

All further time-critical for unregistration places may be written
in the same conception.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c         |    4 +++-
 include/linux/fs.h |    5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index c60f092538c7..33e829741ec0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -165,6 +165,8 @@ static void destroy_super_work(struct work_struct *work)
 							destroy_work);
 	int i;
 
+	unregister_shrinker_delayed_finalize(&s->s_shrink);
+
 	WARN_ON(list_lru_count(&s->s_dentry_lru));
 	WARN_ON(list_lru_count(&s->s_inode_lru));
 	list_lru_destroy(&s->s_dentry_lru);
@@ -334,7 +336,7 @@ void deactivate_locked_super(struct super_block *s)
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
 		cleancache_invalidate_fs(s);
-		unregister_shrinker(&s->s_shrink);
+		unregister_shrinker_delayed_initiate(&s->s_shrink);
 		fs->kill_sb(s);
 
 		put_filesystem(fs);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 33dfaed0a01a..8a1cd3097eef 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1902,6 +1902,11 @@ struct super_operations {
 	struct dquot **(*get_dquots)(struct inode *);
 #endif
 	int (*bdev_try_to_free_page)(struct super_block*, struct page*, gfp_t);
+	/*
+	 * Shrinker may call these two function on destructing super_block
+	 * till unregister_shrinker_delayed_finalize() has completed
+	 * in destroy_super_work(), and they must care about that.
+	 */
 	long (*nr_cached_objects)(struct super_block *,
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,

