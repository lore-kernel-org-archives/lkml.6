Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeCZPzD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:55:03 -0400
Received: from mail-bn3nam01on0127.outbound.protection.outlook.com ([104.47.33.127]:23963
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751109AbeCZPzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:55:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com;
Date: Mon, 26 Mar 2018 11:54:51 -0400
From: joe.korty@concurrent-rt.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Julia Cartwright <julia@ni.com>, <bigeasy@linutronix.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Message-ID: <20180326155451.GA16545@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
References: <20180323150959.GA16131@zipoli.concurrent-rt.com>
 <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
 <20180323172131.GA2670@zipoli.concurrent-rt.com>
 <20180326113515.720e7fb3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326113515.720e7fb3@gandalf.local.home>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: CY4PR1701CA0006.namprd17.prod.outlook.com
 (2603:10b6:910:5e::16) To DM6PR11MB2570.namprd11.prod.outlook.com
 (2603:10b6:5:c6::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64424a96-615e-4e38-5f0a-08d59331ed65
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2570;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;3:iKHAvRQCuSHvP6/asYynhbsKk+kyY133Ej0IfhfM4JoPfSVxzD19P6qgFpquIgGyIoilZQPbWidO4jfDuwtrcNnMO6exCoYvIltPdIHqBg+NN1QGovuxSWq1/zadAnSOhcTiQiEMIM50D/SYwaW/eDj9goj/XvkoEgfq2mvAk5OaxKtEkqUnab7/06KBq7CGQc8XC4LrMg6+9MmTROOYRpcGPYQnl3yx7GxTNZf4k950VLP5qJzxU+1zFn/UmxmW;25:La67qyPVU3kyLIJitcoknNO/OrpTGbH0fv+op+zwbyV4cYHJOTFj9P7D6FErgYn2j59n/H0LUlrd9T4ujtNuPF2iUH658JOkzVGz4nt6zi0ua7q9DUsWAtgNIifsQp93kNXMbTTOMwrhCqJxwtRmHAJW5Jwsk//0mnMojq9TVpt3qrQ/2t5weHqladQtZto5r9O7L+vY4k0N2XK0NKNgxRddEgcnfw5Mn7+ikOEUaRafCiUJJDWJ1IDdJBZO6ULu4d6HY3APIQ0tP9HOWCeK4wYYrstrwf+nElSdEwEtckhhX7wthV76n3nmuMaZV/2Voy6RgH7vLglpdfebC+rTSg==;31:GglBp4Wcf/n8APv479GAq5SzDkW1W3rAn08fPoGAkdauK9S9vNBMiRkwvlTcA8/ZBTc08UQtkfEUEeLokl6JAF0qJTonVlXkY52otfxDF4NWAKyrhqGzAh1qte5FKmn3RlKcsQ2jihrgVYVyJOGvvlRgN3o/7Umsgm6G1WR8D0XpBfXYd/N3K+DeTwoN1fXuH60Xb7/HNekeygeMoA8taL9YWlQGsmXFVYwNkKnaEEM=
X-MS-TrafficTypeDiagnostic: DM6PR11MB2570:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;20:s/ZYPXBZLrQsnssiQAh3dYE4nWYuV/elUvTU8TdcX44D48VehWIHfrnihp3Q+J+Nt6VihNmZh0IfZrTq9nHnxL9CPT7c36Z2j3WdXFoKjNj71xwKBI1c/GDK/XU5m++Mh2q/BWIDmhuCtPVXI8PachnmZcLD000JrcjhgWwfDkSol2m1FllWysk7xyjb7U9LPbGkFurTrvcqVtembYkYHFapldAe69fq3SoqTkfIa58OC2pSdxpPNadRjaW5hNO9KKUpVqkXVY1kpXcIB7Hzlox4fC0QKBx8gxxXQmz/oHM4QDQD3EvabCDE2A18s0AacJ7JZ8NbbzBb0dH5rF2XXQ==;4:6IyZM7HmOlaIYN0EYxf1N1poIfXZTA34cTTfZn0Dg6jpHNtKnGk9N2ol388G8e6FrPdyteyUWvgIiUy8Igoe17rh3hWXQrHmCotDDym6BDZ5pBRz01+xvVswY+EupoI+vyxaP2PRkXonxuxWvK2eDQPrZVJSyQsnQm7Fs00PyicyFCCm90+2bDE0vFYV2QYxBCVhlU36dXYj0jAYmlmLFE5q9t5Oxlz9R31VuDKR7IJ9WnoY1Dy9QCxrYkMNe3DwHB73ZupLfZSrTHTWQT4gAw==
X-Microsoft-Antispam-PRVS: <DM6PR11MB2570CE5A19FE5EF55AE07B1FA0AD0@DM6PR11MB2570.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM6PR11MB2570;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2570;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(346002)(366004)(39380400002)(396003)(51914003)(199004)(189003)(16526019)(186003)(305945005)(7736002)(6246003)(5660300001)(53936002)(93886005)(23726003)(6116002)(3846002)(1076002)(478600001)(316002)(43066004)(55016002)(54906003)(476003)(486005)(486005)(16586007)(58126008)(6916009)(8936002)(47776003)(66066001)(81156014)(6666003)(81166006)(8676002)(68736007)(33656002)(26005)(72206003)(105586002)(59450400001)(4326008)(386003)(85782001)(106356001)(446003)(11346002)(956004)(53416004)(97736004)(76176011)(7696005)(52116002)(69596002)(2906002)(50466002)(229853002)(9686003)(25786009)(86362001)(18370500001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2570;H:zipoli.concurrent-rt.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR11MB2570;23:NzFyozTKxH7eLqjJGnv7wmiPhZEGjlVrGZBCaj9C4?=
 =?us-ascii?Q?f/EordeSEDQ0zVwnNFnx+q7oVIzeW2W7ZahUE2F1ukKUeNGEmktnAmQfdg5P?=
 =?us-ascii?Q?06cDVtsTRLJU0PSZqhf8jfbpbEQlZpUtwiF4G/ASpvEaqklgZhvF0MItjGZe?=
 =?us-ascii?Q?5AVOzaEelgQjfjr3sqvar6MgC1+VDV8vxJ7qOAe3dnHaANV0Q16SfQJMfmHV?=
 =?us-ascii?Q?bZmz3I1ERh18K4QhvxYXis/4Y2dgVp+qLPVRCNG5l+oBulNelCX9iGjMTP7U?=
 =?us-ascii?Q?R3UUntaiBwKhGu6dT/3y8j/jGoay9LxdB61v2vm/MRO2OoChOrZmEpRTebBy?=
 =?us-ascii?Q?4oCUaKuF7LlmG0w2CJs6ySmvbLh3qK5GrYfU0GXKoz0NBHosCNVOYTlQfTsB?=
 =?us-ascii?Q?4/SzpFaNco6Jwsle8Yz42CuaP/9XnoDarjF/Yb97vmde0SA15oasPx9yyINf?=
 =?us-ascii?Q?4FMCmdwkwLCNB9uGg4QwwJbsC8LZtzIuHfK3c2v/0jiZbk76BbOanxHvlFuP?=
 =?us-ascii?Q?wL/nymBXLASeXysiYzDRX16Gj2YntsOONhauzbQJ+p+hqdFkXaF3GdKhBs+T?=
 =?us-ascii?Q?Avvtaug9+kDUeO7t6WgLCgTga6bbbxiHJG0iSPncV6hq5ilb3l+m6KqZa1x9?=
 =?us-ascii?Q?eudUfPXj0Ai9W88Vj3LOMEw+Uk2XRt3a99xa54UhLK8bmHrat9MTOs5Hkgwt?=
 =?us-ascii?Q?kouAaYN7CqVVubjkg7DtIXaSNpEWiZIKW/9NiIwxijDN4ZRbig2zovsRToXs?=
 =?us-ascii?Q?r1lBeSrv8aJb2150AspCvgfWnZaiTl2R6fLG2WhPl5GWxxs2NsDY+vAxEPXh?=
 =?us-ascii?Q?CaUJCrK5YpxQkzG3Cu+EafyIWnubM9nfiMFaTT+90UKui5S5RAF/p59RGybe?=
 =?us-ascii?Q?w1ay049IjFkmzVVe2DHslL0mw865vCsttqYblnfX9RJRiJgkp7PbEFRxzD3n?=
 =?us-ascii?Q?a9EleJXvmrzNYRXj86gW9zHITAttws2Eoj8CcVBnvU4tJkOiAl0sKxTYK8rY?=
 =?us-ascii?Q?i5e29/lUgmNL1j4VzNWBJkYRCR3dZEIcIDBTUtKs81etwHn+1VaHMKatOgDE?=
 =?us-ascii?Q?fH/iGcUPwmb+e3DeFQt7BZD2N59JQgawKK7Ok1uGkVIi1dKSe0vjMxHv06LT?=
 =?us-ascii?Q?WdNpi1B2oAhngYaZZpt7VxD0i6c7AD9ZeTDRG7WEOTCxM/oRttqkx28igeVf?=
 =?us-ascii?Q?YBtLB1jLJaZVTEJslxpjpd0i0jkqLTibWiSIwRuwyQ9uLXpzcTaAaq9LAWNX?=
 =?us-ascii?Q?haTikdWd0IdJpmdZdYPswC7pscZ/TFcIJ9r+b82ybwkWzJOhg38O2ZZYjStD?=
 =?us-ascii?Q?ahKJmemByU20pRGC3ha9Os/sJVifw1+rEszDy0P4q/Hjy9RlK+vqUd8cBKLX?=
 =?us-ascii?Q?6rnvc3wI5kY6pJpzfgipDCRDY21Kivh5vlwM6/LVe6yJ4FVt/h/QbYvUUKJi?=
 =?us-ascii?Q?JkxPbQXRbgfKzAuNQyPwyPg6Fe2ja7JJuWyqqXu0cV9Dhb/yb9p?=
X-Microsoft-Antispam-Message-Info: hn8Kx2BEVd1f65fDNLRnPcjWEDvF8rogD/qtxOhfyeqdWoP4dQlrk33wX3YrJLxzLBMtILM9jrIdQw4/KMFFKr+IGVC3sf5Dx75hLsFbEFMo2A0BDd2FutNI3OAnmZtSjSTicivECqtuMpzJjSB6Geap9sbJS0KC6soL3FgH1FIcb3jekvcT9OBN82DVusRJ
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;6:hPthEAUaNbEtcewHNa1pBwG7HZUs4NpRnXB+oaQS6uhVds0qSTlWHX2oiKyyHouyW7i+w0cdjTh0ugOE5HLEWmTsYG+fgJUGlW3RtH5f+pFoeAHbB0AS3C6P1/sXw/RHGgcYcYNeiUxYYNp/ivhf36fSVjIXMUZ97KH1iVmqOFnOIXcpXLaaoDKxqlL6jfZTvzd9tR6C8l1RRzL5ivDnVlsudmr1IcRZRuflYQBMZ76n8rm0dsrDh7eK/riapJwsuPTqid8XdFcAcTGSDstGA8yRnZ9I0oPaLCeQ1NCO/Po81gPBZgG7HQvvDAVBGcj0qNO9G7IXMOZcZRmQTXUix1hMIirMzMfrGSwDsLNpjPgZfoynvBM8sz+wqXB9kSSMLRPt3oxrh4ieM3suueyrxPX86fZdRaqiX3mspkkll98UC9keWsOZ8iA6JbY7r0QH5rs5XcwJPMk1VfU+ZcDQLw==;5:WLhLfqpvQ5fYRCIahfGWlncbqRPkYOQs9A35ZGGmuAqXzbfqkENzuRL0J43qbGcOHcsQAkvK+wWrZBURigef+Xo9++3H77T+BcxRJNap5bodXX09uXRzu4zHzquWYzhdqETBDcRmGYpwVRGmzu15kWMYEF55p7xs4d35vg/hTWg=;24:bXjdjapsNL+gku7VUDC3OGZ0h2Bj6TOnotkRGRP8RhCoU23qjD9VG8563KNL8Dlc5qi1r3sN/8eryybawIdb+WTUPbuyvuQiBe8D5qhJY3Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;7:fOPWE+eZ8qWq8qi7y3mNZsXPEeRR9miMVBGF/EbIIPqeaZ4kBTqcsJrfmTM+9fr7rgYGiuO3LWUM1sWBNJMgqgUfwWtIjMKsHCJdtwcPil6TR++bX98rUu2BzTzFJdRoi6BSbG8r/Zy7OKoapNV6p9fdb9OA0LLiqMBytaQrYpkzT/dgF0R7LCJvk656t8LNEgdro0aNaL/llNDZM+ZoQyqsr+MykK/cp2lD1HBpxmijWnfT3xhhNhSElUeguPiz
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:54:57.9098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64424a96-615e-4e38-5f0a-08d59331ed65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2570
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh well.  Makes me wonder why might_sleep is testing for
!TASK_RUNNABLE though.

Thanks for the correction,
Joe


On Mon, Mar 26, 2018 at 11:35:15AM -0400, Steven Rostedt wrote:
> On Fri, 23 Mar 2018 13:21:31 -0400
> joe.korty@concurrent-rt.com wrote:
> 
> > My understanding is, in standard Linux and in rt, setting
> > task state to anything other than TASK_RUNNING in of itself
> > blocks preemption.
> 
> That is clearly false. The only thing that blocks preemption with a
> CONFIG_PREEMPT kernel is preempt_disable() and local_irq*() disabling.
> 
> (Note spin_locks call preempt_disable in non RT).
> 
> Otherwise, nothing will stop preemption.
> 
> >  A preemption is not really needed here
> > as it is expected that there is a schedule() written in that
> > will shortly be executed.  And if a 'involuntary schedule'
> > (ie, preemption) were allowed to occur between the task
> > state set and the schedule(), that would change the task
> > state back to TASK_RUNNING, which would cause the schedule
> > to NOP.  Thus we risk not having paused long enough here
> > for the condition we were waiting for to become true.
> 
> That is also incorrect. As Julia mentioned, a preemption keeps the
> state of the task.
