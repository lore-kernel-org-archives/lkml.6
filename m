Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeCWF2x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 01:28:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:36189 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbeCWF2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 01:28:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="gz'50?scan'50,208,50";a="210641633"
Date: Fri, 23 Mar 2018 13:28:13 +0800
From: kbuild test robot <lkp@intel.com>
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: kbuild-all@01.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        sboyd@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 4/4] video: simplefb: switch to use clk_bulk API to
 simplify clock operations
Message-ID: <201803231355.8w9QsOLo%fengguang.wu@intel.com>
References: <1521602391-30356-5-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <1521602391-30356-5-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.16-rc6 next-20180322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-new-APIs-to-handle-all-available-clocks/20180323-122451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-randconfig-x007-201811 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/video/fbdev/simplefb.c: In function 'simplefb_clocks_enable':
>> drivers/video/fbdev/simplefb.c:250:42: warning: no return statement in function returning non-void [-Wreturn-type]
    static int simplefb_clocks_enable(struct simplefb_par *par) { }
                                             ^~~~~~~~~~~~
   drivers/video/fbdev/simplefb.c: In function 'simplefb_probe':
>> drivers/video/fbdev/simplefb.c:442:2: error: too many arguments to function 'simplefb_clocks_enable'
     simplefb_clocks_enable(par, pdev);
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/simplefb.c:250:12: note: declared here
    static int simplefb_clocks_enable(struct simplefb_par *par) { }
               ^~~~~~~~~~~~~~~~~~~~~~

vim +/simplefb_clocks_enable +442 drivers/video/fbdev/simplefb.c

fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  239  
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  240  static void simplefb_clocks_destroy(struct simplefb_par *par)
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  241  {
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  242  	if (par->clks_enabled)
1904158b drivers/video/fbdev/simplefb.c Dong Aisheng   2018-03-21  243  		clk_bulk_disable_unprepare(par->clk_count, par->clks);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  244  
1904158b drivers/video/fbdev/simplefb.c Dong Aisheng   2018-03-21  245  	clk_bulk_put_all(par->clk_count, par->clks);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  246  }
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  247  #else
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  248  static int simplefb_clocks_get(struct simplefb_par *par,
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  249  	struct platform_device *pdev) { return 0; }
1904158b drivers/video/fbdev/simplefb.c Dong Aisheng   2018-03-21 @250  static int simplefb_clocks_enable(struct simplefb_par *par) { }
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  251  static void simplefb_clocks_destroy(struct simplefb_par *par) { }
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  252  #endif
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  253  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  254  #if defined CONFIG_OF && defined CONFIG_REGULATOR
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  255  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  256  #define SUPPLY_SUFFIX "-supply"
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  257  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  258  /*
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  259   * Regulator handling code.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  260   *
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  261   * Here we handle the num-supplies and vin*-supply properties of our
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  262   * "simple-framebuffer" dt node. This is necessary so that we can make sure
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  263   * that any regulators needed by the display hardware that the bootloader
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  264   * set up for us (and for which it provided a simplefb dt node), stay up,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  265   * for the life of the simplefb driver.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  266   *
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  267   * When the driver unloads, we cleanly disable, and then release the
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  268   * regulators.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  269   *
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  270   * We only complain about errors here, no action is taken as the most likely
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  271   * error can only happen due to a mismatch between the bootloader which set
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  272   * up simplefb, and the regulator definitions in the device tree. Chances are
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  273   * that there are no adverse effects, and if there are, a clean teardown of
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  274   * the fb probe will not help us much either. So just complain and carry on,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  275   * and hope that the user actually gets a working fb at the end of things.
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  276   */
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  277  static int simplefb_regulators_get(struct simplefb_par *par,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  278  				   struct platform_device *pdev)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  279  {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  280  	struct device_node *np = pdev->dev.of_node;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  281  	struct property *prop;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  282  	struct regulator *regulator;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  283  	const char *p;
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  284  	int count = 0, i = 0;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  285  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  286  	if (dev_get_platdata(&pdev->dev) || !np)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  287  		return 0;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  288  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  289  	/* Count the number of regulator supplies */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  290  	for_each_property_of_node(np, prop) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  291  		p = strstr(prop->name, SUPPLY_SUFFIX);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  292  		if (p && p != prop->name)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  293  			count++;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  294  	}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  295  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  296  	if (!count)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  297  		return 0;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  298  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  299  	par->regulators = devm_kcalloc(&pdev->dev, count,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  300  				       sizeof(struct regulator *), GFP_KERNEL);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  301  	if (!par->regulators)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  302  		return -ENOMEM;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  303  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  304  	/* Get all the regulators */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  305  	for_each_property_of_node(np, prop) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  306  		char name[32]; /* 32 is max size of property name */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  307  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  308  		p = strstr(prop->name, SUPPLY_SUFFIX);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  309  		if (!p || p == prop->name)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  310  			continue;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  311  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  312  		strlcpy(name, prop->name,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  313  			strlen(prop->name) - strlen(SUPPLY_SUFFIX) + 1);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  314  		regulator = devm_regulator_get_optional(&pdev->dev, name);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  315  		if (IS_ERR(regulator)) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  316  			if (PTR_ERR(regulator) == -EPROBE_DEFER)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  317  				return -EPROBE_DEFER;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  318  			dev_err(&pdev->dev, "regulator %s not found: %ld\n",
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  319  				name, PTR_ERR(regulator));
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  320  			continue;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  321  		}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  322  		par->regulators[i++] = regulator;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  323  	}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  324  	par->regulator_count = i;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  325  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  326  	return 0;
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  327  }
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  328  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  329  static void simplefb_regulators_enable(struct simplefb_par *par,
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  330  				       struct platform_device *pdev)
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  331  {
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  332  	int i, ret;
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  333  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  334  	/* Enable all the regulators */
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  335  	for (i = 0; i < par->regulator_count; i++) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  336  		ret = regulator_enable(par->regulators[i]);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  337  		if (ret) {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  338  			dev_err(&pdev->dev,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  339  				"failed to enable regulator %d: %d\n",
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  340  				i, ret);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  341  			devm_regulator_put(par->regulators[i]);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  342  			par->regulators[i] = NULL;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  343  		}
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  344  	}
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  345  	par->regulators_enabled = true;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  346  }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  347  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  348  static void simplefb_regulators_destroy(struct simplefb_par *par)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  349  {
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  350  	int i;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  351  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  352  	if (!par->regulators || !par->regulators_enabled)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  353  		return;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  354  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  355  	for (i = 0; i < par->regulator_count; i++)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  356  		if (par->regulators[i])
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  357  			regulator_disable(par->regulators[i]);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  358  }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  359  #else
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  360  static int simplefb_regulators_get(struct simplefb_par *par,
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  361  	struct platform_device *pdev) { return 0; }
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  362  static void simplefb_regulators_enable(struct simplefb_par *par,
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  363  	struct platform_device *pdev) { }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  364  static void simplefb_regulators_destroy(struct simplefb_par *par) { }
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  365  #endif
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  366  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  367  static int simplefb_probe(struct platform_device *pdev)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  368  {
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  369  	int ret;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  370  	struct simplefb_params params;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  371  	struct fb_info *info;
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  372  	struct simplefb_par *par;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  373  	struct resource *mem;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  374  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  375  	if (fb_get_options("simplefb", NULL))
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  376  		return -ENODEV;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  377  
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  378  	ret = -ENODEV;
129f1be4 drivers/video/simplefb.c       Jingoo Han     2013-09-17  379  	if (dev_get_platdata(&pdev->dev))
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  380  		ret = simplefb_parse_pd(pdev, &params);
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  381  	else if (pdev->dev.of_node)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  382  		ret = simplefb_parse_dt(pdev, &params);
5ef76da6 drivers/video/simplefb.c       David Herrmann 2013-08-02  383  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  384  	if (ret)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  385  		return ret;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  386  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  387  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  388  	if (!mem) {
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  389  		dev_err(&pdev->dev, "No memory resource\n");
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  390  		return -EINVAL;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  391  	}
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  392  
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  393  	info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  394  	if (!info)
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  395  		return -ENOMEM;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  396  	platform_set_drvdata(pdev, info);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  397  
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  398  	par = info->par;
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  399  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  400  	info->fix = simplefb_fix;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  401  	info->fix.smem_start = mem->start;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  402  	info->fix.smem_len = resource_size(mem);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  403  	info->fix.line_length = params.stride;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  404  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  405  	info->var = simplefb_var;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  406  	info->var.xres = params.width;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  407  	info->var.yres = params.height;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  408  	info->var.xres_virtual = params.width;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  409  	info->var.yres_virtual = params.height;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  410  	info->var.bits_per_pixel = params.format->bits_per_pixel;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  411  	info->var.red = params.format->red;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  412  	info->var.green = params.format->green;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  413  	info->var.blue = params.format->blue;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  414  	info->var.transp = params.format->transp;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  415  
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  416  	info->apertures = alloc_apertures(1);
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  417  	if (!info->apertures) {
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  418  		ret = -ENOMEM;
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  419  		goto error_fb_release;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  420  	}
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  421  	info->apertures->ranges[0].base = info->fix.smem_start;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  422  	info->apertures->ranges[0].size = info->fix.smem_len;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  423  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  424  	info->fbops = &simplefb_ops;
df0960ab drivers/video/simplefb.c       David Herrmann 2013-08-02  425  	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
9e210be6 drivers/video/simplefb.c       David Herrmann 2013-10-02  426  	info->screen_base = ioremap_wc(info->fix.smem_start,
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  427  				       info->fix.smem_len);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  428  	if (!info->screen_base) {
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  429  		ret = -ENOMEM;
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  430  		goto error_fb_release;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  431  	}
1270be4a drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  432  	info->pseudo_palette = par->palette;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  433  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  434  	ret = simplefb_clocks_get(par, pdev);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  435  	if (ret < 0)
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  436  		goto error_unmap;
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  437  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  438  	ret = simplefb_regulators_get(par, pdev);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  439  	if (ret < 0)
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  440  		goto error_clocks;
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  441  
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11 @442  	simplefb_clocks_enable(par, pdev);
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  443  	simplefb_regulators_enable(par, pdev);
a3accfd7 drivers/video/fbdev/simplefb.c Hans de Goede  2017-01-11  444  
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  445  	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  446  			     info->fix.smem_start, info->fix.smem_len,
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  447  			     info->screen_base);
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  448  	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  449  			     params.format->name,
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  450  			     info->var.xres, info->var.yres,
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  451  			     info->var.bits_per_pixel, info->fix.line_length);
9f192a92 drivers/video/simplefb.c       Tom Gundersen  2013-09-07  452  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  453  	ret = register_framebuffer(info);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  454  	if (ret < 0) {
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  455  		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  456  		goto error_regulators;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  457  	}
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  458  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  459  	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  460  
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  461  	return 0;
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  462  
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  463  error_regulators:
814740e7 drivers/video/fbdev/simplefb.c Chen-Yu Tsai   2015-11-17  464  	simplefb_regulators_destroy(par);
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  465  error_clocks:
fc219bfd drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  466  	simplefb_clocks_destroy(par);
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  467  error_unmap:
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  468  	iounmap(info->screen_base);
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  469  error_fb_release:
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  470  	framebuffer_release(info);
bf2fda15 drivers/video/fbdev/simplefb.c Luc Verhaegen  2014-11-14  471  	return ret;
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  472  }
26549c8d drivers/video/simplefb.c       Stephen Warren 2013-05-24  473  

:::::: The code at line 442 was first introduced by commit
:::::: a3accfd70e166af4956a686ffcdf414702c0a13e video: fbdev: simplefb: Separate clk / regulator get and enable steps

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBqJtFoAAy5jb25maWcAlDxNc9w2svf8iinnHXYPiSVLVry1pQMIgjPIEAQMgDOSLixF
HieqyJJXGm3if7/dADkEQHBcL4dYRDe++7sb8+MPPy7I6/7py+3+/u724eHb4vfd4+75dr/7
tPh8/7D796KUi0baBSu5/RmQ6/vH17/f3p99uFic/3x68fPJT893p4v17vlx97CgT4+f739/
he73T48//AjoVDYVX3YX5wW3i/uXxePTfvGy2//Qt199uOjO3l1+C77HD94Yq1tquWy6klFZ
Mj0CZWtVa7tKakHs5Zvdw+ezdz/hst4MGETTFfSr/Oflm9vnuz/e/v3h4u2dW+WL20T3affZ
fx/61ZKuS6Y60yoltR2nNJbQtdWEsilMiHb8cDMLQVSnm7KDnZtO8ObywzE4ubo8vcgjUCkU
sd8dJ0KLhmsYK7tSkA5RYReWjWt1MLN04Jo1S7saYUvWMM1pxw1B+BRQtMtp42rL+HJl0+Mg
192KbFinaFeVdITqrWGiu6KrJSnLjtRLqbldiem4lNS80LB4uNSaXCfjr4jpqGo7DbCrHIzQ
Fetq3sDl8ZvgANyiDLOt6hTTbgyiGUlOaAAxUcBXxbWxHV21zXoGT5Ely6P5FfGC6YY40lbS
GF7ULEExrVEMrnUGvCWN7VYtzKIEXOAK1pzDcIdHaodp62IyhyNj00lluYBjKYHp4Ix4s5zD
LBlcutseqYFTItYFVu6MUHNdW6VlwcwIrvhVx4iur+G7Eyy4c7W0BPYMFLlhtbk8G9oP7Aw3
aYDt3z7c//b2y9On14fdy9v/axsiGFIAI4a9/Tnha/jHyxOpgzVw/bHbSh1cUNHyuoTjYB27
8qswEavbFZAHHlQl4X+dJQY7O2m3dLLzASXc61doOQgybjvWbOA8cOGC28uzd4dlabhgx7wc
LvnNm1Fo9m2dZSYnO+H0Sb1h2gARYb9Mc0daKxNSXwPhsbpb3nCVhxQAeZcH1TehFAghVzdz
PWbmr2/OAXDYa7CqcKsp3K3tGAKuMHNW4SqnXeTxEc8zAwIhkrYGDpTGItVdvvnH49Pj7p+H
azBbosLJzLXZcEWzMwGLAyeIjy1rWWYuTyHAH1Jfd8SCFgpkdGsYiMWA5VpQ1MmROzZ0AFgF
UEedoOdbQYDYcCbfaDVjA7kD7yxeXn97+fay330Zyf2gNoC1HMtnNAqAzEpu8xBWVQzUPq68
qkBzmPUUD2UjiCnEzw8i+FI7ARvzeikF4dk2EMogKuGormcGJFbDNTmxR0CI5LE0M0xvvGQX
YLLEM4G5QkHIehESSVmjiDZsfjtO7laB4KJopxjZwoD+pkqZCu0QpSSW5DtvQK+WqFZrgtrq
mtaZC3PycDMhlINuxvFAVjfWHAV2hZakpDDRcTQwczpS/tpm8YREXVJ6M8YRor3/snt+ydGi
5XTdyYYBsQVDNbJb3aB8FY48DowIjaDAuSw5zfCh78XL8HxcWzQE2D5IBO7EtAmH8Qaxat/a
25c/F3tY8+L28dPiZX+7f1nc3t09vT7u7x9/TxbvDBJKZdtYTzCHqZAs3L2M4MyqC1MiF1IG
MgQQbThCCus2Z5kRUMOh1RhcLTZ5M2wYMwRcZdq4jHcxECLsjhtZD5zqzkjTdmGmd6lA9Ahl
OwAH5iMFo+wKbi001CMMlFhpE+5oOg5ssq5Hsggg3kpmS1o4uyOCVaQBZyTQ6GMj2C+kCgxx
DwEum5ANQgops4reLUDSAg8rMVPA2m/eBUYYX/fezqTF3fPYXEscoQIhzCt7+e4kbMc7AQci
gJ++G++AN3bdGVKxZIzTg5HmdE4LxpY3nsDuLj1z5wzUAkUXILQNOidgonZV3ZpA7dCllq0y
4WGBKqTLrCYt6nXfIQv2IL+kYwiKl+YYXJexlZHCKyC5G6aPofQGeR5FgVa3R1dQsg2n7BgG
DIJseHSbTFfH4IU6CnYqKYtgJF0fsEDx5IQpGE2g82joD7Qg+ZvopuEcNDRl+sMVedyD92WT
vp7w0AKeJwhQaBX6NCBaQKfHRDFwX+xsIoXB4TubXpdhsAK+iYDRvFoNLHJdJtY2NCRGNrTE
tjU0hCa1g8vkOzKgKT04cWhluLvF2EhDsyZlgh27xKjmbWgONmDM8AasmeDAPZfz8vQi7Qjy
mDLlLCAXLUn6KGrUGhYIMh9XGBytqsIdeameWXwyqQA7nCOhBOsA3kKzsZsYLP7Cx+aQEnDp
PSQza7UiTaT6vdXu1XzQ6gRk+t01goeiOxDQrK5A5YTe+/wBgVvbVW24n6q17Cr5BN4Ihlcy
2j9fNqSuAsJ1GwgbnAkWNphV5JsTHhAiKTccFtUfW3AO0KUgWnN3LSOVrhhdKwlHgjYSGNE5
4lzjSNciGGxo6ZJLG9sLsCFg70j2IPiODOoPEZkaHYyI+KbUglTl/LzwOA4hpXGL0LOhwy2O
BIyxojIrVDwjwODdwWgevUF6enI+sRv7CKvaPX9+ev5y+3i3W7D/7h7BciRgQ1K0HcEEDoyl
/OB9+AaBsLluI5w7k1nhRvjenbPZIhIfAo1h0MTUpIjYqW7zug0R4eT0kg0+dGZyh4RKFK2t
TgPjSRHxsGXCKZZuA+Z6xWni6IGtU/E6MjSdJHKUF+xEesTo1oa2fvtOuqiaXc3dYjBGOgIw
vWevcPxfW6HA1SpYnT2fPkiWhbn5XCgdGAEYGdUbReN9bm3gSHPKcRttE/dIyBlpAQ1KMM7B
KfChi3AgDqSN9hksLg0urNOonm/VzGYBoHbyHXwr+GpdldMaVdv4TADTGhQWb35lNL50hxbJ
2TH44UZcSblOgBj1hm/Ll61sM66rgbtCh6/32DNCACS05dX1oPWnCGDJ9bGb7MJ8MNEHJrvt
ilsWexgHSxnMlGswmtAXd5rN9UiG1GwJsrApfaqiv+qOqPRMaJ07CMDz8iGBrbbA64x4uZ3A
BL8CmhrBxq0htRLQigOCaHUDjgwcFw+VdSoLM3e4IrpEB8IZnZZhCNf1yA2SmX8Qd7o/l7IV
KYG7Yx5ZMz1X8MC8N1P58Fd8yZ7uvFNEhcJcRnrgvtUHZ2dgpWxnwvxc0c6Hh4Zwb2bxhlEU
zB1IHhvZQjPtrucSDEFVt0sem85B85xoAQx3mCgR3IUkxmgMhGtvZryVCSpcYFuTGedpgg18
ILNxjylqHAy3K4wxwcmBGZASjD967lA8yVQa/ZVUKk4DMDPCp8HwHuszNpg8yeG5bA5o5JQ2
hSz7K1aMorYLrCxZtjVITZTfaEjqkHQPIshBnBKdZr6mucgEgV1h1Dcn/uJeH2LykOp6EG62
jogr2DAxq+w1Y8KxaJ3kyt1sDcQEdhxdb0EuhOq8LtHA7TNnZxMAGTRG6GljLGbUk1V1RPW6
RW/6JCpdZxEdjnTeD6mHHILeXv2/kI+YRqNesaCgbNApYPl5UNrdE9AMjlpdm87KOPd7gGrM
xbWhRhhaBh/F58So3Pz02+3L7tPiT2/Dfn1++nz/EEU6Ealfb2YmBx2MqsQFSGGZI3MovlDA
yQCvQiaD9Bhn3Xn2rkKc8+6XObk4WA7eslgx5PrghNCgBBctFCXOITFoiF+eBDEuz9mZaQae
d3HNGmyaNhAYRR9nO4xTFyWpMqNgHMNQw+HSPrYstDiGCEdhltnGKN00hkMsW2puM5GSG+DW
MlySC9KJ0uXinVrTM+vbFsmyoKEzH6dt4mM6LXo5YbbEbRcsFanIgTLV7fP+HitVFvbb113o
OxGw6ZyxCe4tRlBCyQdeXjNizAI62grSkHk4Y0ZehceSInCaF0UpHilnZFaKqOSWaSD9nFRJ
UDU3lIcigV/l9ixNFTWPUwuQtiMoN6Mlmuc7C0KPdhWmlCa3HExnlNysExNO8AaWb9oiOxsm
H2C7rn4hO+vomsEwoHHYOEcWrS7F0eWb5cy+QeDr8Jzz/nPbfAdjTUBGfQeHVfx781ybzcWH
7yAFXDy7XeQ88bFTlMfcCG0bDt3kwI5cLszdHzus5QgDGVz6QG4jZZRQH9pLMDFwEZmpBxRa
BfJhyNz7xiAw4ptxmiP5/n7Iyzd3n/8TlGrAZo6tJ4e3vi6ygm+AF+GiFYnzt8Q0p0GYqnFV
O6BFFBisbZPJtRyKcIiV6ENqEeTenUrynYH35bYJ/QRfnzUDxJnmYIfAgqtrKB2aSzuPKPOQ
tLPe5rtO2kcDZwjJdQWr8B90AOOMfJ+mOeiD56e73cvL0/NiD/rA5WY/7273r8+hbkBtFhtE
UcUTSpGKEXB1mU9xJCBM/g1wrOtJ4EI5hRg3FmDShnMswZytuMuRjflDZpWcYwPQzWAGljYe
ll1ZsJKxZm0MNB/GQ4RhniwlI4IfWPB8Lm3E+NgSnbeWR5xambwWQxQixlUeS31xVEii4LMD
6ZKevTvNG+N9ARvmOsC8b0rwLWYqVg/M1NfkVITXrU5uDYbioFcuJxkp4D/r/cnOhUyyUmB1
rZjecANu6zI2z4BACArOcOCh7UhK7oByYLb8IbCcDF9vxGEZo57ZiIOhdXzK7xcpHFCTPDH4
ZoWU1ucfRil6/uEiL17fHwFYk6++QpgQeZoQF3MDgodpeSt4ntZG8HG4yJk3PSxK74n1zDrW
v8y0f8i3U90aOaOcnBvMZnS92PKGrriiMwvpwWd5YSBYTWbGXTIQysur0yPQrp65HnoNFtPs
IW84oWddvl7QAWfODrXGTC9UnzNSoff8Ying+Bszp30Bsq+V+CVEqU/nYV42oubCgEo8NGpH
BZ6vT6qZVsRgIPe4oY8zXpynzXKTKCGwl0UrXHCkAku+vr58H8Id01NbCxNoe0QGuehXPG0G
CT5tpEDopM0M4iJmglkSPQ5YKWYP+ZSwjYm2xgI2bYMtl2EU2Wy5jMqfuRSi7VasVuFojSve
NljLkwhtI7J5KgcTdCrkBcXMb76wdKhjmo2JDggbWYPEJPo6JzE9TqAX+k5JTMZRGEadMZiW
EqfMNGqmJWZSsSyg0HLNGieCMdiZGiuUpSYDNGFVUM2WhOZW3eOkVDI0eyqJVX/jA3MiW8cw
dMRIo1mBvTId02eKEt5YgSkIR7IZItfe/gtyq1+eHu/3T89RkCrMUfSM2SSZ+wmGJqo+BqfD
c4zx8gMcZ/eg1z6zdX/O3UaEz2biL0Q7vSh4avwZVfGrkLusBPlTBHYt/7BOL0MzJAXo2Kps
ZIpTLak3sUeROTT6HR/rFkuJsRnDt06QVlFe0N1wKIOcOFMtDwZpJBZkJvZD33Set5R66MV5
3lBZwnqqyjB7efI3PfH/hQtQJM3huDAqKUvdWZ+9zXgrMGHHGqqvVQqtQLR5KMk8EnHuwjyY
1YwO6UdXjhwQI6+RfOrBCMU64JZdHvZytO+wKEGalsR1NIcVeViuksZ3jkfrnJL0/QJfZxwO
GSWUVT41wkQRW4xRcz/oJKMyBGmXbfpYpeSGguGfGbg/iLBYNc4O9IaqfxiCE+cUhqrB+FfW
Lc6pmvNoen+LAxpyv82uosCyjSSVgVUZdC5kNi2GP0KVBaiQkNG8ES8xJTM2rk1wg0N4xKWE
fPF2qS/PT/4VP2mbd5zC2s4AkmXQXD5tPr3ic+d2pdyTjGw6iYGSQQssjAxI6BXVQVDn8weh
LzL1tlJYVK+PGXbNiAEL7zDKzcyabpSUAbvdFG2kGG/OKpCJuX5GDM+yRoXSv6WCq1F572vo
5XgsiDP0XOKeaA0lIFEIDisjnETE+or1jGvnKrK6pIB8ieWlIPBWguiJmlHIRlMbIsJxRm9X
gMePQR7dqhnK92oL32RgsmR7eXEeWfOr3nicYRurA/WCX50hDbf8hs22Dzzcs8QoUBM0R8GY
7Earc0A+jTVJqgvA5Ddwn2h3EBeGjMFpoZSLVUTSL/ApBI/uklW5VGtfPBCIz5vu9OQkkn03
3bv3J3lNetOdncyCYJyTzJSrm0uApPb0SuNjiHy8m11lcxoo4DgavkB6GrX1aa+sg6CZe8qD
13Wsv6ucgv7vIl2/khZLJPqi/DG5BVoAoxkiRMjt04dOQqRAVvgKu01pZCxzfLgd5sjaUbLE
SqS6tEElo7dsn/7aPS/Asr39ffdl97h3sU1CFV88fcUEWBDf7JPngQbu36GOwdKDneTfsKJr
W9eYjjdTYKxyUIuXQfJjrJFGUM2YipGxpY+vjuJMuCSug+VuTYDEX7MkKhy29i8wIyKL4Mss
NYlkEXPCH0BRedX2ozfhgyKDgduD3GBYooVfg2nviNNM0ry+/gKfWfeVCdhFhc+qXUtfKenn
d56GCZ6uB4nCofJrmXU1/FiKar+cdJL+3uLh8LlJZWa9F4ej2aaTG6Y1L1n4zjkeidFBmc6N
Q9J9F8SCRXudtrbWJmlKbN7A7HJu6IpMO5QylkQhzMVMNIM7j2oshxNhBiO6NHmDn4DjF2Yx
cLIYrkROcDvYjIhKpiPLJWghfNE4N07vLk/GoK2xEjjBlEcrVfwYTim2CuzQMt1dCssQ5kyC
GzdCkQRldgVukWDJER5npsLD4bKPgcTDmmIuqY59Z54PhacimF3JI2ialS2+BcXaRpdVlk2d
C5mM/E0UmxS3Du190WQ8BQKyCyiVraasmbDdFbgeM7kEzCBKBVQzlxgeTh7+zrKtt/KmxdEm
a4W4OBCgo24NblGJ6KMDLT3k+aZqDBFKObrJ41KVj3Qi1+VoCPtxcMgIeF01iX7JAVUR2M3b
rq8qHx54Lqrn3X9ed4933xYvd7d9pVNUc4YiIpzs0JN/etiNynhYV2QE9G3dUm66GvysrHyN
sARrYgGAnIlPGs2IR2Wr6hmy9hZjekBuzcXry2BDLP4BrLjY7e9+/mcQM6MRWSKzLiVa7XnC
cmAh/OcRlJJrRnMs78GkCWQ/NuGMcYsfIW4bJk4w3evw5IkGZ6hEwSGeXaQwOVJGyMeW63U6
3rHUHUo4G7+nCEBotNTM/YZEv/ioJ5eb2VGVzssHByOG51xMN2VfYDOa870wRQqYkPXtpx2G
VAG2W9w9Pe6fnx4e/HPtr1+fnmFaj1fuXu5/f9zePjvUBX2CP0yMgu1/PL3sg2EWn57v/+sL
Rg4o7PHT16f7x33IdbhsEAgu2DVZInZ6+et+f/dHfuT4KraYTrB0lS+l6n8sp6+6H3nI5F5B
GopeRWBsu++VTtMc4IJEtWINs+/fn+RTZksms5aSKLumiKmDJjnu0TOC1Zc8ZxU5n/LaVMUg
79jfu7vX/e1vDzv3g1ELF0LfvyzeLtiX14fbxL0oeFMJixXJ4+bgIw6ju6oNLNI/xJWwgnnF
wDoI3yH1YxmquUrfJRB8kh26ZR4Xm3M1Sh4qeJgzw1XELwV6t+ws/XWUvqaGy8jXhjuKPkCM
gqFlDoqi2e3/enr+E7TD1AtT4E2xJMWPLSC2SM7pwNK0EBu/J7hjAK3O6uQqKQGBb6dM8zEY
hJq26LDsZC5Ogzg+9JgP0PlBMLBr7Fy5I57cmuUsI97ER8SVf62FPy+R12PqUNDZuSRXtv5K
daoJrtF/d+WKqmQybHbu/txkiKCJzsMdRaiZn7vxwCWyARNt7u2Zx+hs2zQsecjaAKHKNZ95
ROY7bmxe8iO0LYdxZ1Eq2R6DjSvLrwFvriMztf8IY2bmUP3qkRHn4Y6qphsIUQ7HNumHiY4+
whz96lOKcXyAgrG0L3Jj0mSpGprjHeANzHKvw9Bk+x0MhAL14PuYPHfi7PDn8sATmcM64NC2
CJMvg1we4Jdv7l5/u797E48uyveG/4+ya2tu3EbWf0W1D6eSqp0dS7JleavyQJGgxJg3E5Qs
zwtL8WgyrnjsKVuzm5xff7oBXgCwG8p5SMbqboIgLo1Go/E1pa5g/C3sybRbtDMSz7Fp1AEl
pG+to7ZoooCzVkW98I2uhXd4LbzjC+uQJSUdA6O4SUpDQ+iymbHpSHkH7+L8QF2cGamL8VCl
6qn4qltasICRn9z+dEepmCyZ1KMOB1qzIIPsFDvHszh1kFY/lGL0tK8Rkc+pqI55toDu5m/r
g/MIqibi+VKsF016f+59SmyTBXSUGvTKKOR8YCGCHTrr29MUQxuXNczQNJAyiR8sjnqk3Dwo
UxPW4Ky0rq+BRH9j0KyEJpI6QxvKaLaDaQO24AlsaBcRdFTQYBSNWPjJiY2w6LAQgsZgI5BC
nquzKIuqQG1GYE8tA4qKxI5qVqM4om1NrnZ2Msy4LhlOUoVOhQYeVEsdbpE3MO2qJU75tdFy
RNd1bbdOt7Dtp8xhKCQ3z570b+UxsG/ytIwgw3BZtqBRCyBNf7tNk/aRVEutY8bCavlgpY+8
AabMePqOmkTjPPaW+V5tZ95hL/jtt6eX4+dJizBJjd89bBv0wLAePR3efj+euCfqoFqLWvUh
NWlHgvYwNwV0PxG9PDycIxYKdVRCCsf6Xd4SqRb3iP+tTwR7IZOjHoCd5ONXT8PXCGwYRVW7
QvBClGIYS+m9jFdkFK8Fpq4U7H5jN0aAS8p//w0FGaONVQVqbbjk9IdmmYMdkZe0gU/fYsRy
MUrT4dsqEbYsI/05qkYlMK5uTFeTmyJmgbzbCnTxUxVHibL0z/TNfEbh00Ezg0BS9pPYorv3
3jW1H8l2cKBmWsrPkh++wRUAFbhO3YGBzRTcEyPgP4v/7xhY8GNgwY4B2kwdxsCCHgND1y6o
cWBCdJcLru0XulVwzuAz2nszEhj3zsLbPQuurRdEYw/enyqJ1gIlxMprzTVRGLLbeRkyw7Ni
0OJqB/C1JQe15WeBn2ChJZSGRlYa5MIVz8qC3mQgc1XNFkt69qezmnqNNNdn3Vbu7yZZZ9AC
eDvOMhNb7g5q2fblGARB7UalFT3Vkoi6qJKWF7OpdTtvoDbrHeNQMWQyTiYSYS5IMOXUBEdM
Q8PFF9RBaplSeKk5KGFngAzarzW7ots/KGlUpHJT5MwiskiL+zKgopMSIQR+75WlSwdqk6ft
HwpKDcz8vCYDMo1HtO4YPh62I/0rjL6TbfSRUmd3P44/jk8vv39sr286512tfBOu7mh11PI3
NXXC0XNj0zfbUfVUcogYeD+mqu3c3ZhemWFUHVH7t0dVlLH/E2pxx2zQNHsVU6WGK8Y6Vdw1
WcFIjrd6Up3q1YJoksiMY+tb5K5tqXGNNsUtvaHtJO7OtATGbfPuQ5SI78ZCIxGqcpsN7R/q
uz/xVx0PqjwvHYJzjAmvvV32NzvMMk7iQl3wHLvJ2rJ/+cf3L09fXpsvh/fTP9rt8vPh/f3p
y9PjeIMMi4J0vx9IiBeRsD4CJVGHSR4J+spUJ6N8FoyN2IrE90wzIXNrnoK0BAeTqaO6IZ59
FeSO2Zb07AX1HGxR6GW+E/AgwPaNyECbmu8gjwc6AWXZOFgkynOtGN6yA26v2vKh83yTAoaZ
McJCS1FFOeKyyAITAFDnXKAvA4VqYazgPa37k2Gm1gpucKKA/h5DJKcHrCGRsac25pvGcWC9
WFGKfKcPZimzQi9shoXaURzHvMYkoORtxggmunOruA79rGQOQTRiLVXZjXS9bu2Js+OosiTS
Oe5OcK/qk8pDMiyhKo0vrWKFBm5d0LIBmFtoX+Vf5G65GTLa/8gN6gqRpuVDYwOVru6sqaXg
OetKBBkPGaMOnzAcRwd42sesk9Px/URYJuVtvRa0T1sZqVVRNtDPCR0etwky2AwOGBbl4fGP
42lSHT4/vSLO0en18fXZcF8EYBkaliX8gtmTBQh4uRNOn1fkTdOqkD3sfbD/FxiaL+0Hfj7+
5+nxaEQtdAPwNjH9q4vS8oKsyjuB8X3mnH+Asd1gFFUc7Un6hqBDt9j6QVFFSevhh4D6uDAw
JhT8wA2dTViFmU1Y33etAb8mkW6DaBy5gbK7kLmDrJh7H1emPi434zQP47w1aAFl563sOAXE
VRURqbwRTt6RTQWz9USgJJHGTOqYVW3cT9FxXM8/jqfX19NXdhitavfWJtbV7A74fRcG1u9N
mGwD83RqoOFAglYhWZtL5zs7Rl7cJvTO1xBahZKyKwyJoN7Mb5lXkBBiBn9+n5ixKgZn3DxD
jTKSzjRXE6wX+z1Tv6za8TXcbex4u5VP/j5xDwmCGLRxxWSpAeZtmJGsc5oZmyy1Tnk6CoaZ
GlT45YBhK5Kdu0CRpHkdvhVKdtYiFa9x6zql9EzLUuBnUBMFi41BIWIdGZfEezG8at+h6aEI
BqQYH5MmKyU3pjTqRifUr2R5YZjxzPo2oZgdSqtWcN13vhyPn98np9fJb8fJ8QUd6J8xGmvS
7uGnxpLQUtCbrVAYVb4HBQJ/MfRQZiZSUz9bZaaycg2Aj1V8m5hLt/6tdNOImOTlth5R1+V4
H3pD3tULEmsLjb/5a3jI1Md75pqRIBasZTWHotxg45LeUOeILgQDb53QfhTk5ibOVUtobB2I
1I0rJjeRckG1NsvhbRI/HZ8R2fvbtx8v7f5w8hOI/tyqaGt5wyLiiNxOAafMry4v7fcpUpPM
Rp8HjPkcGUxZ6lq2jQZqkdsyTRZooDGFaBRFHj0u69kU/g1oKiU/7gRNG8vm+5LoMU2kGkfO
4/sqv2Kap5QBWPv2QVSTxNaiTcUBtKwI0y/Z91DXCO8hLGB9ZZWKnX0yjtkVUUkNjDak1jGH
hix1T48teVL0wYd9Jbca+1zDY5A+j12dlbGDLK9pYC1vcxIsQ4EqIXbrUO+y0m+KkypTlyBU
VpuBH4MxX9gHB6Dqq6B/wLhC1svqGwA9tkdfQ1KgidvLa5T7XQX3o7vXiAU1PlgZdrDqMCGS
veVXMecNWgBttLYYWF2yYke7r+SDNFChSJE+Q1a59RicphTepGNStCF7t00xfeQKDIU6MY93
YBW0Yl31b3t+tTRZmkAsLfF+OiJlmem17Qo006FhVLVKdBlh2qHY7lxkxiIP9V1k6iaHQmRV
l7jbufHl8ONZh5I//f7j9cf75Nvx2+vbX5PD2/EweX/63+O/jZsY+G7MlpKtHqDDhmWyZ+A9
Z3Swr4UJ49qzJSKlqWfpnYIpNxR1XjZLqKMBW8Rcx9U1dLzQiqcBsIb3tziIRQX+yRVCCvGG
rDahOmq0nSKFE4O3OyXN0lEDCr9AoRp8mLIFqIQF6nauHXEyFsQ1h7k6hcImRKVTraC67skO
IOz3w9u7oTG38GOS6SAQlW+jfju8vOvg9kl6+Mveb0PRq/QWJqDzPgdQIq6tVbG2XYnwu6lo
N2eCTMo1EEd2oVJamXZlZrOxTkXhpNYCGoNJkJlXdxHiSHmburarguxjVWQf4+fD+9fJ49en
74QnAvsjTuwa/CoiETo6COmgh/rskVb1oATlDNS42SQOTR2pVMerIL8FwzWqN83ULtzhzrzc
S7cGDp9BWiMqwUCnjSXnM244w8cnzsco2oxqpoR28PdsvuaKjftZWG49VQkyMFqicXVgrQ/G
1G2dOMMPRo1DKDL3Q4KVFPn4zk52+P4d7060o0ztdNSwOzwiiqcz6go0zPYdBoYzMfGmv7Wc
GcT20gfN65AFljYMkCmSivwXkoG9rTr7l5nJ1jeA8I5xnAZmHjzVFFl0vdhXhdNoSbjZEw0n
5GrmOBHtPr5dXlzufRIyXM0aVQ9WBMzR0/GZGSLp5eXFeu/Wy7kkZs75EiHJEDrGeUTfQNxh
Hgna9FHlpgGmYOPq0geLdSpLHp+/fMDl/6CC/EBo7PyyX5CFV1eUP0G1VToazOVGk+yZXkd8
JdUSMdNrq7ZSnt7/+FC8fAhxZI/MeeNJGDBrI+PBSse8gWWZ/TK9HFPrAXhI9SImjRFh6Fa2
o8PaQW14OhH7s9VDq3BDULEozbHHWdYep/DDDJ+OBGYx8owfJeU6E3pGoaYdNIHaZPhfBRZw
4Rn0qjaJvC0U5qWvNtgvowVEccIgpszUgS+vruZ7ohHxfzLJCA6F5KtW+Vwgf6RD0xKmw+R/
9L+zSRlmnQ1Mrt1KzH7tnUK7IpZvWSY4Wcejfzn980/vNG6fVPvZSxV5jRnbqQ1l2a5R+Jf5
IovBDBdHhmm4LYMlXFApFVxQDp21x76dMRCG2B9Narjk4C17zcDXdvxgv1xe39AWRicznS2p
sE/rvpu67KY2ppmQEvYgg3k8Ps8CYRu7pE36YPmg2zwQ+TZN8Qftvm+FYnpedmy8eC0lDqOk
nM/2dIjDJ0e/jkqJgvBmQeMSdSLbTPjLCIt7n87qxFIHTn5cl2rl/+T8DF/uaSuu43ONEUYV
ntrd1mG0Y2Aq6kDBszSiplVheyR+rk/PfWEl7Y7ULtBdJozr3922CKijPIt9S+EjhNMSn9GX
eYLaWJQUPQ5WoOqlSw0dgo5HJYmqi2kOUwzQ22e0Ifv0/kjtvsHqlaD4mjSR83R3MaPOz4Po
ana1b6LSAsYYiLZHJtpm2UPrUxl2k6usCSQ9RspNkNeMfYhpLJIipHcYdRJnqp+IOkNz38xn
8vLC2MaIHJpEIig+IrUlOitwX9qmbJKUhOgpI3mzvJgFpoM0kens5uJi7lJmFmxZ17o18K6u
KICuTmK1mV5fm3f0W7p6+c2FsUJvsnAxv7J2YpGcLpY0lnSpoEFJWIetXLURH00sg5vLpfl6
x6Y0gQ0a97x3WMzwLl1VS1pjhjNcHkZzUIgSdwcDTkP/gOaAhphR60nL1RBWRidrchbsF8vr
qxH9Zh7uFyMq7JCa5c2mFNLaR4Sr6+nFaISpKtbHPw/vk+Tl/fT245vKkPr+9fAGBv4JnTb4
JZNnMPgnn2HePX3HPwf9UuPWlRomOAldr/+gKDHuOcDdYMnd6lSJEhg0np7bZMwtwl6g3tMS
O+0932UE/kbyghu0LAnB0Hs7Ph9O0BQO9MYggp5Avb/oeDJMYoK8g3VtTB0K2iBMB8cMD2+f
qdew8q/f+9wc8gRfALv/Hsvup7CQ2c/uIQfWry+ua6VNgelkrQh1EW5sjL19qjJy0fMEmEG8
7bz1Rck4c0HMOU4cLEfvC/ppylitOu2gdfsk6sOByufj4f0I4rBFfH1UY195KD8+fT7if/86
/XlSbpKvx+fvH59evrxOXl8mUIC29s2cO5Fo9jF8oZ0vBcl4D9hyoCARLAXCCFQsaeWtQco6
cn83hExf5miZB35IrYUGHx4lLQRgKdRDYlHCT8O8qrCk2Z5YhU1XFaGT5UKPUGg79DkBoZtS
H3/78fuXpz/d1hwlB+gt2nGW787CzKLF5QVHB52/6VKTUd8JlvmoujimjCq/U5q9K6KtsNdw
Qw/sYkaj0PTG3ScX53MkEohwwdnyvUyaTK/2c79MFl1fniunTpK93yJX7esvpa6SOGUCrPti
YPs+83+42uH/DRH6MoklQu/7OpFNWc8XfpFf1QG+fzMjw+nsTF+W0LxegaReTq9pg8gQmU39
Xa1E/C/K5fL6cupvujIKZxcw9JqC8QeNBHPB3DDrmmh3z2TW6SWSJONO9gYZ6NMzTSDT8OZC
nOnVusrA8vWK7JJgOQv3Z+ZNHS4X4QWDOGWonSgLRmoH00x2ntV3d0enclDCMmMc/QYJav/a
hHpCKfuXk4MLKcStd136nS/VPEq0+r13DGOF25rqXGA/gbH4xz8np8P34z8nYfQBLNOfKa0p
6WEUbirNpo3zjl1ILgS+K57JitwVT8PB9GzmXoJqgn4HxrVRiH7jIK+dXsFLoWvLolJUiaGv
AeZgsxq17kzwd2cEoBOO6HPYKvdku76J+r/icTWWiD1KlIl0MM/gn1Gp+hE6wrQXUFakzMib
lEqmKsn3psW9jpyzYOGQU3OXThVXHXYj5hqtWHTv7NeruZb3C12eE1rl+9nfkdlD3zCJpFZi
xhfQjeX5fQNKZ6+mO/+mTSk9vQFl3HCaqxOAHuP5AYuAp9lB6K9ekITX3gqgwM0ZgRvOaNHa
a+f9gmy3zTw9FZXoA6JvaOj3I5ALDC6PRBVmjOLRmgPqN2Pc+WIdKHUOyyZ3y6KX8QD+9zL+
pgAr55zAzCuAlyrr8s7TnttYbkLveK0TxuOrZ85WgsJk7Op2F1/u3MnT8kFpmS5F9bOwNjrs
lERGE+fMi/XHe7lRtp9Pb6aeTxdexRlvVc5LDabKi60jxtfcKX1P3yTMdlwzMe+CZx4AP5gy
xq1unpox+DX3Ibuah0vQZ7Rt21bQM43u1LjAIxpPJe7SALrSzz+ju9PSV0AUzm+u/vQoA/zM
m2va66utMFnOPW1wH11PbyhAQ/36NrDdfqbMzqjhMltytqmedbG/2fRBhmfh3IhUJsVoellV
37gG6qapoiAcfQ3QVTIavqBGZOG4sCDduhZvISM9sAOdxszlbc1Y2p4alRX6itG1KYaMIwO7
7YOWrn0zg6+zDjBxHZUh1ZLZiWpVSNGIqqKB5UGmPTocmgeJn8oiYroa2WU29muEBqjwf59O
X4H78kHG8eTlcHr6z3Hy9HI6vn05PB6t4xVVgw19ONzxyINhxYVmD6eLGaMS9NdhIin3DbaM
TFLSg654cdzbzvAtj+5HPv54P71+m6gdF/WBsGeF1T1jdDK+4U7WzDm8rtyeq9oqi4ZAWpSl
a6jEzCqpDnQ8BOYbs92onXP6Zp0eC7ANSxhPate8PiazXCjmjt7nK+Y29XTpjrmg1jJrIeX4
zKL8+21YqrHF1EAzM3r+aGZVM/aJZvP+sZZfLhfX9KhXAh7vmebzbrGez/jEBj7t1Rn4XBQE
8h9KxBvkBUQc0HNCcT2etJ7vax7k72e0ATQI0J4fxfc4xwa+pwI+P58SABMY9qj0vFECuahD
v0CS/xowNoAW8LjmlECRRqwjUQuAmc2pNiWgHXa+nkD1yLn9lABe7OY2Rlog4iJyUIHwvtKW
T9u5monpyipE6PS8HpTbgrEVS59+U8w226dHwOPiLn16TjHvk3xVEAFnZVJ8eH15/svVdSMF
1x5ylMziqUeqf4zoUeZpIBxEnt4dHVxYl6e+HJ6ffzs8/jH5OHk+/n54/ItMF9BZOayZ5Dtm
UU/7dsUkYnMHLWnHyNRh1iQqupR6BphxkgrzAg7SStvtiiS8OWVEy2McC16eGgXIqCINI7b1
c3VSw6q4KlsqvW3dSgdxWJ+7CSEm0/nN5eSn+OnteA///Tx2LcdJJdrL2kOBLa0paMuv50PF
ZuSDHE7XIFBIpr+CEOxumHjt+TGD+tTe3DJCh4j+xNlF51tUQT6mqLjbgrnwibmkpkAzyLue
CMop7FiTjtYiR1dFELmwLaRkVWzzqCpWiY2XYkp0qQuZd2Fm053AobblMIMGYbzltwrSILcT
VEP777gs9Ls9m58+CKVg8ZbgL1mkLOAUYpqwzY5MlZ6qgj+Y7qm3dK2A3uzUwKgKKRumBjsn
cq8j67i93IpoSx145KByofIMxZVRQ7hF4UhiI9JmFEes7l/XtREWpChSJZJzQFAGzkNODVHF
35gqSlH05xkR9Ke3p99+YNiL1DlegrfHr0+n4+PpxxsBdKHgUKy2ySIXUG4nYLhWzTy0x+yu
qDgvUf1QbgoyyahRXhAFZS3sZGSapK6aoIo5U8Ba2HpC1NP5lNpvmQ+lQVjBxsSOy5dpEhaS
0VHDo7VwU+oJzo/YhknV8txHZMEnB1lpYFnxDvBzOZ1O2QDVEocwY4liPpz9esVkDm6ZOuBG
hJyC7KoFKjavk4CucxXSdBxnhXUGFdQpU9k6pd1byGA+AThcP/DQcF3dtlVRkYjeqHKCSIxV
Kwfe2JaoFwt7uqwuaT8iHi+RjJAbWnWyLnLmvBzPqjgOt3QNlQ6dlISrnGuW9pkw2CXbjOzx
1o1oqbjWs1jT3duz6W/r2XQ7DuwddV/BrBnYZ1a93ElMPAK6LsntnNh7mCoMGFxE464aBUa2
4lNL+pbGxTWfco/8o3RGh6NLsEHQJPCXh+mghY29I2Zn6y4+4T0gstPF3gbGkjPG07zbr8/U
bWPhD2zKKZlA2XxgG9ybOSMNVgdWNPQ4XRqSjSA09VO4v5vNvRkXkKxX1g9gO8YFEHdMlhdQ
u0Q1kGxGImrlPCpWkaOQDr1MLi/ONHCynF3ZwEu/0lcKhkdad4mlDHdZxPRxhjYb+k/pEXrL
xAXJ2wfqQrBZDahDkBf2Xct0f9lwp67Ic8OnTe6VlyvvvWwWObSrbRJW9ui7lcvl1RSepc3l
W/lpubzkomLNkh8q60gBf08vmGaNRZDmZ4yjPAB7xc6t2pLoNVQu58vZmWmpwP3yIhPkzFzO
by5sRTi7Pf/h+S6JEksbx0UViojeARgPFrdOhs5Nw1lFmNGWWxXa/HQiXyc2XvkGzDlQjmSB
DwIRVmISwsKooj4aNQu9S4M5F3dxl7Jmwl3KjAR42V7kDfvc/zF2Jc2N48j6r/g4E/F6mou4
HfoAkZTEMkGxCGqxLwp32TPtGNcStcRU//uHBLgAYKZUh1qU30cQG4EEkMhEg2OZOZRLbLgN
ZuVR+T+k4vl0/Oak0pWgMdsO2ggP9KkfZoQNEUD9Hh+OutSPs1uZaEptKYVghdUoXeytbvT8
DpyndmhignE5Q9uHv2o4v9mDRVm+x5Osajt8t8izwAuxG9zWU7ZdWCUyyi6gEn52o8RiX8uF
m/xjfRSCOo0GN17QlW58EYILq+rLtspJ6wXJzXziTECBq1sDltjn4PPDdNVnor06U7DK13PZ
8X+h6Q6NPVa07QMvGXFqJ7sHcSszBwezDTEkV4frmejL3aG3BkEtufGU/QSEfpezIiN2Yvoa
deFvpHe0R2/589Lt5FiK64oVnLDXsll6zPGNkeypemzsLVctuZwiqsNMhPCWfikemn0rHmw/
YKf8cq631Li3KQq8maT+TOyTK//Ha3c3fpzgpao1OLuyN2zA1MrSBJSs6tesIcIs7x6oSztt
TcTpbFvUCrQ21wKi3pnWHBJTPkXgFNK+vaEgZYKGd3+A1f4m/M86g1QbXXDj6rdvr88vdwex
nsyXgfXy8jy4ggRkdIjMnp++QPSZxb75qTbd8MKveX+KOxOShaJfu83gttpnguMOwY00xqUq
AjkOWF2oE6b7GbDiZfaCSkkm13J4L9WclthCGWHq2KqrBI8wqwozr8iSwoJLqejJZriRSsfc
lbGFat3iVhqiohJAd/1NQl/hLfH4UNiG1yao9tHKplleIji9cna+g5Oet5dv3+7WXz8/Pf/5
9OnZuDmt76wqx6fWJ/D98x3cidMpAICc1J1uRFgZ97uNJeiMbdh9WVseRY/8DDuP+Ah4eFf1
4nChYtKB4zDTu0clisb+JVeyjhG5lLWEp20FsoOzItXHaBK6+/fLk9oH//bjz0WYO/VsoQpe
qZX29Niqfv304+fdX09fn//3ZO2iD57Uvn0Dy6sPErfqWafYHeVwLxj+DSlKzvBreuPj22rL
hLlHPwjcqhnF6lSMWFyOHO5TEdXHRFxHs/PkoqoSnbyOfFnvn778+E7eiBld5M4VAoKFq28L
3GzksMBtF8sagUMmywGuFgvlq/me2yOgxjjru+p87wQNnBzhvcFXN1mc2a2rn98f5MyGxtTU
hHf7ByRL5REVGp6Odb1RXpD0A/flw3rPOmtiHWVy/sKVEoPQkuZJNinFvW44JGxxNVP6+zWe
z/e97yU3cvG+D3zCicnEKYaIFF2c4tY2E7O+vye8dEwU8Kt0m6E6XHkjqT5n8YrwhmeS0pV/
o5p1X71RNp46gQNxTniDI6ePJIyyGyQijP1MaDufuDM7cZry1BM2WhMH4p3AHtyN1w3L6hsN
t6+LTSV2F+WN91aK/f7ETgy3cZhZh+Zmj+p5cOn3h3wnJTeYp3rlEWaBE+ncU280xqVrgxKE
FTccdI6SC2uYExV1hkJsZ2iGiwpJL9+vO4Ymt90Qhxczo0NPRCz8YnqUn5FDJb9MbnqKmTCl
HrMcg0RVlCeIJ9UhYM9NB6NzcmrvkQQugRk8agKl0t1Ve+w1cGG2dvZy5gy2LC/3Hb5ys1lr
RqgAM62vmi1hizGX+lQV8se1Znjclc3OtNefkGKdYY3DeJmbh97zyw7der/t2OaM9UwReWbc
gQmAKdbxVz1h55ahQdfVZ6DCY1rqh5YonzSyCnOGf2Imq2qdpQXG2rHmRC3FDdo9BOy8RWpL
qaAdiCCcmibKrmK17GNyhYmflg7lh/FI5F1JHJwMQ0klsI3wjlerhamWEuIO4xUkuHFapiQb
03nRKFEl2DvyoBg81Lh8s1MMksCVhN4im5sQW5xqKIpGPWw3av3V7/s79zavnUvEJ57DUD8v
VeqtAlco/7a952lx3qdBnvieK5cqraNQDfK8agV2fqbhulpLePmYE0zWwgZTFv2c/TIRcB0+
0H6gyy/oW7TOhGbv4NQUjBF2fYySSyOksonIa8v15CQu+cH37onFzkja8NReD2lNXy75nj7A
vtG88B6/NNOq62hkM9dGcuCZvRE1U26bTeZIwGQXUZdm9JTdCWXP4su6UqaRM3xoqnOWXtre
itmi7GpJoUzt0PR/BFFstqMcQIy7T9bXo6LCuV605v3ph7xmBaGr8f2Z6b2rmjo2BobaGaRu
qT00Oej6V0GObxCM8GVLhCXcP+6J086KuGjYXCCaCQFtBbbFp7z266iUxmCmpcKKdTEpq1Z/
M6WXknX1w7KfyPUlN6Ojyt/3WjD4A/76+vS2NAgcWl4las3RA5AGkYcK5QvarlQ+7Edv5ThP
O+C0RoYR2kDHwPbpTNKipFbiZnwTE1hYphgYLxu5lMEsMUxW06koLmJ2JmyinfyCKl5OFPRF
5bkvpXJJ3PgzK0IQp0JmfROXtsxM9UGaohfQDFLdCqKleLWYYCZIfqSL4bL5/Ok3QKVEdS61
Ibl0gqKTgYqqq75E3jBCY1PTBZiYU+P4DsMOsGUIjX7kvv8d4SFygEWeN2f0KGTE/bgSyfmM
v3yCacT2ZDmgsnuty65gSNcfZuh3PdvagYZwnPyECN5l/dAypJMM9Guv1FHc2Bkmi+WXY5LW
7FB0cvT4w/ejYHYvjzDphgN7joNzpOSk0+XIc6Cw3OxrQJLdTJfEX6TRtcRFcA3LL1p+aW7m
XBaMRI++feXPZoA3EX3Yt5TnfVfDlOB4Ye7Ugtcsdt1eKW7bOj6NBwt6+omq5RUscYranM6U
tIA/ZW571gNAeSFSGduwfAGypsr1/gyKiN72a6hfpc5FyTRNy3ktENXGEZ3AbX6xd1NuITzy
fmOwpQa2vMQxCeFTBW3Wcau8oDlHeDOgLb8X4m1p1eMMOMfpJuBqUaNmcrQc+HdhFlvaM2tb
MIknxsF980AcX/MTo0I66VgP7sbq2OnyNAnjn6M/+zGXInckcp0ynE7NMojVp+QQhAaU2Lki
WuJSh+ys23xXwo4DNBWmouXyT0u1b4tqdfBIJZxRf5AuBDDGT2fECFRJSePcNzDx5nDcU/um
wGsIF+qAqdeS6PhmkpB3mK4EyFHWDHza5wcs26IPw8c2WGwQzMSyzolre7JxXV/y56quH9aH
5bUcSH550mROqXBNUdXiXuqs28rUc0GqtljB2b91XhTkQ3wUfHkA8I51xFmQRPnhPGrf/Mfb
99cvby8/5dIScqsiXmBZhoecT2CU1n2+Cr3YzSJAbc6yaIWZftmMn8tUZXUshbw+521duK8a
gspBXDXiVYLruWpqFvb2n89fX7//9fGbXUxWb/frqrdfDcI232BCZiY6bdGAj17H22+b38lM
SPlf4KN3voWLnYvr5CufunM/4TF+eDLhxJ12hfMiifDDoAGGSz4kXqXEsa0CqXvWGuR0x4XL
xcRGIQw1aiMbV29UK4MHx4yuM4nHxHnGAGcxcTwuYeru9YDJ0WYxAKhbyEQDi9xe388jxt/f
vr98vPsTwsMNYZb+8VF2mre/714+/vnyDGZFvw+s3+RKBxzL/tPuxbns7cjXWpQQcle5u7Ln
Bgdcusd1CItLg24ChCkO0Mpt4NEdoOTlkW5g8jRUDaGLgzmzY+UMdSujsDMjTL11r+D6dqAh
O0MQ52kQLX9+f/n6Sa4zJfS7/sifBjOvxbaGet8yHIkhvtSwcUtkpmd7IfXRafdk//0vPXIP
7zU6jeV2R+s8+H0xVcihQV3R4BB+2dQQqoS8jDBTYJC8QVkTRwgCtUWxA1ta11B3ymvjPGHq
XXNROS4PZvHbKziqn9tmp5xOMUOja+04ffLn0hxFj+6tGNPD/DvDg3ldQdDV+4Wih7HqAj/r
MCjLKDczNnz6U9b+A/4Tnr5//rqclvpWZvzzh/+i2e7bix+l6WWhDJlWX4MJJxioNGUP/jPA
qlMptKJnHEK/jdZgsrfKT+NZhXuU34t68bd/GZFtrBfCMtooXtXAutIWyP8Zu5FDENUFoDva
nMBcQC1ynfc4KM/bIBReij0pzn7kEf4wBsqaPfQdI5wijSS5COi6h2NFeDqe0pIqLaVsT0mx
ptk3NbvHP86JVhask8Mhvn09soqykWucW6/clrxqqpuvrMtTJdaHjjAFHqv00HSVKFVsDaRV
oG/L/mY0u4pfZwVEGjgQdcW+Iqh7gj0zqueVp1dHNruP17qyDtL18enLFzkDq6kIGWp1bnjR
4nOcgosTa/HjVQXDFjFR8LmPI3OZIlSE6qXA+qE5X6vXC1+nsUjOTkXwsnn0g2TxLr53PUPY
+PGcRtFyrJSjzG9DLcJZplOTZgKbxE9TNzdVny6zQmmcIxg6dzEmbUu9/eXnFzl8oS15xexM
1wHYJ6FG8jMcLCpUS+1Iy/pQEtZDocsfpCh/k0aLBuvbKg9SdViru+6mWBZ0UUw7Vo+Wd9Xj
vsH1XkVYF1mU+PyErTV1l2vDbBU6+avbNAnPi7e1rOaEp1iFd3nURym+phnKLeLIS/FlzcxI
Y+wsYsYz85hbi7Up1CLHJ56GaByjEc2y1TQRSxXzVm+7surS1d2nxAU83a/qS0VEUBx6y1Ww
ulRwX4OwERxJpWYF+DpNN1SRhwHqAUPFIFfl9n/73+uwVOZPci3jmIb7Q6hjZWy4x8s8kwoR
rIiITybJP+EbiTPHXWGYWRVvT1bAFvmUVpLBp4SxWJrkwjr4nMSQWS+iAEvNcCAVdxv88aA1
a1D9kEo+JpMnrDVNTurhi2srHfSqn80IyUyE4SXvMM3XZqV48ZLYI4CUBHwcSEtvRSG+Nf+o
XfkLOxKO3xQqF6boxVONikPb1saxuil1PcO2BdP4Uu9lRS6VzV52Y2vXU042aRZE+imsZtUY
NiVqbIKKfvnQBA9vuqRpy9OY0IFHkm4b5OUmwWwjS+6b2bIQIqbJQBFrbDsAlnhbqN+1fVWN
NWwQX8nn+n0AvueXGR0Ae3vXBXfFe6woI1z0l4NsX1nx7g0Gt+wsc2ajEZGN7Sf4jWCHEiyz
qRA5bs/IWFeqD5kGciOATIwjBJN8kFxpAFsNn1+l2mEJ1H0expGPZs5fRUlCZDsjgXQJyKZY
+RFSAwrI0IICFEQJ2hVNToKepxqMKM285ZsFX4erBGvsLTtsS6iXIFsRQWJG5mCoc6VbdH3k
hUgLd322iozZavT/Yf68HG0LDS0cdomcWM3aQkP7iMa2qsZAj+uqP2wP3QEt14IVIiWbSEWy
8o3B3JJb0+2McN8LsHnMZkRYogDEdKr4VQaLg86gBiMLVlhozKJPzj4BrGjAJ4A4wAshoQQb
X2wGVjUiT+LAx1K9T/uSspQbKb53k7Nh3I925Ew3BxFt61JY7t6nLMKVZ7Tcoi1Jg6mB0p/b
ay1XiDhAWgGilQZIIxRlXcuPn2O5qaJ7uVjALcWGqpBLZy/aLJNVa+pgs8WQKEwigb2P536Y
pCF5l2tKQi610b20kbCtIz8VaJkkFHikxdPAkVoE5grMwINlwXbVLvZDtFmrNWeodYRBaG3X
VBMiFzpqoLua4yqK0N2BEYdNdOjX6Bv6FJs/R/hdvkI/Udn9Oz9A3UvMkVWbUs6y2NN6OsH1
fIuDOuEwGHIeRXo1AIGPjA4KCJDWU8AqIvK6ClC90mYg+QClIfZiNFmF+dcHasWJ8Y0hk5Ph
eoFBieOrM41ihBmRzzhe4Ub2BiNCBh0FmJqRAYR+kmGP5G3o4cN3n8foBfvp0bLZBP6a50vv
YVNDceIweyYkNwk3ei1PrjeGJKTX+hJPkWqBS4yoFOvjPEWqvOZYdUsp9jHwLMSrL4uCEN+S
sTioNYbNQDKuzaKQXAKwCpBCNX2u90UqYYdJGfG8l58PUnMAJJj6IAG5RETqBIDMQxQ8tTma
GR9/yx2TxYGHi0EXC7CcQPT2fLNp0amy6sIoIO6azvUcRJ4d0QAbYZMUHQ0BAPuYQ83QqoWF
UooNscOYtyLGksBLohsjkRwaUmrIDFcrdN1pUNI4RYrUt2Il16NIy0okCuMEHfwOeZFRQW5N
TnB1+n2sY99D+rXY9VgNSjGmqklx+BMV5+h4iRiquMofL/0kRL6rUqpiKw8dAyQUyMXD1RqR
nPgUeNeaGbxTrRKOZ3zAMsrG2KStwxuTn+h7cb3LSfU3jtFVVu4HaZH6SHdiUqH2sMaTQJIG
2BOyUlKsXauGBV6Gy8+4Utiw8NbX3+dUKK+RsOM5eqowEXjre6jup5Bri2FFQBe9EllR8bwM
ylVlBVxk5e2BUmglHKfxNQX+2PuBj3a9Y58G4fXsndIwSULMP7/JSP1i2aIAZCQQFFiOFHSt
rhUBHS41Iter6sj7VqFqOej22K6kzYkdR34zGAfJDnNGbFPK3QZ9fnHGddW2bfqowLSV3j6e
aP295/tYZ1faAzOtkrUAbMS6bdnAncHBIB7WyuzhwsUfnrF/PdAXazQHP3WVuq4M0VfsKX1k
DIGML9s9RBMu28uJCoCFPbFhVSenAoa6kccegCuo+ur8rcwMRw91vc9Zj0Z8G5+yM4Kl++uF
AyY4dLu4Xt0QnlUWBHdKgGUMnEOr66vIq9TNBZ1IXjPTA4PUNS7tPZxi8NboSlPq+kmxzy9F
L0YC3sklNVx5Z7Be+vrRuqtopgYULB3njXA16BrLPMy5xhuviGBfNVzO3wtRra2rVWJt/ZCt
oi37zKfySsVZRp8eUWuMkOL1KlRnx+uuKlBn2kByTrGUSF2fgEfVNTjjnVbyNo1KXpPsE4V1
zhmaLACLplam8P/+8ekDGKeNfqIWZil8Uyx8DSjZIkKaATIRJr61DFENPJpcmEzWB2nioa+Q
uY4y74ydqit4tMRwn2PnNvDO5F0HlfsOzEpRg0PIqjpuOrvpgjQKrqarKFStAGju1k2yEHmT
j+pDAMLWpHUiZwjt0zipjV9aJqo8tGWS5FwqgCT05/r+wLr767bHdZuTVleAkcbw0wgElfwL
lEu+60+/SoThg7gaNRUObtzSkbIcHmXTDbR3rHm85HxPemCXnHs5EBOR3wBWx8i4s9EJjexG
Hk+enaafTwOtF4DNVRJn+PJoIqQrTKEb4DTzksXL4GwdEWYY0zxxVMI+DhfEca/MLUBX9vhh
GIBtvonkl4OX7pCv5ZrRu+I9HpInbXYU6pwOKpk2x7KFosydywVKWq2S+IwOa4JH6HJUYfcP
qWxMZ5AY/DAPErY+R95yxGTr0EeKbCbzIHJ7LxKkPYRbDsNIzuUid447DNpk1mY9DEfehLHg
kHbNMb/IqgWV8ZuhJbUi9r3IGna1fRuuLSsocT6G0SBuUUolz/Ddk5GQ4ud8Y0lGGz432TTG
pNqmbpmJzF9MITZFDgqhMXcOBgdIHxsR5XbTqrVTDU7Sr3f/U+0HSXitv9Q8jMJFk8+34em6
5FeGxYWNrDlza+tLR0XQwmFqc5SQVYKHNlYl5JGzaTBKiXiNGoah7DpMd3gJr4gtugEO/YVm
4hAiR0UazJWsmX3KirEJ3CkLvNbpKOa26ZSXSbi83bFgbKpzKVttX/f6/GxBgKvOB+XboREH
XhIvgnWRWhZNPLSW5geGyQ47D5xJLO/T1NwvM6AiCs3px0Aa+U+LIlobRaGhF9bF3sdLODKk
PgKWbNfzPSrISDrXLIyNhluoqDYW4xuWDgmb+y1K4KO1oRAfQzaskeuCCG0S50b5JK9EnYUe
+oiE4iDxGYbBlJSgmVBIgCNpYlqn20gU4RUKBwyOm1WCFSfYIcfMWZpu2Vikpi4MSuNVRkKx
h2d80OFuZHxQ6n6FFWGHrw4no0pn64MGNCxeFj7tLEaSXu+twEkztNVB7cS7KyBBSCF4SSbF
Bclouzk8EjGuDNIxTT2qyRRIRFx2WKhBgsE5cSz7KmLMcK0QSRm5c7DkOMrxjIiAt8xDqxog
gbeCiHiaxGhlLzXiGYPTMj8OKWzUJlEssE53bSzy8C6xVDldzFY8HdQPr388hjJJJZGhqrBF
ctRHA5ssVxfQpHYg79VqBt4dc1J9hOgByqBb39icN5w+vjy/Pt19+Pz1BbuAqZ/LGQefQ8Pj
uDaliNpl7qU/YlyLWVTbqgdfTkcjV05qEIp9/wtvFUV38305BFOdXmRD+zEWL41ciqOxeXms
ihKuLB3dXUUNaA2NV42Kx9BszajOMp3FsAoy7vhdNyAnkEvfw16nvhZNPAF+YHQE2U784cf2
m4qHhsEWjcoffmVA0UrwdyEX07DxfalVuOE9fm8S6Ie6JG4mc9XBkC1rXcdQGLrxIOnxpqER
jGFKA5rVxRc5ELpfvzzfcZ7/LmCPaLgeP13HniljZPG7f0zhxv85Bk2xsg9Zg9C8RX8kyvz0
6cPr29vT179nNwrff3yS//6fZH769hn+8xp8kL/+n7Jra27bWNJ/hXUetpLaTYUACBDcqjwM
AZCcCDdjAAn0C0uxGUd1ZNElybUn++t3egCQc+mGz77YYn+Nufb03Hq6vz391+LP18vL+/nl
89vPbiOJbgvhD8C/iMhy2SeknLddqeR4SOP72/vl69P/nheyjEPW2kHyjR9cDNT6YbuOtSnz
TF+HFhr7mznQOBFw0tXXixa6ic1nlgacsXAd4ZexLh+2Z9G5itZfmrfpNoqa+DlMAV4XiflR
RGJeQLQBxAPwiKbtE3+pWxKYWGhE7zSxFYkVfS4/NO1vXXw9p4pHxmS1kvMeepCps7He90wD
SFdAPMwgTmfbJculuXVzUGyad5iIzhtL4VMZZCsiQpWRvh/GVKPHcSMimYYzL435d3JfuCQk
RHDfC9c4xtuNFxBjr4l9Kj/ZycHSa3aESBZe6snWUna/uo55Oy+kQlzsJiU2KVa1xnh7f3z5
/Pj6efHT2+P7+fn56f38803f3VQSqFTRbpdygWPOmJJoWkkNxHu54v4XQvRczsjzFKuhvgc6
rkXUPCoFnnjtquA4TkVgWbtgtf6k3FT850JOIa9niEv/+EzWP236O7P0k6JM/DS16sXt8aOK
Vcbxao0fN9xwt9AS+0WQXWQkkfT+CreZuKJ+4JSrDdCRCNjHXHZvEJnVG4gbp9fCg4fHLpwE
wI9jt6u3ET5Qrx+5QqekBhO6pZ08zHRLdJM29eByGUdOv8aGZTgQ7zPh9Run7aYhndrx8BCu
oXPwi5hbvrRYS40T4TvmW9dbVRmIa7vUgyDQ5QX5Ra+TVTGEnOGs1pfDbWmrAfAYwewCDS2+
vr71Btlu5fLr3xiAoo6HI0ezqECliirr6a/tcg1EH5XegB6dcvxjz1cAyqOV9RT1VtUVVbay
b6OlK7ByMKJHR9O4C0JHBlO+hdZHH/3oeIJ8uAaA/g7g2upqvt04fT3W1RndbLdZetToyxJ0
6gj0842hw1JfzosNQl155jE6AE2b+zHhzO2G0x2tlDd+c6GqJLylf9rhlzqql1JPTtSwT6vw
S21g2tdxLe6sZK4jIhmnJnIsgDaK7UE4dIJPCKJPdcOgY9fTiGStkNmXctP114J9Pb8+fXp8
+fXu8np+fFm0t2H6a6LmTrnJIgspJdxfLnu7OFUTgiUnURpAPf2kCojbpAhCzxkr+T5tg2BJ
jbARdubhkY5amw44hPKyBBO0w9KaiFgXh76P0U6yXZAEvKve4yL99xXfxu1TOQrjuRlHKV9/
iXgehYzN1cR//L9K0yZg3HNdZqZPX57eH5/1JdTi8vL897it/bXOc/P7Os8tsVWTo6yQnBfc
+fsGblxLU5Elkw+3Kf6FiquqVkzO8i3Y9MffzbzzcnvQjTRGWu02uKJSihkuXwzHHVeim9BA
pgYjbNoDS3JqZ67K9yLe59jl8BXtnXHH2q1cGAfU+kFqiSgKrVU77/1wGd7bSam9kU8v20Dt
B848daiaTgS4y6BBsyZV62OnpOrrLM9UKHvV8+3l8vwGzuNkt5+fL98WL+f/oZfFKtwkpmz3
r4/f/nr6hLrmY3vs4O9+z06s0c8cB4I629vXnXmuB6B44C04caswF7Sp6agrhdOyWiqRHvPU
a7KpN/QFOnlr8Elk+Q4cdmgdK+G7QozOcV36bnuDjCx3W/DhjlrdGnx5xdKT3JymaPBejbFt
CzP7fVacwDaTKpqBXT11nV8+XT6fXxdy5P91fv4m/wLPp7rekp8P3o/lgiYykx08eeZetHLp
ZV+rA69N3Ntt0bCUckANMCtSKQyOvLGkXvzEvn9+uiySS/16kQrr7fL6s/zx8ufTl++vj2Bi
Om3Rwfdg/vTHKxxUvl6+vz+9mOE9pYQI3IAQSlBW3X3GcLswVb+Nh19kAnhPRXZXYPGw3xHb
FOjDgoXUzCThLsXNllWrCfwMC7Biz/b+TLoJb6R6OX3ICrrOH3o6722VHLCXFKrGQ3wB2aOm
jNSsVM7Rx5nw7dvz49+L+vHl/GwJ32ABjXx8Q4w0+BTPdbF9ffr8xex31VLqQof38o9+TXn+
AsYDF1z+sy0wSxo1Bnl5RLTQEHuJ+GYoetWAS1GlCk4fOt7cCbOC4GfxGoNAVWD3+vj1vPjj
+59/yjGa2gGrdppWnRSHUiMaWa77Cwijmhm0smr5znBtJIkp4ZFAQtuqamENjV6daVnt4CYh
z5tMD8U4AklVH2UBmQNwCI+4zXlrlQewRurPmvdZDu/BTttji2lGySeOAs8ZADRnAKic66aC
CzCpXVv42ZUFq+sMDMYybA0Mta6ajO/LU1am3IzzqFqvPYwI/vVW/od+KYvW5tnst6rmVS2M
yqXZLmsaWWLTfA/Y5QwLPmaJji4Y2B4Tgb6gpCy5o7wqw+fy23G+EVbGLc9VU0OASkfNG3KO
BOU2xELpLaqAdYFvVOHD4zZriEWYhK04MkCR05xsd1zFKsEVLQnKdia8/+3UdhRf1sHYXKF7
PVhk7JlVQjSIrtbZXjpZ9Bs5SOEmPLDDkOP3JMbXK3xCAVnN4mW4xs8BlGSRzgchU3p1AB3R
Hj2fTFmiFCSIEPYSYfdsj59JAMpJAaN810O7ZpVUKJzUonfHBrdelViQEisEyLKq0qrCT/cB
buOI8DgI407Olxktw4zwWqyGEplowppCzikUrKLa4CIJD/73fbsK9ZMs+GR0q2UQRwNQg1Zk
Uo7KqsgsoYYNvI+ewYLaauQKWxyyzNb0rKtOd94GPRJRcjBeJxvCUazR4/+rbjzlSeraaAAx
yZkQY1gjPVXAptv/2ZStBBz85mjZLdRkdO0ghjnXjewagt6wOcO+G5fyDvUDnrqINyvv9GAF
XXf4BJP7O4aV03n+ZUBxbNrDWSBql3/j0R7GYCkMVr3zslAEUbBEC66gDYrUcahbmGnNBetD
vB00gzasrMoweLao1pu/W2nuZfOu8xrDtmnk6U95tAybpE9KY0Uj50Qh17+YajikymxwmOsv
L2+XZzn/j4v7YR3gBtOBw4LECaYql+FyfS2qnWyRBIyeoEg/wuVI/5j9Fq1+wAXrGi5aCAyQ
leql8/Y4PSPW1vLq9MQpmUGW/+ddUYrf4iWON9UDhL66KqOGFdm22+3gXsxOGQFlqVq5FoZQ
cQUzvZhi3E3VUg+D5bbJWETCb/B6BUGEpCJGh7fG46yDXJYk71rf173OVF1p+gkAwglMt6iX
q6XucKBMhyBgJqlOCodwyvLUJfIs2ejxiIGeFiwr93LSc9MR2QdHJQO9YQ+FXGmZxN8NaZwo
Y1xuK0yfGCoNB0h4nVVpkaqapnEmBuducv5OxW+Bb9RimLBOciKWitsqtYrtt7NSus+abSUy
BdIYL1urwpOtoVHP4fxt/Gymtn3Tlc4baMhwcDvtdNpJ7KWsOx3WyYWzeWB37UkYhkQBAIcu
tQMZ6phLlcuYETB7ts4DteeXPOgoGplWGJPGwpLN+gTxGBOr8q6VoSLP1I/llf5+RbXrtfC6
DLU1cyS1aEVEeGNRDTGEd/WiMMT3ECqNulvhLnWg+6V4Fqz0+5WdtWqC0dezFa3QEB+nD1jq
xcTzi6E9REA5Rhpg22jKwnm4CglPK4ALfiCeDCu45dyMSovAas9NuHoEpi6OiUdpE0zYNUww
cTOs4AfCeRFgH9sgIDZtgG9bywzBQBO29Jb49lnBBaceUatB0x/lQpj+Wqz8mO4VCUfEAeEA
h+FMmwzuC9TLSZqn7Xd06VPW5GymU/bKlxIJ5+w4+/mQPD1QVfI0PCRP4wUV5EKBxOYZsCw5
VAFulw0wL1NORMC6wTNtPjCkv/8wBbrnpyRoDjlTe8s7WrRGfFbjjzwzmZTCC9Z0Bw/4TCGE
twnogQkw5Y1TwruCilcI6CEVtMICkNZUcvnkWRtrF58RPOVgIe7pdpkY6CLcVc3e82fKkFc5
LcB5H62iFXF2Oqy8MtE2FeFWTg2PnowmLeGy8Ik4k8Ps1h8IB1GwFuV1y1Miji/gRUaY+Izo
hs5ZoSH9tcgIIz0FcrFeUh5iAa9Kntzz7Uy7zh1xDUsYFvszGn3EfzCTqsOoStAa5r73fboR
jsXOmrKG8HnpL+p60/D7pcYKGwSWWMsAXjeZcvd03byaA5U32QOndkvg4cRaqcqE1DrK9OA5
IpMzJXsbZPWVCncKjlBmVi3F4F+FnqBu0S+5jzyCuSSL4UYYLFd2r+fz26fH5/MiqbursXZy
+fr18qKxXr7BRfEb8sl/2y0v1E4nl4uzhi7jxCQYGlpR5xD2jmAC6pTb+5IRymSyLsKLHjwy
DDGHTc3mg2fuyPeWdos5SeyxdPcqBV5i/TmhVYfd+ehcNWukOMI9Z2dvjUYOVeUhHxIlP665
aFlygLBlEA++BAduDJHh0YGPaE+t3DzJjVruVEtirK3grnfH/duzq7klJfHNrICMJbk72uH8
UL6CqRiNg4y3xdOn18v5+fzp/fXyAgY3kiQVNIybRyXRzmnYlFrf7uo9OLUwdn4f+1Obot7Z
p0JAqGL4u76dw8Ge0nXcZSgLZN+psJR1p67lOaJKAPPW+ksQE+lJJJpBTDcWOrpeGq6OJ+Ru
FYYrlB7pT2h0+gpNJwx0g/grPU/CyEcS2sKJYuXSExGEeYDkMABISgOA1GEAQgxY+TlWCwWE
SPOOAN66A0gmh7SKAtZoXVZ+RJRY95th0InyrmeK2/cxCZBfBV6AFyHQPSfc6GGQYx/ILaFc
XCKVhMNvaiRlYu1hfZyJOPCQFga6j9RxoONV3LdFhI1HXpbVqbkLjActE1iwfhOHS6RoCtkY
rsx1JMD6XyER0miFKOKNF50eknQ04sFmKZ1rfJE9o+vk0sWLYqTCAKw3PQngzQeg4arJAsiv
ZAfGjEbI70LP/xcJ4F81uVRGHtZ0TRuG3gr0vlz58bzl2CWAxhxhUgd0MvlovaZiUI9MYt/m
5lPPK8L3BZP7RhrB63tFm0z+gX7e7AYHV9TIIxZoQhR+hM0oI0CURxSrMEKGhFzUGFFNdXqI
NUjL5aoTmVZbJvwQU8YSCJfYFAXA2kPyVoCPZC4BOQkiQ77dsU28RpRhm98H/pLxBJsKNRBv
tStD4PVYOa/wcCY8B/8oAyx5ETDfX2cYMkwZLvJQxKGHtBzQsSZQdKTsQI/xdAwHqDodU/tA
Dwj+ABFHoK8IfkwcFR2v13qNyJykx9icMdDxTgJHIUs8jw02ZSg6MhCAvsbzNgNEaPQYma4/
qn3YJqp9JJMSHrSskFKVw1E8AaCDqmYQbInZuSijFHWHhy6xb7Ctj/sYu4nVNv3DkQRP3d3F
wQpLx9NbbMi2ycp9i1tWS8aGPSC5dgfdThXSs4KEi2/nT/A4Borj7EGAn63aTG2ZjFKxpOkw
ax6F1YZzCEUSnXCS6OBghUhjm+V3+g4WaEPIeZvG5S+LWDdVyu+yo7B41ct0i3asm0w4ZZOt
ua9UVHequU8ZPEnAfNQrMM8S3Ve1on2URbL7otjyxu6gXWN9Kb9rqy45WNSj1cgPLB/84hnl
3B8byuYAYJ6w1EqHtxbhd7ZtrHZrH3h5YKVdzlJwKaOVRc8TJ1arIqO2SANSVveVlUgl15uZ
3QgTFX7U2vrjSt/tTGLTFds8q1nqO9B+s1o6xIdDBmbRu51demWDWFTdjIgU7LjLGRrEUsEc
3FhXu9asUlHBwYstKkUn14yIFJQtNwlV02Z31nhgJXhmzytTV2lkS5KNWtSZXOYfS/xgVzHI
IZgnVF/WOQOvSCVPhD1KudyOmDTB+FB6IwPBCtGhnvsVCnEOc15alRYtdJxUdZmVr0yqzjuL
2Jju1NTAabKsZIJjtugqnYI17e/V0UxMpyJS0/J77L2VgqpayJo4XxzkkMKOlAaw6UR7tcm4
fqjTaS3VwaRxqkVg6RHOi8rWAT0vC2tEfsyayqz8RDFGkWI9pnLGMJ0XqzZUQTVOhw43lVfT
RF4jz0X9BJ9A4XzNmPI6sT1Vh4SbRv4m7hiRApE1oFWYOB0So08khs2zQ7iBaVYFJiiYNqVe
6fVff789fZJTbv749/kVM79XiR1wc+uyqhXeJxnHX+EBqoLa328JA37FwdJ9hl/mtMc6w8/k
4UOpteEqCL9CBoYuV3tc7IC8e9gaTfmwPT0cKDft6NOgQk67LddtuybK1Vpp9Kj19fL6t3h/
+vRP3JfY+FFXCrbLINx5VxAOkSHsxGmbVwluwi2XAQ7oFOFweXsHg0t4EvwMj4xmitTyXSFT
xTObmH5Xk0d5CmJcL18Zm3CDWVGX2QP0pDZ24ddg+IzRTmoi0ztPYdsGjFBLuYI6HR7g5V+5
Nyd1VUOY6JFOUCnMRmNXHKzGPJAPkAiiVcisAisT7KVT1sEym0oKrITN6KSKPPgXpT6qE7YJ
9cNknWoZ+ipoJFkFA9fsmBPsKxraWeR1GCqHq4UVnfKKolGvbmiAJBi5ucShfmA5ikN2X8ml
Dc+xapvu33X6TDyKiSsKsC2Fgm3H2oroms4PST3gF0YKvDrGpHLapn68dAVhuu9a4eH5hvZq
g3Bjt6xjNz/I1eAQ16K2CQMHpTY1T8KN17sVHb31zoh0qL+cV8QKnF+4KU0xHGbGrrrV/eP5
6eWfP3k/q5ms2W8X4yL++wu8dEY2k4ufbouYn2/z9NDUsGorrAKCo3GnfHL1uI63PVq69vXp
yxdj2zq0mlRNe8swUwcGg16q7SamSuq2Q9XaPTKiKRd3BFS0KZnzIZNrxG3G8OnXYEVfAuKs
Ca0nJxaWyPUnb49kyebH6LXaY0Qvc1OpOuTp2zs4YHlbvA+9cpON8vz+59PzO7yCV6/KFz9B
570/vn45v9uCce2ihskdpWEDbFZZOZolayM3OBxbRBhMZdZa9uAsSTKIwcTlkhFfhHH5b8m3
rMQ2PZlc6qpLbA6hdJpOez6sIGe1mQ0X7NfUFdfw0Bnene6wlZTiseyzRxqcs0v9kjlJsiIl
LIcneE1YECk8W/eEdc8Ih/4MzGM/Xoe4wcrEsFmHcykElBHwCFPP8Ac4C7xZhp4w1hu+Dqmw
EAO8JkN1XCsfzXzfxH40m344X/XQmy9dgDs0bxOweb8JEBAgWmsUe7GLWGtDIB2SthJHnDi9
1fjH6/un5T90Bgm2cktmfjUS6a8sYQdSeS+XudOKXxIWT5N/Am0yAEY5ee+GoaQPiisCLyvQ
5rtyWB5P9GI196fRj8l1ZwpFQda7Ezu25LVY2HYbfsz0jfkN6WPzodyEpMILqFABGssaW2lq
DNHax1KH+OsbQso0HjtaAcbhh0QGdmgWlGPttkkjwiQw4kWMABe5HPQxBfjIJ72ko+VTsbnR
rYDBYXj1NZCAREggDtCWWnktFWBgZNl+CPy7uaJasZuukuzEQzIQKyaShimv9TMZOqG3JkDI
TdlGf7g5AbvCtAe5piTl38PpoW5soPPr1iATPSuCpY8JE0RmQNtdhMa+Yrg+qbk13HXV4Rp7
Af/jy2dETTgjUe47Efkc6EOMWEJMfc+fG4PNvaz4JkFH+YC5EWhV2evnx3e5B/g6X/CkqBDB
korFN0Kj3Oihh/Qa0ENEXEBBxRCHuOD5kdCCkuFHWjAyXyO5DGs/RrUAQKsfp7+OY8wNmuIY
aqCe+snNqDMjjbiarRTDD/NaEaGCriz+ajmr9KcYlra8t3feumWI+ixWcWuFytAQNKyozhBu
kCRFEfkrROC3H1bxEqE3dZgsEckBCUbUw/UAQYny5eUX2C7NCvKulX+hqsaJ4HkFppgz1xte
oRz3UyuCtGDDesc94ZbQtttNFtWaWeixTMAHjxl29kHRsVvnrpeb1Dpn2nUSuHDLE/3WMV2t
1roZBBgCM5FwfjL46tGvlP4T7JHVdmZpkZtKlTI07pskMBwSngq5xWJo9N3OPCLrwHSI49dT
gNXQ8Pus5A3+2Ad4UrlO/BEPo868IaZI1iQV4eVElSHh0706ySP3mfjmRiXQdII4q5dosYvQ
IHnwVgJ7f3q/rfp9lwnMlHzwGXbrxNGHWJGVnZHEQLZstU1wC88i9Lveka4eWSOJFVZYwf9j
7Mma20Zy/iuqfdqt2szotvSQB4qH1BEvk5Qs54XlsTWOKrbkT5Z3k/31H9DdJPtAK6maTCIA
7LvRaAANCC05emC/n/6+9FY/3/bnT9ve88f+/UJFPlzd52FB2zwECh2GcnpRlZW3ZKlyf2BF
4LUy+znwem/n0+X0eHrR02QXMRkRihWoetVLqzdxVehlWruX0/mevwpruE1VdVx6msGe4yPE
FJRqiqM1Owc7/n1+OO+fPglrk5kEWsgcrLAxSpVVdY9+ejYLOh2fX9Q0PyKI1NXS0hK5E9X2
O5YuspQ/mFF7DHfFFVt45kcda0t8HG2r1E5bEzMnbhuXFrJdk55sSjMO+U77Id8/dLDUz2v9
AgkQOKNzz1+HFbpCpow0UgsylvlVXKOlSFuHAokP1tKlXXaKfyj9j0Bn5RDQVmEJbMwgs+Bp
bIHCHSxZBQqrOtSf0AuIM89kixYaQTiy+DOper34POyPZ1fI4DanUvatKhNW+lSOHpOOld7v
kCGP/g2y2XACwhdl85cEa/G3UI8o8k85gZumbagGlvd+eXg+HJ/Nbek9Pu5f9ufT617NLOQd
H15OzzyErAxh/Hg6wmcXTUbxgpupGjFU/K5ZhAk6mxdCDY+QRTbl/XX49HQ470XaeLrw6kZz
epcA6TYotvvD28MjFHcENvDrtg5U0w3/PdR+34ynn9tQk9i0Nn5z+fN4+bZ/P7Tj0yCef8Kx
8Xh6A/4kciM1BOn+8t/T+Tvv9c//7c//7rHXt/0Tb6mvNq/jIMFkrhsGhW3h8PztopTeMKwy
Hv64+dEOLozjf/a9/XF/fv7Z43OJc818vYbwZjYZW1UU+/fTC5pWXEMoggpLA0fvU0/kCHk5
HfdGuL4yuXHEewDkbmm/iCzf9g/fP96wOh4F6P1tv3/8pr3Sy0NvvaGCDcvDtG786Tp5VgbA
78/nVoXe8el8OjwpcTXly0kZs6JbENEdnkgYQKXKMOcbipelEjWow3PnTIHuoqw0Mc7svMpJ
FXTY1NDed51YprQUtyxrfPOFUTppUS1lcGsrYftRjguZGusYf9W+YXfgwNThlMGRPECPo/A6
YMnQqMFIubwswnvDMaPzSjn9lwc/fUEe9ZPrKCoQyD7R9xYMPgtCJs9fR7RnN5sqadbEDUe3
sIRFjXMfhw6xFylWAS31ozMpiE95lZEp8MI4hu2wYOoByIHiE229CtpsNnNF8EWCYlE5YiZu
vrCq3BBtsUgqDGNFzyyqMrK6iNYspsMAL3Nc5FzIiDy6JaucW63o7wF5dawTEJKudAGubR5/
Hn6NCA7F3IuvUUAR99fwsJS83AuukaAVeY00nu+K58L9yUp8t53TnZWvQMM0zu7cq+sXazNn
9V1CtwC9+CqvuNoNKfIuqmuz3lCtXD3hzfCTnGZWop/+qsJ/jUaOxCCCCv7f7/eH9dZp/hV0
3It564oBIGi2rs0iq7o6LXliZyTtSBYJJkmhziPhH0pscFFs5q1BzGX0ODcf3zri93Bv9nqZ
bOjbu6ihcEQIl14j6BMKkNTIxNhtsW1umqqJkWGOqS43hZD7imwEonVVOUK8ypLgmKrMshpO
EO9avq3oeRJhz9aOkuYYpR39WnTOck1T5a8KEJ/bSqhvE+C5XppRLYH2FSEwtKzKY9UY6Mdr
TAEQZxkILIpey9uGiMMQDnAqh9o9J8lSxLUCrYhl4L+cHr+LQMkoRWpx7dtv4IozGTkCTilU
fuCHN47wSioZT1lRO4I5qLWKBMy/IksdwawUEmH++SWVw49KJdnRgVpUEnwY9suu4bP7JB9M
aPvl6q7MWUp6WYoJK08fZ00h0S2MsuD2d9WYANBwW5lQ/pNf0DXKRRy0lB1T4OE1cuaIhrIS
zkXAnX9BkFQbRyyThqJy5A0IZURCfKlIn+rA8BaOMEsMRn5DBZmXt5LX02X/dj49klbsEJ3D
TZO5+PDt9f2ZUKjnSala7vEnV0KbsFY3qQgNIPCa4VXE/QXq/2f58/2yf+1lsG+/Hd7+hZeY
x8Pfh0fFv1bcPV7hAgxgjFRi3MIX59PD0+PplcId/kh2FPz24+EFPjG/URhyumN1WXhkJAh8
ctbaA3eHl8Pxh6ugHYtZuqu3Pr0Gci5cRwUZszDc4ZHT1BP+uMBNTyY3oNyPBTncVH0eKZNe
c5KmYF+N8GM6genlKsGtsDEaO8IcSUK42g3GkxvKiNlRjEYTxarbwaWLgFmmzfJ0fFHN5jcj
zyqxTCYT3R1UIho3e3rzwSYpqPCPTNW9M1Si8wixmszSQmufemqg4NHnOkvRdb3QS11HLOJU
Olj6vIVBV62CFf9UQ4wq31ikvNYSY/W2JEOVpLwjInBLhPzA1hGYKjFFg7KLR+MJ3miJIVkk
3kC1Xy0SfzDpiysRDdWfwAbecKbn+PJGdCo4kOQCLd8aAnSvCD4+RVbWoS/rspOW6ANSSbqR
t2PUEl3vykBLa8oB5lgoWP/LekAnOEzgMFa9KpLEuxmrG0kCTNUBgqcOFzbAzcZkdkjAzCeT
gZXBXsKdX2hnbcJzUFM2ZcBMhxPNTl9W6xmdNhYxC68zAf9C0aqsvJvhnGoqIOZzzRPLx8yR
/QEyUVqM2dGxwePKH47VMCscoL6J5gCdryGTHE1pmySG+Zg6JMXEz0djMmUcXIrrr4PZDNuv
GAq8zY3hEC94KXA/o6MSfQuCXb3Fk8R+n8BxZZ6wml35mBNstWZUDJvVnw20ZVndxeP+qA8d
JgsD9BTRvKXtxL++vYCQoJzn/rf9K3+RVbbKXkXSi6Gr+UqqFii7gF/O9ITizLt13mK3X2dz
2499dXhqXAXQYiAuI4rZEK2nZavdUPTwZZk3H7YfyfvMx1FVIrcJEU+9B7HyaV39pD/V4v4C
ZDSjvEcBMR5rRoLJZD5Ej/UyNKAjPWVbOR47Akwm0+FoRC5NbzcZqInL/Xx8w726WivL08fr
axPEXh85+VSfR2S2DiMFJ3QbFAO2KNvjU5hEz/v/+9gfH3+25or/obo+CEqZZ1K5qSzRUvBw
OZ3/DA6Yl/KvDzW3Wv7t4X3/KQbC/VMvPp3eev+EEjDpZVPDu1LD79hE2t4ukuVgSk1kkm9G
fdVAIwHmESCPquV9kTlPKlYtR+J9iVjW+4eXyzdlWzXQ86VXPFz2veR0PFw084oXheOxGroC
Rb2+lpFXQtpcn6uP18PT4fKT6rWXDEcDMiPlqtI37SpA7k3GNKjK4VDhzuK3OTwruMqRIbXZ
TV/NwYm/h+0IMVgNF3wy87p/eP8471/3x0vvAwbFmDsGc+cQftbJTo3YxtItzuCUz6AmbaoI
VfqRExuXyTQody64ynVM05iuk/Rih8Iy+BLUJS1YefEII8QojCMPyvlIf6rEYXOHFLJYDVwm
MESRPMxPRsOB6jSKANXrEn6P1Ldy8Hs6VQO4LfOhl8N8ev2+9ta7ZdVlPJz3B45AvxqRI4o3
Rw6G1Br+UnoYR1e9Rhf9ibpUmxrMrDRxVWgv+2BLjcdaZKgsr2D0FZIc6hr2dVjJBnBRM+Sv
0cgVCb2qN1tWkl2p/HI0HmgnDwfdONQjsl9ojJ04hCCOm1FCMGDGEz2O1qacDGZDyra29dN4
bGRE34YJCBaO4NDbeDogV9tXGFMYwjbZcvLwfNxfxGWnZ9mZvTVcSBW+4a3787nqKiuvM4m3
TEmgvskBAjtPk/z90WQ4tq4uZSW+drH41sSS+JPZeGSvNYlQ+UXy8XI5vL3sfyiHFjs+vhyO
Vu+vWryVZnLvnGKTV/QFVbjPdijtnHw7XYDNHrprZiuZDGZqBCSUMox1UuUxHj2WAGcWDc3W
WXic5POB8YpHHPnn/TtyfpKdLvL+tJ9QjjeLJB/qV178bR1KeZ+8BebxYKBe+vhvY8Hk8Ugn
KidTdf2J39ZFEaAjWosrVxcPuEPv2MmYbO4qH/anStO+5h5w6akFsI6oI7piGGsrP59+HF5R
XEAb99PhXTixWPsvZgGa8VgV1luVxUborqIFpiuivp4qYzefkA+ukHLWNLDav76hJKhPfTOK
8W7enw4UMahKcpEjuBsthNAjXcHyJ/N7cMRQe5maVnTsjW0SOow7WiIz+NG+rFJA/E27do0X
0LJ0xv/tCNwp2pCGvxRXL8cIhJueWRmAzBBDgvEUtzwRsx08xMM0wYxHyazT4vNA2YgSswW2
Rt8Q0AtQhvfq5I4M/VMq6DD9aFwma2F55lee1n7YImGFWrYKk2KRz5SjRE+kmfh15K1D+qUa
YoEZbpleDYLvClziIWr0aXMPEhFZv8VmWt33yo+/3rkevhvIJow5oBUO5Sf1Oks91JwOJaqb
sNU9GpPq4SxN6lXJaAWKRoXFOKl8WCW5I1YLD0blq9EqE19z5oOfzlWKuDi3bR/5/oxvYzgv
eRW3GnuBCV/LbpuuNmmAqZhi2wjTuUt1izANiozRTksxW6TbgNF519UoS82byVYm03+0t2QF
VGabwg/tfGgKrn3RrsuCLT6qCs+/5oLgiGuH/lY0onQ4gDgzi8QsoXyfosP5lafBpWwiASUQ
tjmgYSC1mKfSWUjzow/8YOGwtAYJY1T5GKXY4Kgc5Hspj16OWQHSLK3DiMGObxPvKRcGv2Q1
W0QVNJV0F4vuaj9a2g9iVXiT0Jps+jLLlnHYjgRty4nQ3xefGlYrdEktCX1/tX8+P/T+bqag
Vd7ImUG3RM5ZVBlNeM/fYdAy8VC/GybuZZ3oHvXhrhrW9BP6XTUyHLolCDhEiTnMfcrZpKEp
Q39TiFgKHWasZW/jgE0ZYt5q3hCjrvFv1DW+UleY+sV9jsH9rEboOL1Sly/3l0WgtRB/O4mh
imTB50I/txjMM+Aies1/sVASganthtrgNZA6G+rcuUVgkkt3WSLTXeKVaxHMmkDqk7+orjQ8
ZbGolRqKIf9OWYdD2TobCv/tvKrSFKIN4tpKaGiUlaB/DxMBAsi19jmWBMdyO5/BobWvuds+
S7+Evr7colI/XtRuqIsSHQ3MvSZgInpWneVk0xmwGevNRAInIYbwuXfgzb624DSrWKTsosAE
MAFogtA0H3otXTdsEiaZENpBE1bC8UM+17jdZJWi3OI/0dUXA+CIqyx6cGkCEWZ0lITAYx1P
SwTeCI0ggFURKmf1bZRU9XZgAobGV36lzJq3qbKo1FlaxNmZ+mJko6r7s21YxN69vpFbGLCH
gBWYLzXQHwFRJF58593DygP5N6Mi2yrfwCkX7sgKU/7GRYZbkQ8XHr+p4SGi0mJiEmTzF4ti
xcoqWxp+HhaVxUItimyBGwuEOPLJHqfBla4OewszZ1/BtM1rOx98Ain/z2Ab8NPVOlxZmc2n
0742fV+ymOkJvb8CGcloNkGkfYq/xaMjoSPJyj8jr/ozrejaI4NhJiV8oUG2Jgn+bh4VYdwb
fP33eTy6ofAsw1sM3Ks+/+PwfprNJvNPg39QhJsqUt48p1XD3ZUrc1RemVWOLu4saSd/3388
nUDcIfpuZX7lgLU0nKswkM60XcqB2G8MHMuAKxooEBjjoAgVPrgOi1RLJKsLm1WS693lAPp0
Mmj40UYpcDZL4HULtRYJ4i1XFi//yzhO+UMwvqLvyypMVNZS4Ftig9wLrAmTIGNSGmRkFBDy
o4MGyXfL2nGzsuoDiAiDSu2SRWjRc5BL0lqYzbM+/xI5ZRMfdr/GrvlvceYaz08kKqmoK0N5
u/HKlbZqJEScwRYT1dGCp18pl8etSvIa40fHdEGSggdCpq94FCUezHRktJa8EchM+FctBFIL
jr+OyfbFX6mnMF0tX8mvvpZXx7seY2DT7SKWudPt5oTJAu6pYUDNTOEtE8yiLs8zLGDU8tKd
tY4SlsIWp+XzxFiFq9z6/DbdjV3yPeCm1AfTq5y0kNVSShw42jTeyH/zOeOPUcyo7hIPk9Si
aeVRQzcm6XQq31SJSLju8CqBQgdigcXx3LHirX6EGsMufgulndq9zRUGEu4yk4VwiCE4GD5a
IJ3CJXutMl6ibP1NcVw2hyh1xiK6OaTrsZoWQ8OIhBldOzTcDWU81Ehmk77z8xnppWaQTBzt
mk1cLRYZlRxVTik9vEEyvPI5ZRAxSMbOdk2uFEwlqTBI5s7P56Nffj5XfUqMj4cujJrpS2/M
jdFLEEJxfdUzxweDobN+QA10FA92Qpc/MMegQdDKZ5WCtkurFFRUDxVvzV+DoP2nVQrKe1rF
zx3dHbmqHNA+WxoJHRgJSdYZm9WUbNgiN2bFCUZGzBIyAEeD90M44329KwIOl+pNkVFl+kXm
Vex6sfcFi2Oq4KUX0nC4bq+p2hg0kQ4U2lKkG1bZJfKui1j1VqHVplgzMrEEUsgLTKdpju3A
Zev9+bh/6X17ePx+OD4rz9vxkKpZcRvF3rJUgpXyr97Oh+Plu7Ccvu7fn+0IJ1xvseZvUzSx
Hs9JTKjBU4W2p0R7UZPhgGyKsWpOy6qm/AAGlfKvD+5TDwOvakFS/NPrG1y6Pl0Or/seXP8f
v7/zLjwK+NnuhdAPsjRS/Kc6GCopNr6eqkHBguzveBikEAV3XhHRO2oZLDBwLMtJ7WaY4lNi
rhOC8kBA8b1Klf4kPtngC3NUCiq3ZZA1xJefB/1h+56+rKAuYIFoyFVvV0XoBbwsQGmyRrop
wwCJF1lMSkc4k9ldqurQFI1rI0FC8fiCoGmkMUqlUDXi7S/xKp9a6yaJGJQsje/NPucZV7LZ
tUQZmqfuQm/NXzLQNwWe6gVls+JWVUK2wFZzIMb+c/+HYjpW6YTBl1q2vDF4Me/Cdoj8Ab1g
/9fH87O2R/n4hrsK0+2oCk5RCmJ5wmq7ty2qWSWy4a45hGHDl9/qZVeH1yksd+BSukLaoMGs
IM4+c9oijMxeFFngoRYzVMMmCJTQlpV29yQChjmOKjr8lU4YCR2poxj+vs5hu9MIUU7+DbLC
3/BF/8tmiSsrcM2NXLQklT6FqreC3ECxR1m/+aNYud6SMIlh6dtD0GCcTcUk0et6UwrtjfH1
lrJCt/lUJA3meVejflwFi/dUwDmZtRrktoV9lqvMpeslbyrqhKM4uzO/NpHmGK6MkHFCkYlb
sode2h9v4iRZPRyfVd+hzF9vciijgplSNXKY7cmJRB8LA4m9i65SdEg8HjH0T6KS5fiu/Hdo
6q0Xb0JYRRal0mZnaSaNWZpobb3Ch/aVpwbNb1hni+LbDtOTD4Z9/eyXDW8Jc0d4dyetbFUb
qfDuFk4MODeCTGNwSAmnSpapC0oDm90TyKbhbfklHG2Bec0WQCladPoghLoNDuIjsenCNBBn
5hWWg01Zh2FuWI3M4wDYX5Lbvie4srtzp/fP97fDER8vvP+79/px2f/Ywz/2l8c//vjjX6bI
VFQgeVThTrVVyK0kX3BbW5smv7sTGGBj2R36EJgE3GrYnHOt8Alb2bYHCmVnrgO4eYcqVKMU
4CaafxzaOFlb7eWsPXhKoyrYpyCxh81p1k5D10n3iaUL5Mo6wsXQqJS6ElECglHBxEZhGMCi
KeDy4fDskrxeHChOVg9/tuikpNr5ZNeZfTjnrAGbrPTaSuS2VHb9tPVB6oZbHTOeF4iX5/6G
FJT4egBk10rXVODhjMy2dkwD4o1vFQweQDAhMO4NExgO9LJd5nXEhbedMs7oNLAoIaIWlnBq
UAozOkiFqC8mzYjQRhk5g6/9sPEv1C6YciLqsCjg+Gkt/pRt3ukT4LEYhQ+1XIQJWY9vWbI4
oEi8NUqDtxtjdjgSnRTE6NLGVKSJcDv9urHEdcSk6PYXqkCNy0MMw5f693QEKnQeUD+3En5g
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
ASDKnPLQBQIA

--ibTvN161/egqYuK8--
