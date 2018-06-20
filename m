Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B57DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1000320693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="PH9QZpAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1000320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbeFTJpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:45:47 -0400
Received: from mail-eopbgr700045.outbound.protection.outlook.com ([40.107.70.45]:61984
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753960AbeFTI23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9tshyz/CvCVoIvOaNRBm9nkpH+R31M1kCbE/irMKr4=;
 b=PH9QZpAYAPKhCNvo/afhdJSfyyZab7d21DIlKQSQ/RauOolqUmNUWz0/6573IdTo2nouU4JNQY1SLOjaeTHt59HRdU/P6v/HeUOigA/H6tuyXF6TaDM5ebpJTvWg9Y9mw3X7wffAetTGewpTDMgq2AkDyXpFLvTfxlWGx5/PKxw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (95.15.33.164) by
 BN7PR07MB4370.namprd07.prod.outlook.com (2603:10b6:406:b5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 08:14:13 +0000
Date:   Wed, 20 Jun 2018 11:13:21 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
Message-ID: <20180620081321.GB19364@yury-thinkpad>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
 <20180615214231.GA371@yury-thinkpad>
 <20180619183316.GI71788@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619183316.GI71788@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [95.15.33.164]
X-ClientProxiedBy: AM4PR0101CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::43) To BN7PR07MB4370.namprd07.prod.outlook.com
 (2603:10b6:406:b5::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13181c28-33c8-436a-f32e-08d5d685d00f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4370;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;3:b3rOVjBzWZQFg8RjB1Hve4G/q6YDncr9A7r44mC7cATfjbgUNut88aXhzohiO+rF8GS0/NORy8KBqzke7CHzxB6lYgJlWo4MRsuLIYjFOm1hN8uodDSZxI0KWShGCAMCjlqVVrVRF18+ttaQHIpLix6ebKBtrSBv1sDTaXTmxmjrf5F5bEMpvOjrdPomFcNoic+vlXIdoFad980ofrtgMVyA298zF0zdVDM0E+iyCJiONCq5CJGb/KSqFzGXQfFV;25:ZXcYIH5wvVfdmOPW2pMPW6LInRSgefuMCDIt8g2QnbyMtEd8tLD8FiPg67ErrPcOGMCUWOyN1yyKLosynQMR+gfqjvJjr1HLO3ZHO11qUFxoH2Uple7Ls57ogWV41tQVXWrWG8EoWNsttr+0FsGoUn1FQ+6eG0N3ZBQvf+zNAq4Qh1rSC5Dbloet7GMRY1aDD2ObfxvUQm1/jDynyz2DG8E8/DGjsFSn5CebEJSk8tyeQSJQLqfsPpChmIe3OOSPFPEWc6T23jWNW7JuITp6qyec7fKKmvg2Sf3jtKLqwW1LqtL96mP0LoXWp8ScGwUPu982xjK5nTnz9epfb0Lmzg==;31:BlMpA7wk8QRkhfG2obiTC4VmFnhPUXN9VN2pbsGf5RkhTQKOquLeKe+K9pUv2ruWq1S06QXPQ8sAm7DLyZYsQuAqgCs2rKDCtzhr1Eh8BjuVdxAsoUqVYqehZl33wigYbbf3PfiL3IdexdqLNKL8+TDgptzzWKqgT17jFr54Yv/MeIi4YLzojPxkA2qFHXyjUKi7HYSqCXUhHvPVkjYHalrmTTGlwFxeGnGJRbHQ+Qg=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4370:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;20:E2hAYBiM/Icotc41CCpFZU1uFpKVpUlY9nLbEdWmjwqOLfVOqk29xxSr8Hqy6cBuh4iBCWve14rqxcpe7WAWIylt6e193dihAuvuFSsvfiIQo8W9kPaqFgGN22NPCjbsVyvpgq8/CXxdPvAzzm/g1HC+HB339hJkWMVLrB9Rs3lv8o19F4989JJpQr8fj2bk8ykXZz6etIWqE/M8f1b15DPctl+Z80i2JbYXFdJxnDHwd6k9bfS0q4HaypY6USHtoOlKS1/Z+wLgdfHW48OndpIiUOtNaVctbh8qjT2/EyhRc1ykLmDcrxRU9d/eY44BhJcaYa2Hj4mF+1Nl5+2uyTmnZMdTBntIyX69lVHBwm8wSi6bIuIhCKAf1AKTX6fUtwHBJQfNc+ChRE0jJNViKsht6eYibWv3mAEp0MoWY9YmTVontJlE2ekKbGMqqNXUfD9dQMP9iw+D0Fa0V3d+5rn6FLxI6k0qJE+tjHR3iHI1cTkFLPxmht7FYqSe0gwcqF64KSbIhi3fXbtoPLG69RGLiYHBVxjloO59S9T4yxVauIO4yvDFYPmPL22vNsP5FNv2VqGkfPR7K3x6UDMzuvVgWhaSrLzFwZ0H6qRdMsE=
X-Microsoft-Antispam-PRVS: <BN7PR07MB4370CC70012472667F7579FEE3770@BN7PR07MB4370.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4370;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4370;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;4:PpjrBQTLwku2k5ubwNdXJDZa+zve54Lxy+heYlOrC4RqejHwUEWxIxBmRH2TpcKskhJj90X0s+G9ps2ghVPa7XOBXz3wuemdk/1BhHpNgQY4sgX7TysJBivG9DM36yqIKf0SYpWtsjusfWoQG0QoFoD7IKWa6J9B0kYIKYgkddErDrUqlZw96p8CuPpuI73jveSI0Pt14PWXDcJxnSnn3Aoz+aH7Mn8GQrHHYTvtL+Sz/GcXqvNDb2VkUTYnk07xKWY4Dt428rBKH1cZxxt5uvyrCY9YHRhohEUbVyzYgBXlKbEBvzyfu+A8NKSGs+iDUIxtCskUeOduq5uQI7JyF6SmF81rYjOp+pxTGq5Uesw=
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(376002)(39380400002)(39860400002)(396003)(346002)(199004)(189003)(25786009)(6496006)(6486002)(7736002)(52116002)(76506005)(8936002)(53936002)(93886005)(106356001)(486006)(47776003)(5660300001)(305945005)(6916009)(23726003)(97736004)(6666003)(2906002)(33656002)(76176011)(1076002)(9686003)(4326008)(6246003)(6116002)(50466002)(33896004)(7416002)(3846002)(39060400002)(81166006)(229853002)(72206003)(386003)(68736007)(26005)(8676002)(478600001)(33716001)(105586002)(186003)(54906003)(16526019)(66066001)(58126008)(16586007)(316002)(956004)(59450400001)(42882007)(81156014)(446003)(476003)(11346002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4370;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4370;23:M9w8RquzmOajzzfvroV1VlADUGfBaCLYbdiTzsdqJ?=
 =?us-ascii?Q?u6ZkrWqWeIXaQg/3AG+FvzBVkC7Ey2tovceURu01e7B8CdAreCoyN15Addv8?=
 =?us-ascii?Q?itO0wHdgaV4EMtovx90Q0NgD0gTvM1wAdS5csoG/VxcLm4IemkcByTR+deMJ?=
 =?us-ascii?Q?QaSI6+MXllks6YgDBvPZ3UFm/tou5sB0UjXLY8JXMsFba5f5xA5x8jLjxNme?=
 =?us-ascii?Q?+WsXxBNGo8PAB/UPfhAZvzPNqkdUX8CWGLf1Fh+Qefh31Ube/oW7ftgP1PZN?=
 =?us-ascii?Q?dEexuNOpRtTM2F7j400151q4lfN1GyKAFADBzEMK9Q2pNt5qg2nPEpYv54lG?=
 =?us-ascii?Q?gpNvWy++lXgNrhXO1lJem6YnIJ7Wl8YJz7YVknm+jocyp3LZCB+MYQeZofg7?=
 =?us-ascii?Q?fWTdDvm90qBkx9w42Tv4veeLixV0qCqrhU2ri89hZU2LhIkookaYOU9d3L3s?=
 =?us-ascii?Q?8BVRWfqNHWzmNm0QMhYVkMLKUA6F2ansTy8ZAVejE95LGNqfavPEE4KLSxUB?=
 =?us-ascii?Q?nzIqyCBCdc+NIt38+6Z9Mrzqwddn7yaenDvaoHw55m63p1hrB7djBP270yLb?=
 =?us-ascii?Q?WbzDY7V3pSqKeNK29cwezAOeVcrEGtY/vhDkBoyJx6kKkMyEqs4hvCg7uhZu?=
 =?us-ascii?Q?dUpa3/pM40rek7Eq1q+YZir2lRKThSRTGi6zyMGusN9/w4vTJgEFrcl7xzWP?=
 =?us-ascii?Q?HQ/cIIbMa+rRaACfmB9QaLvweQDi3o36CBLwSa/NBreTc8rbF3S/lcSq7N3W?=
 =?us-ascii?Q?3/w5xJNLBYrFUEpvLwBZPLamegJUeSZ/j9Xeu6OT/+FCGHUap4ut9Qg12MtC?=
 =?us-ascii?Q?vXBae2uiuIg0i2rpIuZaEnRmfbsIbqeJpXOlzavIDA7BjtKZxzirgu23jJ3g?=
 =?us-ascii?Q?XkC81gfhnaZXuP9lG2qQLkPO6wuRGvMJvsMukH26P3CEWAWScr9y9H85lPA7?=
 =?us-ascii?Q?kcRpvpjRy0iYfLPSDWr6ha6qxKCQzXB2Zeq9Cf/+O+10UusJmqeSir7UyR2i?=
 =?us-ascii?Q?wKQVPQFNIjvoL1HVGQM0bdL2MoVvd/b1YSk7iOkiInEEnh5z2eJlDw8pJRW4?=
 =?us-ascii?Q?ALHGnosgxluiQT8oj8FjQkOqd1ZiT1WC+3aBRRv7+7mrAFzS5bnPSRWZTfVe?=
 =?us-ascii?Q?zHFFLErjranjTnKPEoT93lUpqjh8ayZhKWeyg2eOsXsfIAiDN7+Aqmnr4OhT?=
 =?us-ascii?Q?KfaGc3/q5Ei46IVA+corAXDnCs9cJbEA+wk5QEsYafNqCiQyCu5JhxjZGLaI?=
 =?us-ascii?Q?TFYH6grdww99PLrefKdRP/321SEzfONnKl0eifdiECq2U6gfhRFEae9lcSVV?=
 =?us-ascii?Q?Eq0r1igS+viG56zCEw7D7g9jpEfsRx+U3PPal9jRrUhaLPX/j1yEmXLCOFow?=
 =?us-ascii?Q?3/7tZqk9XTgql2hakrECI7Gs5ugyySPpvLyDI1XyOuSiFfyznfdsdE5bXEmw?=
 =?us-ascii?Q?YPA3qmY3vB+uKxDtQxgUI6uuLAmSWoNMwK+asnV3fNGDPyQ4dqW?=
X-Microsoft-Antispam-Message-Info: 6ie+SDtPlQk1dBaSQncFoNUXE8s2MG1Tg/xr2rcvYCxJiowDaJ0vpdBSx9ONK5ajQVDcVpWXcoaQtCEPm8IvNVqFdHd6evCmPX/cJc8JoynowDazrDrt56V2AvpAIqIwnLPI2fXUIO/vPFaqke9VIqOt3857A2GdjeDY8eHBAdi966C2qC8KcRl1V8Ep5B+eG1QVcitlexYiRkUyMiBxdABq1ussoyCzcoBEbvrTspCCHz56Tb/L+nEujG8GabyqoyY6lfC4SiZYwDtEbfgxEVx6JKLPImbiHJW2pVH9+j7FiqrXUycGTjIog5RNqXu66Cth2ZHFXc3O5h1WbjK1/A==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;6:JYHSkTtdTiT3ZLAHyi5gWzQ9MnxD+jYMNl/yFwmwfk/3qCqFm6ZgoUIp9J+xkNYJGXR3iZi7wLotwWMW0MqtfQiJpq0re1mdfb+uvCjr8XFpig5HF3PIaWqYwdXOTxz/081V3Au+eA+TtVZ+xfflYZ0c30mM2HOGVorRaHNBiznOOiIahiczFjlPzmLdhyizEDREDBlgacN9nx6kZOf16bqPz9bVaKSshOsRzUEv1BpHKBwo6HPQpfLBsI05aqI63J0GSi9h6+a2Ob3Sn1T4U5WEH460Sk+Y6LIBWL8kFQSobZJAA5rXf29vIc9J/j+5ln4WIV85Bi+X2NxBSuOZDVwDyJEQnpqSX8V/0fQNWF4s8M2qsqrr6BlYRdrIOWPiYVX8SJBNOM0p37Sv5jN/98oZ6QVzieHBHlgbGXuh9LIs05Us5p94Z6WmO1QCENvdRFeVZ1vyXmkDi91ClGxRGw==;5:6VxoPnSWk28VoOXDc/SWkMq1tRWvi8TdI2o7HZtPqMzEYGXivB6gxDU8n6Xg8Gsz9xCJ62gYYAEZ+eMXJ9yNwKndDs+WV/Uf2ZxJNdnhpjFM41OZkAZetkbxZI4+SybyqA8g3DMwOfGsDXkfCP70kL/uisF0WRjEiqQn8wy6cNs=;24:aLF0eRpRTFmlDEtbQLYGMY/TGPUrK5k8+opo+uZ6179xjPl4P5/iz7BQLRwmvlqWdrKxXS5arFPQL6JM/Nn4IGJk4t0wioN5Rurx+z5248w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;7:pp2PDhGu16MC/kZkB+hkiau/pOVtySwx0rRaGB8FiybyX/wY7xS2mrsJ3Nf2wZdhO8+j6NAXivc5d/h9uQMBzc5enekWlo2vemVK+beBjW0zg1dofs9WFLatWRmou4GVl5bMO6HkZV/HtsV49YdqSA2Df5kOe0Arq3yxRonkx3KxFeYZezjaz8/V3n0snnbbZcTLXKcuUSiIJXmAER3RYbO6jdMeGjWJN3f3ZgUdapACd8Qv0teWELMa+6+SXnG9
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:14:13.4971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13181c28-33c8-436a-f32e-08d5d685d00f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:33:16AM -0700, Dmitry Torokhov wrote:
> External Email
> 
> On Sat, Jun 16, 2018 at 12:42:31AM +0300, Yury Norov wrote:
> > Hi Andy,
> >
> > On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
> > > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > > Besides that it returns pointer of bitmap type instead of opaque void *.
> > >
> > > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/input/evdev.c | 16 +++++++---------
> > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > > index c81c79d01d93..370206f987f9 100644
> > > --- a/drivers/input/evdev.c
> > > +++ b/drivers/input/evdev.c
> > > @@ -481,7 +481,7 @@ static int evdev_release(struct inode *inode, struct file *file)
> > >         evdev_detach_client(evdev, client);
> > >
> > >         for (i = 0; i < EV_CNT; ++i)
> > > -               kfree(client->evmasks[i]);
> > > +               bitmap_free(client->evmasks[i]);
> > >
> > >         kvfree(client);
> > >
> > > @@ -925,17 +925,15 @@ static int evdev_handle_get_val(struct evdev_client *client,
> > >  {
> > >         int ret;
> > >         unsigned long *mem;
> > > -       size_t len;
> > >
> > > -       len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
> > > -       mem = kmalloc(len, GFP_KERNEL);
> > > +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
> > >         if (!mem)
> > >                 return -ENOMEM;
> >
> > But in commit message you say you switch to bitmap_zalloc(). IIUC
> > bitmap_alloc() is OK here. But could you please update comment to
> > avoid confusing.
> >
> > >
> > >         spin_lock_irq(&dev->event_lock);
> > >         spin_lock(&client->buffer_lock);
> > >
> > > -       memcpy(mem, bits, len);
> > > +       bitmap_copy(mem, bits, maxbit);
> > >
> > >         spin_unlock(&dev->event_lock);
> > >
> > > @@ -947,7 +945,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
> > >         if (ret < 0)
> > >                 evdev_queue_syn_dropped(client);
> > >
> > > -       kfree(mem);
> > > +       bitmap_free(mem);
> > >
> > >         return ret;
> > >  }
> > > @@ -1003,13 +1001,13 @@ static int evdev_set_mask(struct evdev_client *client,
> > >         if (!cnt)
> > >                 return 0;
> > >
> > > -       mask = kcalloc(sizeof(unsigned long), BITS_TO_LONGS(cnt), GFP_KERNEL);
> > > +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
> > >         if (!mask)
> > >                 return -ENOMEM;
> > >
> > >         error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
> >
> > If my understanding of bits_from_user() correct, here you can also use
> > bitmap_alloc(), true?
> 
> bits_from_user() copies as much as user supplied, we want to zero out
> the tail to make sure there is no garbage, so we want to use
> kcalloc/kzalloc/bitmap_zalloc here.

I don't understand that. Tail bits of bitmap (i.e. after last used bit
till the end of last word) are always ignored by kernel code and there's
no matter what was stored in that bits.

(With the exception of copying bitmap from kernel to userspace. For this
case we have bitmap_copy_clear_tail() to avoid unintended exposing kernel
data to user.)

If you know any bitmap function that don't ignore tail bits, this is a
bug and should be fixed.

By the way, bits_from_user() is bad-designed because it takes 2 size
arguments - maxbit and maxlen, and should be reworked. There's a
single user of this function, and I suspect, it can be switched to
existing core API, like bitmap_from_arr32().

Yury
