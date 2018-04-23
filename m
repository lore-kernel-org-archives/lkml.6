Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbeDWMme (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:42:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59646 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754880AbeDWMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:42:16 -0400
Date: Mon, 23 Apr 2018 13:41:51 +0100
From: Roman Gushchin <guro@fb.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] mm: move the high field from struct mem_cgroup to
 page_counter
Message-ID: <20180423124145.GA29016@castle.DHCP.thefacebook.com>
References: <20180420163632.3978-1-guro@fb.com>
 <20180420163632.3978-2-guro@fb.com>
 <20180420205450.GB24563@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180420205450.GB24563@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:b3a9]
X-ClientProxiedBy: AM4PR0701CA0003.eurprd07.prod.outlook.com
 (2603:10a6:200:42::13) To SN2PR15MB1085.namprd15.prod.outlook.com
 (2603:10b6:804:22::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1085;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;3:gX90oGLNU9pXy9DSd9uoStIQVkbg8BoKOWmM4nvuUarmL2VhSSkPNT4NUL/fMzwF2MoDJGJMbm+JL7m8p2xJBDoiBmKpAJPLlbbPzAD3HWt+g2i1qqsMxZu4zgi4R7AX/0j+O6LUOmJvfIXSsa/+XnjPbAHJ0ecHil4YyX216Ef0d/nXOz6XTgMmY219n369nHJCjLM34/PnWCtxrP98SSNMDFKSQL4uer7/xnGFMw4YqlbIVBPQPfcoLwHo1RQ4;25:0mwH3cLc3t3Hs0D7aVUg+eGUKp7ScaHWDRP6R+7C3r0/Z+KmJfttBnVIiy7xFFjjVA+1l7rjMe81FmqEWQYtYZGf/zrKVEVbKMrtOjAsR1CrxhGowU6+PcbUo0DsI9ijR+6ZDHu+KMefJ1xAVe+6e1ODMlxpKmjdMRWC8fOvXB2LvEITUaDtii1dEq3Gj2fJgjLiyANhB7cV5Fm5vnudSJYX5H2WM46hfE+B4o86WJ96q7C+rZfLKQ5Gw4LJAc2ygj8UWBXVCTlwVfRUA/eauQ3xUY3B9ED4GVcKttiulSnIGzh4S3gBMTBUkjsbFYohSTR5OuDMtXiCxJOeCMnlDw==;31:jh4Zgsi48eT5ySvs3mocbp4U7U8sS/+4SyMymvDry0sxv2M2a6R8OHQ/uh+t3HR+A+x/Ycb4oj1sRYWsGL3IcyyTa7Gx5N91CbIlO3LP/IqfAL51y8i33Wt3jgXrQDClssPQhLqhX3N5P1imyNMKEYDpLmr01lYTn2uG+La5+Om+dk1Vlw1WrVYOjH1Scbz8l8H/c66JwiUVLLJ3ZsUscArhdqyb12UkmVUPFc6DDAo=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1085:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;20:HlwrUKd7wVfsT4mzml+06yf3b1gUJw9uio7VobhwppgZVrfdxh49DhemvuKHbNO5WUxT1z4oNKkqRKTWte4F58Hfh/IgbI8l+C9ydB+cLNvxd4l/Z6PnJkyl8Gb7Ho+22K6juHEy+Dwo8iSfHZR9y7BvoI6+hiEvQvLiRdfndj0wD0Z4kT3Fy1InSVCKILZjzt5U9EzxrVhhHBVWc5glevb72Znz7axGSlkGlgV4dLkQe5BQjBI6t7wagD447VM20y0OUw9EgTrkl6z1YiF6cyB4LSozDUS72LDQpKRjfVeRKlMgP33ZXRQ/LqqF6RJNDOm/r3neRDj1nUEoRwLA3ouIxYohYzyc1UNIk/w7OdqTSUnXIkBtyX20UEvv+EZW/ZvdTmjnoD3pG1tq/iYFsy8wR/T/8TCKfyxKqx27aeq3cEi/pec5knmb0fOZ0onsqOJ36VrRpEcjXs8VnBB4jIgvdNQGF/dd7HaGQbPR2X2RuNWzojQ0J/wbXZq5zDkz;4:AKD8qPQ6vymMZjTu2Svbv4sjZQlCySU1Uxf+49N0Te2pTR2fi6dTW5ma8xuG2wzLNEvpQCFduReuJcj25GPOuNw6IMIGlq4iwWs602UZWSPRQYkeNWD2K9b/YHc2pk+DLsFx76coqJJbaz8seUTZGXYmeo70R/ARHLon8fCWz7GpyKZFRtnclujmRwkfJ1kykjZF2iIABP0+yKBW1I+G+d/0tSIjkkcSaHahGtpbGdOyoKNtgy/yIrZLTHB/6iaqAzaoOL9VWaGiAI0E1890sQ==
X-Microsoft-Antispam-PRVS: <SN2PR15MB1085F96D4B60FBDBAEDC4008BE890@SN2PR15MB1085.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(11241501184)(944501410)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:SN2PR15MB1085;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1085;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(366004)(346002)(396003)(6666003)(478600001)(446003)(25786009)(7696005)(54906003)(316002)(6116002)(23726003)(16526019)(476003)(16586007)(5660300001)(6506007)(8936002)(58126008)(386003)(47776003)(55016002)(86362001)(11346002)(229853002)(9686003)(33656002)(6916009)(50466002)(81166006)(39060400002)(4326008)(186003)(52396003)(46003)(76176011)(53936002)(52116002)(6246003)(8676002)(1076002)(7736002)(305945005)(2906002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1085;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1085;23:jdsDFBr+gyudS0fdZLTm+k/ZXoozOAvQF+xmYmWOF?=
 =?us-ascii?Q?+zgtmq6jK/UXMDDuTVQYryQMJmj6QvaUr9mbR0jMYIb9NSlgSBu+bxG29m28?=
 =?us-ascii?Q?2za12N6Szk1f/q2NhpssO2ZoSGKcMRPa4pIaq7S0dd4GZ6jNDRn9s3mgHvG1?=
 =?us-ascii?Q?bgbG+k5xcLTJFolBaHgoWvkgYXddADtA8OLWIOx91xioDJED29Hn5ceml79L?=
 =?us-ascii?Q?bgUrxEYh1HBXUn+FjDU1w8ujG/aEOs1iNUfbwtMT8r8u7n3ICKN37Ce/S+QZ?=
 =?us-ascii?Q?vV/DNK4Huse2VCmVwajmjhYkjNXBpI0i4gQPwGgGyqWEksSs8SWzyfMeRvrO?=
 =?us-ascii?Q?ekt/eclz+X2FPbnSgs6Mvr3VQATbIRo41EVmnyM+Nb+Xkj1p6acbsLszonBJ?=
 =?us-ascii?Q?maizoSQTPH/gnoRhnqRXAws4GYPVtOCOiW/xkdx0I5yfwHixx+9YUtP4D6EG?=
 =?us-ascii?Q?8FqTdbsAXO7GdRuL+KntQEU8RPIyY4Of7r6rYmlEW+0K7IhB0AJ/NAExg/Ya?=
 =?us-ascii?Q?GNrzn5907SFHtAAtIbuP70godo8qHTn2UCRzqahdQgHlKfcA09p7mFkPoAU/?=
 =?us-ascii?Q?v3Vsi1Em9ATtKF0k5nGfmw09baURLavMeqrtHmAe/wexltydpXfuYP7D+C8z?=
 =?us-ascii?Q?KGxwe0tpXz7ODfgcMY3A1KBf0mdV6/kaBIre45C8r0Vu2r9GuZ1WKak8swDd?=
 =?us-ascii?Q?QbAjS+qiW0+XmyZuWjS/yD3o2dMip5nvNr8Xe4rWsLsf46L3rt3J07YBq6pm?=
 =?us-ascii?Q?2Gwx7qJp0k1wRaFEraaX3PVLVtrw94BY/2DTOhy6/Xt6+i9E2/+aQEQ/TmW7?=
 =?us-ascii?Q?vjLm2DHM3PtNMDdWL36ZGOL5k9owCgt5tkkrhyKdZev0pNdPjrTHPa/I0X63?=
 =?us-ascii?Q?XSV0usMk0JMty6j5ntgR3aJEs5RIO/GrK2PvLmKdT4nQWT0ipVGZlgVKQnja?=
 =?us-ascii?Q?Jlp5CTVFLeidNwZQzAABd5j7ad44gAl4r+3SaKd4UxkL9hNgHTAgfLQDeqGT?=
 =?us-ascii?Q?EZob5jhEblHd2NHrmwnAQYKHfamoZkFgBNQx+fn9WsqJqqmNC4Yq3BJPGmHQ?=
 =?us-ascii?Q?/pZDGnND2s7ODUliq6jmOhXeL4K5Z7YFnN/7jvvELv5iDOWXRNOayW7l92eT?=
 =?us-ascii?Q?KVi38+NNN0=3D?=
X-Microsoft-Antispam-Message-Info: LMiAd42sp+WPTbxeOdM8vMu6VUM9wje4akqNHqPMQmo64x8yLE9CSJDZbtW0j6K6SF4fsHVeEdoZHhumgyDFUaclS6n9djZjfCCvEUhk9+rmsRm9gnM+36LI3LVYrD8lhV7mK6F1tuGwQYPlAEVXkkKminTB8MHFadij0TE3j0m91/PQ2hRAW1SqQGvn3UTM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;6:i9w6JifvEa4DNKPhTfQFFh0UWrZOWbg8V7QLxwj7rZPI8LyjVAkTxI1Ik/M2O+/xZl85tQanDpSvcTi61bIc9HILeDEPwfyU873Hu+thUBIy9HVlVr0LXhyCYtPynm/TiVlULe6V0Zby6ejr1PTvaZ0VwySKZjqekmUxLiHTiVmP8tpGpfS49Xl4gA67/PB/1qWb5d19LWlRdj2QvAicP/iDZ9xNUcwQIfETo6j9ZY4rrwZZMuSA3oeYbowxDDOdkPJ6bCITWvHwiXQpU66IBrpu3ddoHQWLrB02BxU20e3hKBdHazUWOAWSFeusBGXNFYb8yvBM0PmoUc7TI3zMOTtYMkRxd4ykmwFMjO/Kx50SaH0qxsN4tSzEDEPDXWdix8pBTL2O2uDen7kpfcL/nb72wr3ipmkClG26y1Hj69QZe1d36oz6WZ94dNWI+ZSRi2RQzTph+P6bBfxDWPhAWg==;5:zwhvBrozpjf+xy7TnKDHwuxrU05T3kakIzVBBjA3co5bdxdNURGSJgI+NUp0cQa2UxCt571xUoA+u/mjuUdqG2571Z8RfYW9tT7ihQjhpNuxhzgAjXv7vxEyiNP4Y6KlRfI9CC6PihHcdMSRJKv6+hM+qVWM8EfBKojdaLRi+yc=;24:Hn9FLFmKHdfBsj18vj2D2Fp3TET8HzmK+sM4RJSaVK+/mvi1liPl8OdkDpvZ05GGCUNT5UsjukVnHbSqtYlBH/P+OyK5iLTfP515QBMDnlw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;7:4USS4IvqhFKOTOZ0/c13fG+qGHZkVMVgzic6k1eyhwbnLzHoIixCpitU8OKD+FnC41qhZ+KjRycTEkWI+bJ/tPxSiXzkOcn0n2bl5oU3YbxtygGkZt/3QEKmF+lR+VmGn9rmkEdGhGdt5yL1gly3hof6Y0GErrQiVI8HEfbxp86mFPuKPRLMk/eA5OZN4WvjuEA+2mLweH0CO7aOcj6Njl2TAWiY26lAexBIx+E5kcXaZYUI6dnWqVX8rD89Ie+4;20:cB6Yk8xxIcwY+NXkxQNNEQAxRM1rLLOdRmtyUWferaTMEO1eSayNFnMbUNp0gIr+fzT++S1dbJiwQjVbPcwWXnLo9NIA9DcmZeZDNu/02ulK7gY7QqTlnFrUPUHh0QnCudrMXpiBdDZY1fxsm0+jwDmu66+v5X3rP2YvYawSXr0=
X-MS-Office365-Filtering-Correlation-Id: ba2c061c-c3fd-4c8b-ebfc-08d5a9179d2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 12:42:01.5507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c061c-c3fd-4c8b-ebfc-08d5a9179d2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1085
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 04:54:50PM -0400, Johannes Weiner wrote:
> On Fri, Apr 20, 2018 at 05:36:32PM +0100, Roman Gushchin wrote:
> > We do store memory.min, memory.low and memory.max actual values
> > in struct page_counter fields, while memory.high value is located
> > in the struct mem_cgroup directly, which is not very consistent.
> > 
> > This patch moves the high field from struct mem_cgroup to
> > struct page_counter to simplify the code and make handling
> > of all limits/boundaries clearer.
> 
> I would prefer not doing this.
> 
> Yes, it looks a bit neater if all these things are next to each other
> in the struct, but on the other hand it separates the high variable
> from high_work, and it adds an unnecessary setter function as well.
> 
> Plus, nothing in the page_counter code actually uses the value, it
> really isn't part of that abstraction layer.
> 

Ok, not a problem.
It's nice to have all 4 limits in one place, but separating
high and high_work isn't good, I agree. Let's leave it as it is.

Thanks!
