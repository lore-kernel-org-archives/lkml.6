Date: Mon, 16 Apr 2018 11:40:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
Message-ID: <20180416094035.GA19002@kroah.com>
References: <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
 <20180330100407.GB19140@kroah.com>
 <20180402063448.GA250086@rodete-desktop-imager.corp.google.com>
 <CADAEsF8_vptm7p2y2ekj8m6t=bz4pwC1+np7r2-YnAKbnEsA4w@mail.gmail.com>
 <20180402071133.GA62369@rodete-desktop-imager.corp.google.com>
 <CADAEsF9QcH8-TpG+-b2Pde0UysVC5Dzt4iUXpw9ksvReMo42mg@mail.gmail.com>
 <20180402103204.GB62369@rodete-desktop-imager.corp.google.com>
 <CADAEsF_-uv9Xq7RGGz76mZ3JBBetg6vBSB5CtH8B5Xb1YJTYsQ@mail.gmail.com>
 <20180416091748.GB64023@rodete-desktop-imager.corp.google.com>
 <20180416093727.GA8021@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416093727.GA8021@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:37:27AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 16, 2018 at 06:17:48PM +0900, Minchan Kim wrote:
> > Hi Ganesh,
> > 
> > On Tue, Apr 10, 2018 at 04:52:58PM +0800, Ganesh Mahendran wrote:
> > 
> > < snip >
> > > >>             base            patch_v1         patch_v5
> > > >> -----------------------------------------------------------
> > > >>             91223.4      90560.2           89644.5
> > > >>             90520.3      89583.1           89048.2
> > > >>             89833.2      90247.6           90091.3
> > > >>             90740.2      90276.7           90994.2
> > > >>             89703.5      90112.4           89994.6
> > > >>             89945.1      89122.8           88937.7
> > > >>             89872.8      90357.3           89307.4
> > > >>             89913.2      90355.4           89563.8
> > > >>             88979         90393.4           90182.8
> > > >>             89577.3      90946.8           90441.4
> > > >> AVG    90030.8      90195.57          89820.59
> > > >
> > > > Yes, no regression.
> > > >
> > > >>
> > > >> Before the test, I stop the android framework by:
> > > >>     adb shell stop
> > > >>
> > > >> >
> > > >> > Please tell me more detail. What apps are slower compared to old?
> > > >> > Every apps are slowed with avg 15%? Then, what's the stddev?
> > > >>
> > > >> Not all of the apps slowed 15%, The app *avg* launch time slowed 15%.
> > > >> And We will re-launch the test tomorrow: base, v1,v5. We will get the
> > > >> test result in two days later. Then I will post all the app launch time details.
> > > >
> > > > I'm also trying to make stable result in my side but it's really hard to
> > > > get. Please post stddev of each app as well as avg when you finished testing.
> > > > I really appreicate you.
> > > 
> > > What do you mean by stddev?
> > 
> > Standard deviation.
> > 
> > > 
> > > We test 80 loops and launch ~40 apps in each loop.
> > > Below is the app launch time result:
> > > 
> > > app base v1 diff percent v5 diff percent
> > > ----
> > > com.tencent.mobileqq 829 834 5 1% 879 50 6%
> > > com.tencent.qqmusic 799 790 -9 -1% 764 -35 -4%
> > > com.tencent.mtt 659 655 -4 -1% 979 320 49%
> > > com.UCMobile 1149 1144 -5 0% 927 -222 -19%
> > > com.qiyi.video 1557 1579 22 1% 1497 -60 -4%
> > > com.baidu.BaiduMap 1137 1136 -1 0% 1096 -41 -4%
> > > tv.danmaku.bili 3642 3655 13 0% 3538 -104 -3%
> > > com.sdu.didi.psnger 4334 4352 18 0% 4224 -110 -3%
> > > com.ss.android.ugc.aweme 1958 1970 12 1% 1884 -74 -4%
> > > air.tv.douyu.android 3333 3371 38 1% 3251 -82 -2%
> > > me.ele 3183 3182 -1 0% 3178 -5 0%
> > > com.autonavi.minimap 1920 1922 2 0% 1868 -52 -3%
> > > com.duowan.kiwi 1452 1457 5 0% 1349 -103 -7%
> > > com.v.study 3549 3558 9 0% 3519 -30 -1%
> > > com.qqgame.hlddz 4074 4060 -14 0% 4443 369 9%
> > > com.ss.android.article.news 1631 1680 49 3% 1649 18 1%
> > > com.jingdong.app.mall 1448 1443 -5 0% 1323 -125 -9%
> > > com.tencent.tmgp.pubgmhd 1703 1706 3 0% 1601 -102 -6%
> > > com.kugou.android 854 862 8 1% 791 -63 -7%
> > > com.kuaikan.comic 1341 1374 33 2% 2118 777 58%
> > > com.smile.gifmaker 798 686 -112 -14% 642 -156 -20%
> > > com.hunantv.imgo.activity 1560 1616 56 4% 1569 9 1%
> > > com.mt.mtxx.mtxx 1746 1838 92 5% 1773 27 2%
> > > com.sankuai.meituan 3610 3697 87 2% 3551 -59 -2%
> > > com.sankuai.meituan.takeoutnew 3376 3387 11 0% 3325 -51 -2%
> > > com.meitu.meiyancamera 1905 2010 105 6% 1870 -35 -2%
> > > com.tencent.karaoke 888 906 18 2% 896 8 1%
> > > com.taobao.taobao 3344 3406 62 2% 3368 24 1%
> > > com.tencent.qqlive 1314 1345 31 2% 1499 185 14%
> > > com.tmall.wireless 3746 3735 -11 0% 3699 -47 -1%
> > > com.tencent.tmgp.sgame 3250 3513 263 8% 3707 457 14%
> > > com.netease.cloudmusic 2550 2570 20 1% 2546 -4 0%
> > > com.sina.weibo 2201 2240 39 2% 2191 -10 0%
> > > com.tencent.mm 638 645 7 1% 690 52 8%
> > > com.immomo.momo 1536 1554 18 1% 1563 27 2%
> > > com.xiaomi.hm.health 915 926 11 1% 888 -27 -3%
> > > com.youku.phone 1881 1820 -61 -3% 1880 -1 0%
> > > com.eg.android.AlipayGphone 1536 1557 21 1% 1624 88 6%
> > > com.meituan.qcs.c.android 3140 3533 393 13% 3171 31 1%
> > > -----
> > > average 2064 2095 31 1.50% 2085 21 1%
> > > 
> > > 1% is in the fluctuating range of our tool.
> > > So no obvious regression found in app launch time.
> > 
> > Thanks.
> > 
> > Greg, Ganesh finally confirmed there is no regression.
> > Could you pick up the patch?
> 
> If there is no regression, and no speed up either, why is it needed?  :)
> 
> And is app launch time really the best binder benchmark?  What about the
> throughput and latency tests?  Do those show any changes?  I'm kind of
> lost as to what is really happening here, sorry, the merge window is not
> the time for me to be keeping track of this type of thing...

Also, this patch is not even in my to-review queue, so it needs to be
resent at the very least...

greg k-h
