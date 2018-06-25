Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FEFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AEA25ECF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="wnT4j8Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AEA25ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934136AbeFYRMN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:12:13 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:38311
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933846AbeFYRMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=573oPIRjlWVHiRvAEsz2WSVsrTaEWYvUnPiAnlfVC64=;
 b=wnT4j8HtQxKEJUXbZgmAg9T47Tz0VCzQtIL1E+gzPoyjPdNWTX/2I6IojoyAr1JOpKU/CK3ZIoNGdOJr7nM5MgEkBGlxI43JLNKshaJTPYcH8BQvnH+gfYPnt/nEDcWnUOgMSFzcWAwLJwkteI23ErIMw0UQR+dpeYcWh80QiFU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4455.eurprd05.prod.outlook.com (2603:10a6:209:43::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Mon, 25 Jun 2018 17:12:05 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fXV1x-0002zi-C0; Mon, 25 Jun 2018 11:11:57 -0600
Date:   Mon, 25 Jun 2018 11:11:57 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20180625171157.GE5356@mellanox.com>
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4e::17) To AM6PR05MB4455.eurprd05.prod.outlook.com
 (2603:10a6:209:43::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89f1e1fa-19f6-4de2-356a-08d5dabec714
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4455;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;3:Uo3f+fkTSgjruiZm8NdLJk6bLg1Lq9tr0p08okRI7Et0qp0wdmePGcLklDM+bjQ/JI2vsKPniQ+RjnLVTQ5/MlHmoDWSpKgSj74AWscMV3Y74GxHlYfqU0ENYDy+wo77lTMaWos9MMiA8hjxsVpHzpcdHGupiDl5+NhlcIqETcIAjKmutfaagVqT7ias+pIbYu7et72PAUmjxdlTN3oHnkqQZFfISbtrCv8hO5a2h3q2K6Q7qQPDvgXQnunZcAHZ;25:OdFCSRIeVaX1ZKl8FS43ESAMB3ySCa4D/MDa5pv1dKSIWQ5WZYlp7XG9IdGfiDWY6ECCbXlOSCvKNSTg3pAVkTTIYlsKuutuxDLGIgfmhQEsJ71/YQCyLIsvQ1521g0I2/FRZxP/7F820MKgPs3UoG9lOkNifc0Jf+eXKYhnTSXnylMAUgSctseLpXDC/mEW1+hAF4F1xNMzjWjRiZqBXvVyxc3p2IkVtU3l3IKYn+ZwIYiNircPcGaXs9y2yuFvbm26UeU94nUrRhsq/OOmOZheFlK3yjYK1Mox+mhjjHAskG3ZiGutpXrvOPn4OjTpOBK/KzwDncS6qsCYrPKUDA==;31:UFMLyeUJs4nHpSaCVYHjV0y2gUVEeR+bAM/E7lvTGhgEJMaHaN8cWlgvybZ926/pq10/jzDFAWjH7tLYv/kuUX8xWAkPGPPtPcRk784xAaccGWuTxPD4+2/tzqPYJ9ASDl6ZvGKUkiyaGiwinnVB/h7UIA03iiC9AKFwih38xnlHhtkxmfYF42LAt7RIR78Nkxac/sAvCQuDZHCiwBGVaOFONMcMtcIVrvWgjgpfCSA=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4455:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;20:5SkWpfdaX9fLWzChUukSFmHw65M/OQ8KqLoNqEyhX7rlGjKZxz6Pk0I/4Oh/mNuZCzchNcImbKYWZTM3WX0E7eNrYMs4uxe0rPO9sDNtXomtxBfeCMU6Ri5PV0FBfOte1P8x8kX9kCcEOaqWRwOCOjd/K26JMjlHoRMX23iv89p/jGUCDVcqG7ADrKD7LrigWgZzdVEJrtTBfGmjaU6BS4ZJd7SLu/7rC4edz5mUS+s4bTmy8H/RRADI5DouckbrVVMio9CQlYX1BqVApIauiOHWQSyKBfRe8zHuB/BbZf2FhHi230+wWEXNdpq8g1FVhXLLxI/Jc5d9ZQw5HYBO0kxnja4Z/BUdQNLZp0tCqFAZ5SEn84z6Gpd1DKbZD8OddC3uG4kcbv+b4m7kRXTTY12FzGAlNQSIJqF9hyHKTfs+8o/iu78HzAjRc8Hl3b1cppU6OLycL1b3CVovI4BjDmIyKp5IhPeDAWV0oKVYEAR+/rRX9n3HYH6lRMBSZniW;4:GQISYQk8OiNqRBPeuRSVEWfiCSwJcjQA0F94J6TiRcA382x0a9Ku2nN/QZMKLVLjovrmCQp/Htiq2vuGMlhFi1WLsE8aHYgknC3QfZqTIHt5cvvkWEKfFIQWJVHM9wDvMGP1V2FXZUbBmndpxnD1m+b1hyOyGDK8c0ob/+WolGJEnC5Z6HI4vbnbrlJUEZ+8o6s2VU67zCqEbKaNAeBXWBWx5L1OaylYvoG0TE2UHROr+YFxZRRzpcxCktz+cOaJmOCkL/LRTE3zl7Oyh8Cq6g==
X-Microsoft-Antispam-PRVS: <AM6PR05MB445576EA0463E775F89169FDCF4A0@AM6PR05MB4455.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4455;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4455;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(2906002)(229853002)(54906003)(57986006)(305945005)(8936002)(53936002)(106356001)(316002)(68736007)(16586007)(58126008)(83796002)(105586002)(69596002)(2616005)(476003)(486006)(11346002)(5660300001)(446003)(478600001)(23726003)(36756003)(4326008)(33656002)(6246003)(1076002)(46656002)(50466002)(122856001)(7736002)(9786002)(97736004)(386003)(81156014)(81166006)(6916009)(9746002)(76176011)(52116002)(66066001)(47776003)(26005)(8676002)(86362001)(186003)(6116002)(3846002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4455;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4455;23:rSX5bbEVGGG3pNxSyjitn+QKjcDkkjDOLjYDqkF3U?=
 =?us-ascii?Q?KVcoeVh01ZfomQ4g7ptemRZnxQLIIWjAURtfOyu8sI2nmxgTNogIpCJ/WMUe?=
 =?us-ascii?Q?lJz7sL/uUBNSdtWDggIENcyKX0RuzLGgBVDSpmW1V54IrlwKbQdXAbI0pz3h?=
 =?us-ascii?Q?uXsWN+jfrYh4PaAqp6gH/GVNDlGjtb2TheAi70ycSrFeeBtmL+GeAevXf6rw?=
 =?us-ascii?Q?wqWVR6NNx+Xps+d6kCxZHdwLrcHJ7Rq1S4ypd0RfmH1iSIi6eNVXNd7WiqJx?=
 =?us-ascii?Q?PGixNQdzRA6iPllaC6SC/K3megw8Boc8MBaSm3yFD4qgbIA2QQzuj6eIF/a7?=
 =?us-ascii?Q?NnLXeqpcSYAFbFfvyKTQzRnkkZuj70ANvqeGzgrUDQSjbOtVR6EHYPqmpaE9?=
 =?us-ascii?Q?w3CKgG0TOuKhgHkVh9pG3WG5DcGVrib87nK8BDLrczWBBNhztdc7Z8Zpb+lc?=
 =?us-ascii?Q?7uTiNT0a4ugG3OZiFjn8Yk+PV5DTK7vSMoDwYxao9S7pFNE5jB6XaJXaEyYg?=
 =?us-ascii?Q?JdKafpJBexzMKh85GPFIytX8IXkvfAU13uYoCYBL8R1XkzrCwQ3jTIbEDUj7?=
 =?us-ascii?Q?8EfUz84ivXu76Olpqcljn2vobOr2Y6VeCROm2gj1OzSaihvlGL+TpecN3/5v?=
 =?us-ascii?Q?irQjN2meVWDmS/IcEBP/y086BGwZ+ZaGk9f7w5IYRj2it+UsskOl8TY0DDb7?=
 =?us-ascii?Q?ovqamqK5Tf5wZvMFS9tFbCXaUrvz93QtVyOBzFSuYa6PFmW1rTlno1nqIx21?=
 =?us-ascii?Q?3fw/q7RvY0ZDQ1fKnS2205uWNJASpoyTCY3zTwZX2ECZBrmxdA+ktmztHjDd?=
 =?us-ascii?Q?SVtHRVI+uqiX9B+UN50A5emCvGicaKmcuhHSactSOBjhAdUBtwz+SVgE0Ci2?=
 =?us-ascii?Q?7jfozkGR9s+t7pt3OX5byUl7SqFhILsePnIX+zATb9J0Oj//0ORIqSA/eJuB?=
 =?us-ascii?Q?lmi8BPl9rgR8fC5TkKx3ooXgOp/iulS997fZ6hc9ZtvQ93nZY24Iiui0oHlT?=
 =?us-ascii?Q?G6qAApZc/DzXvQB4/cfJ3KsRf890L0ZK6NTyXokSIE1sjwnmCMp9O+eivdT7?=
 =?us-ascii?Q?CReJ06gaWEubevdAVhZx9hl+XFJiDxlcpC81yvW5MvJk7ZKZ5xXyg54bRCoM?=
 =?us-ascii?Q?Teii9uEt8E3gJ3AAUq3MG+D4RH65jcLXEnRLV+5n75MN1yXGVq8S2NYqR/fK?=
 =?us-ascii?Q?nQfwBuir6j51eo57658FEUYI6DKkfyMgwe4Sl1DQuLZ6udp5NQrvjWbJpqGj?=
 =?us-ascii?Q?1JBUc1cOE0JcZNCUVoFWA+mvvk01fIeF8XJfvvB85kCPwF9/UWAlLXcxAV/i?=
 =?us-ascii?Q?NxXHmUOTRXcMXzOHQomVOWDI1kcYIb8jKx5LmRoU7LnIKIGnKu4i2kwLtBV2?=
 =?us-ascii?Q?6oRyA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5xAZ0TYTlhanO6G/nnWzIPH6v74x8ZUkKbMufCuLHDA21NxK2LNUx53+2CNgsG3DrKFXfjumhGb+O/8OsAWV43RJ3KZKGrSK6a8yeUNRyoRFcwwHUlLf14Br41jMVb/JtCH9DrBF5IXVIqm+2x97GDXhdYMAueQ4DveO6BrnjfNOSDlI+8A3e5k9PMvpVMJZB2m8AFQ6RB4c7toOTxuiimiFQPTKZYQoU/rSHAg69vxRgcT2lzOEhgXJjpZCb7YIHNSTqkVjhP+zmgnoQHow38AlfFcJKuYm3zdXj8db5vdeGn52tJ6Q87vc6j7WNSdsy0ILj1i41qA8AcgagYrKlov2T0P5R1HKk+ehEH6GKpY=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;6:mIVOGxnJx9cXm78sMfYQBt++IW8KdnQi3t01Xx9QXoC1KsUTkQ1UdFSHVkuYBMuwY0Bx8sjlKcawq+WI2iVqwlIdMQuCnOUzRWevWkHAdGDogMJdUuDnRYAn6dUoO+QSmW3zxJf5CEecjIXA9N6iKYsUHWAyTNko0hYPJDRt2Hmo3R4zUdaMBTP9g/3yJh35EG4Ct97zQ4YsssvMORC4v1Q/DUKV7RwMTDGCDS5oNf8Io2KbqyP8ONw2PyVymEhL6QBZXYs0P4+ROTf0VuP9r3uOI/xGx0WjApLkT6mF2VibUuh3NWlTdZGzAeL40HHyP0YGUIdu8fc3qZqby3ivEgE6OLUC2V635WebhC4IlihN5h/17tpqOzCy+RNZySFQAHS6i3iuPoHKLCB0Q9Iv38fO0AFw2BLhGSlnh2Lnw7RSkBWS5iHCNRYyZP4uCYHTakR/iISKQq2aJd2eJmKs6w==;5:z3ipROQEyUU6tzWi+gtKnNEEU8IOP2TByazv9LF8JlxMw94nn32nUa3BdW98WpnXUc3TWDwvnVt0Q9/En6h6r/gNojRNWeFtGb/xLtVjFaTmssPaerzRsitU+O0dJPKdQ0hVOKGRqeZmbR+bzNat9w8QGUTs8gqs5hTUsKTeSoA=;24:RX78JvGoLzbuoPiL6fNagBEzbcmBjleuwKVJisD08OFk0s5dxQADcJeTfTe/8vxEQyKAtKC9YBA6DIpceSHe4H20wWmxalarDGDdUzftid8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;7:75R5wNQzOapmw2Hej5GWA2gYoZfmWvViMYrPQzcbNRgknlviLhcLIU8i6d6efWGsHYSCzLMZJimwHStbdc+iYwnKhG236IkRhQwZUGuWyvrny5ZAf/be9YLAWUPawGa4Ib79D1B/vYivTk6CgdSAXovp/5ZLZ2KX3HxFN7A2jwyKCVtRD/3ToiuBclscYcqicp8AQ0KxNh5/LOMiweoXZned2PKWJTo5tkTsql0QXcIV1JgtXg+ws1aRv13NnJM5
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 17:12:05.9237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f1e1fa-19f6-4de2-356a-08d5dabec714
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:26:05AM +0200, Rasmus Villemoes wrote:

>    check_shift_overflow(a, s, d) {
>        unsigned _nbits = 8*sizeof(a);
>        typeof(a) _a = (a);
>        typeof(s) _s = (s);
>        typeof(d) _d = (d);
> 
>        *_d = ((u64)(_a) << (_s & (_nbits-1)));
>        _s >= _nbits || (_s > 0 && (_a >> (_nbits - _s -
>    is_signed_type(a))) != 0);
>    }

Those types are not quite right.. What about this?

    check_shift_overflow(a, s, d) ({
        unsigned int _nbits = 8*sizeof(d) - is_signed_type(d);
        typeof(d) _a = a;  // Shift is always performed on type 'd'
        typeof(s) _s = s;
        typeof(d) _d = d;
 
        *_d = (_a << (_s & (_nbits-1)));

	(((*_d) >> (_s & (_nbits-1)) != _a);
    })

And can we use mathamatcial invertability to prove no overlow and
bound _a ? As above.

Jason
