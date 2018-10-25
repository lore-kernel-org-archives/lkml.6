Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150E62082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150E62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJYTYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:24:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:14543 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeJYTYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:24:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 03:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="gz'50?scan'50,208,50";a="102558373"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2018 03:51:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gFdEl-000F7G-FG; Thu, 25 Oct 2018 18:51:35 +0800
Date:   Thu, 25 Oct 2018 18:51:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Message-ID: <201810251848.0wSJMnS0%fengguang.wu@intel.com>
References: <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sergey,

I love your patch! Yet something to improve:

[auto build test ERROR on linux-sof-driver/master]
[also build test ERROR on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sergey-Senozhatsky/panic-avoid-deadlocks-in-re-entrant-console-drivers/20181025-181929
base:   https://github.com/thesofproject/linux master
config: i386-randconfig-x077-201842 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/panic.c: In function 'panic':
>> kernel/panic.c:237:2: error: implicit declaration of function 'unblank_screen' [-Werror=implicit-function-declaration]
     unblank_screen();
     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/unblank_screen +237 kernel/panic.c

   186	
   187		/*
   188		 * If we have crashed and we have a crash kernel loaded let it handle
   189		 * everything else.
   190		 * If we want to run this after calling panic_notifiers, pass
   191		 * the "crash_kexec_post_notifiers" option to the kernel.
   192		 *
   193		 * Bypass the panic_cpu check and call __crash_kexec directly.
   194		 */
   195		if (!_crash_kexec_post_notifiers) {
   196			printk_safe_flush_on_panic();
   197			__crash_kexec(NULL);
   198	
   199			/*
   200			 * Note smp_send_stop is the usual smp shutdown function, which
   201			 * unfortunately means it may not be hardened to work in a
   202			 * panic situation.
   203			 */
   204			smp_send_stop();
   205		} else {
   206			/*
   207			 * If we want to do crash dump after notifier calls and
   208			 * kmsg_dump, we will need architecture dependent extra
   209			 * works in addition to stopping other CPUs.
   210			 */
   211			crash_smp_send_stop();
   212		}
   213	
   214		/*
   215		 * Run any panic handlers, including those that might need to
   216		 * add information to the kmsg dump output.
   217		 */
   218		atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
   219	
   220		/* Call flush even twice. It tries harder with a single online CPU */
   221		printk_safe_flush_on_panic();
   222		kmsg_dump(KMSG_DUMP_PANIC);
   223	
   224		/*
   225		 * If you doubt kdump always works fine in any situation,
   226		 * "crash_kexec_post_notifiers" offers you a chance to run
   227		 * panic_notifiers and dumping kmsg before kdump.
   228		 * Note: since some panic_notifiers can make crashed kernel
   229		 * more unstable, it can increase risks of the kdump failure too.
   230		 *
   231		 * Bypass the panic_cpu check and call __crash_kexec directly.
   232		 */
   233		if (_crash_kexec_post_notifiers)
   234			__crash_kexec(NULL);
   235	
   236	#ifdef CONFIG_VT
 > 237		unblank_screen();
   238	#endif
   239		console_unblank();
   240	
   241		/*
   242		 * We may have ended up stopping the CPU holding the lock (in
   243		 * smp_send_stop()) while still having some valuable data in the console
   244		 * buffer.  Try to acquire the lock then release it regardless of the
   245		 * result.  The release will also print the buffers out.  Locks debug
   246		 * should be disabled to avoid reporting bad unlock balance when
   247		 * panic() is not being callled from OOPS.
   248		 */
   249		debug_locks_off();
   250		console_flush_on_panic();
   251	
   252		if (!panic_blink)
   253			panic_blink = no_blink;
   254	
   255		if (panic_timeout > 0) {
   256			/*
   257			 * Delay timeout seconds before rebooting the machine.
   258			 * We can't use the "normal" timers since we just panicked.
   259			 */
   260			pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
   261	
   262			for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
   263				touch_nmi_watchdog();
   264				if (i >= i_next) {
   265					i += panic_blink(state ^= 1);
   266					i_next = i + 3600 / PANIC_BLINK_SPD;
   267				}
   268				mdelay(PANIC_TIMER_STEP);
   269			}
   270		}
   271		if (panic_timeout != 0) {
   272			/*
   273			 * This will not be a clean reboot, with everything
   274			 * shutting down.  But if there is a chance of
   275			 * rebooting the system it will be rebooted.
   276			 */
   277			emergency_restart();
   278		}
   279	#ifdef __sparc__
   280		{
   281			extern int stop_a_enabled;
   282			/* Make sure the user can actually press Stop-A (L1-A) */
   283			stop_a_enabled = 1;
   284			pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
   285				 "twice on console to return to the boot prom\n");
   286		}
   287	#endif
   288	#if defined(CONFIG_S390)
   289		{
   290			unsigned long caller;
   291	
   292			caller = (unsigned long)__builtin_return_address(0);
   293			disabled_wait(caller);
   294		}
   295	#endif
   296		pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
   297		local_irq_enable();
   298		for (i = 0; ; i += PANIC_TIMER_STEP) {
   299			touch_softlockup_watchdog();
   300			if (i >= i_next) {
   301				i += panic_blink(state ^= 1);
   302				i_next = i + 3600 / PANIC_BLINK_SPD;
   303			}
   304			mdelay(PANIC_TIMER_STEP);
   305		}
   306	}
   307	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wac7ysb48OaltWcw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICPub0VsAAy5jb25maWcAjFxbc+M2sn7Pr1BNXnYfkvgy48zWKT+AJEgiIggMAEqWX1iO
R5O44rHn2PIm+fenGyBFAASVs5XaRN2Ne1++boD+/rvvV+Tt8Pz17vBwf/f4+Pfqt/3T/uXu
sP+8+vLwuP+fVSFWrTArWjDzIwg3D09vf/30cPnxavX+x/Offzz74eX+59V6//K0f1zlz09f
Hn57g+YPz0/fff9dLtqSVf3Nx6v+8uL6b+/39IO12qguN0y0fUFzUVA1MUVnZGf6UihOzPW7
/eOXy4sfcPB3owRReQ3tSvfz+t3dy/3vP/318eqnezuXVzvV/vP+i/t9bNeIfF1Q2etOSqHM
NKQ2JF8bRXI653HeTT/syJwT2au26DNmdM9Ze/3xFJ/cXJ9fpQVywSUx/9hPIBZ011Ja9Lrq
C076hraVqae5VrSliuU90wT5c0bWVXNivaWsqk28ZLLra7Khvcz7ssgnrtpqyvubvK5IUfSk
qYRipubzfnPSsEwRQ+HgGrKL+q+J7nPZ9Qp4NykeyWvaN6yFA2K3NCFRssZQ1ctKKuHN3k5a
U9PJXgIbxyCKepthd3BkUZ7Br5Ipbfq87tr1gpwkFU2LufmwjKqWWPWWQmuWNfGUdaclhaNd
YG9Ja/q6g1EkhwOuYc4pCbu5pLGSpslmY1hV1r2QhnHYtgIMD/aQtdWSZEFBKezySAPWEpgv
mHOvuZzRGnK76yu91GUHB5JRj12ym54S1ezgd8+ppyuyMgT2AjR5Qxt9fXF0F+pTvxXK2+as
Y00Bi6I9vXFtdGC0poZDxuWWAv6vN0RjY/BO368q6+seV6/7w9u3yV/BtpiethuYPTgK2C5z
fXmcQK7gmKwZMjiqd++gm5HjaL2h2qweXldPzwfs2fM4pNlQpUEVsF2C3JPOiEhh16A+tOmr
WybTnAw4F2lWc+vbus+5uV1qsTB+c/seGMe1erNKLDWaWdwKp+W3ivk3t6e4MMXT7PeJGUGE
IF0DdiS0aQmHg/vX0/PT/t/e8ektSa1F7/SGSU/9BwL+OzeNp7FCgzbzTx3taJo6NZl0xmoT
aL5Qu54YiD11cnGdpuAzE9MjHQTm6Mis0VkGDgjW69njMhXciMnrmGgUpaO5gO2tXt9+ff37
9bD/OpnLMbiAaVoDT8QdYOlabNMcWpYUAADOvCwhvuj1XA49JDgrlE93wlmlrJv1oAWQC8EJ
i2ia8ZQQ+GrwoLB3u4URiFFwltYbEiNUWkpRTdXGOXwOaCYcCZBMDr7X+aTA+WpJlKbD+o7n
7vdsHXKpE0qQI5rRooO+3SkWInbrvkhBjOcWfM4GInOBgbkhGM92eZM4TOtrNzMlOkZ37A+8
dmv0SWafKUGKHAY6LQZgqCfFL11SjguMKjjlUUnNw9f9y2tKT+tbDNpMFCz3t7gVyGFFQ5OW
Z9lJTg3gCI/bbogKzsXOBNDBT+bu9Y/VAaa0unv6vHo93B1eV3f3989vT4eHp9+muRmWrx0i
yXPRtcapxnEoPH677RM7oQaZLtAAcwouBQSN30PM6zeXyUVheAQIbJJqBvNjWjSjmdlVqrxb
6flmo9/ogefBwxxA1Q2cgA+2AwnbRs8awXSaBqMr940bOQ7y0irPGuarB/JK0kL24AXuiQig
gpSInI+rtp2JPMMlpjYWIQZg7vbCiwNsPeQcM4rd6IncCOyhBAfISnN9cebTcUsBxnv88+OE
pWKtWfealDTq4/wy8PcdpFAO+AAyLpzxpCBihq4BBLoWswkAiX3ZdNpz+XmlRCc9s7Xg1mqc
zcqO+wUBK09qYLMeOvGlHZKceCnVsgy3AA8eEqb6JCcvwX+Qttiyws9zlInEp0Dr6JIVOqn3
A18VC9Bk4JegordULa9gBr/hhCHn0P5cUD1wJgNvubOCblhOE8uAhmjEp2YKhlae4mfyJNue
WQoOiXx9lAniCMIqCGI5DdbagQdv01uOIGqBBduilni4cQuslpqINc7a6j2i65lyQhwrMdmR
ikJUp0WitQqzVFRkOBmbJihPJ+1vwqE3F009kK+KCMADIcLtQAnhOhB8lG75Ivr93tOz/Jjb
Icqw549lkzZSoEgMU+g06g3ALfjNFhYIeMbzDs75sOLcK+e4huDocyotBrKllKiNzLVcwxQh
kuAcva2VpT9ZFy4S04sG5QDtGeqMNw8wQ0SS/QynuAOfkcsa3EkzQ+4utntU65Tj333LmZ+R
ekGBNiV4UD9nX149AQBYdsGsOkNvop9gAV73UgSLY1VLmtLTSrsAn2BhlU/QdZB5E+ZpGSk2
TNNxt7x9gCYZUYr5e75GkR0P7H+kIWxOZYoj264dDQ3zgEAh5keFJ23TOX8Vx+rPNDNo2ebj
5k9KhYWdImnoTjmh8/6IXy3GGcqbcv/y5fnl693T/X5F/7t/AixHANXliOYAc07gJ+wiioOW
CUvoN9ymEol5bLhrPYbeoJexAqjWKbttSBZ4t6bLkq4SBWGrVEXH3HihNxvyEF71CgxE8MCQ
DOU2CvQbANYly0dk6Ie6kjVpuGp3WzgJ78hHCtqU095An1wJKdHdLx2XkLdkNEiwEctCorCm
O7B5sMWF4oydC+ShLGe47x0YEVgSxowcIXOkZnh6iAkBhwOw3pK4MsNA5RBiJeqP67gE5qiK
miQDfHW6gaP24GDLlIctu9aV1KlS4OVZ+wvNw+TYigVua6od2B5rIdYRE0vL8NuwqhNdIrvT
cAKYSA35bcI4weEZVu7GCDkXADw0lEOSE3O1PHdj0G9rZmiI/I9gF0L6DhAJpqs2CtgWUZeK
VuCX2sLV/Iej7omM9yRvUhsBcs6iI169BdukZC0FRIaIx9kN6NTE1nYOcURF8AMK0akWkhLY
rsDJxj4qcYY1UQXmABbGGTj4AQ6kOkmMPzooNexL0fFYwe02BwYX7CtkUy4hKV31KDxkp3cu
r8m5xAuDeMMd1dVGF3iF6BZq5YgrXTFlrLYmJq9pjo50uCvwnNoC3basAD3JpqtYG3hkj7zk
WkDCbiZ6BHsgAXALWXDobYzZIgk4ta4hKg3gZ9Kg/CL0wCeEESQvrcLtMTM1+D2nG6VC1B+7
v3m1YsHLtFj1osP9Biabsb2IYjguSXMMMB4AEUXXgAdEX4wYS/lqeHQnlmPjVnBVNE0iuKCL
BOgNFkBTrixs9TE8aiF3o6MyPmSCvLyFuAHbtgUD9RiiKRC4DfdAlzMGiVz35CwNeF0zVr7V
1kOKJ1hxc7eTyeYp1rG5wlvXrg3KTCPNwthZRazKxeaHX+9e959XfzhI9e3l+cvDoyuFefYk
NsPMUxXvcXwrNoKFACA6Yx2CkgtaNUU9CyoFHMG0r7wWg2pEZddnkZoFxQ+3KbaUCy6KFEnL
GqS69pTE4KDS2ezQg1b58Xoo3NOZJEvBrIGJXk0FUCZijBlq3OuRH17LRGZoa3cNQIbOixVZ
WIlqsoKUPhficq4ZKM2njvpRfMywM10liQ3L5nQIp7RSzCQy9VswvGJOBiMVxjRRrXXOhXVt
l4pdvLA30TbeqHCIbWZmhF5/mtP4p/n4mCkka/121wBECGlDo7UbefdyeMA3Fyvz97f9q29L
MDHDLBKEVA6LAam8h+tC6EnUyxVLliLjHPgnSGTZjLZhIC3GiTGx0ve/7z+/PQb5EROuINMK
EWjcSC/Ad+K2pstGg1Befjpx0Td0HVGHttfvnp6fv3l3fzDxU2PPpda7DI7763xWWXJWkoS1
MqLb8+mXvYkH85UQVtFfQFwNrrkGvo0ojn+Kl2y7BcOgS419Ztg6vL4nRiCgVty7x7NO1E0d
dExsW98K3IuQBaYdbYF3zLLsvWlhxew11SSyzIkbq2266Yw+BcaxbtBntMR/IRoeLvOcwb08
3+9fX59fVgcwOHu382V/d3h72Xtajl4nfG0zezJRUgIwn7raqW8JyOTSepWEOlUADErmV+4x
fxR4mP7hGoz8hQmHzABocBmPRW8MQA981jJUpZKmh5Ku20bqdNBCEcKnfoYa9pIllz3PWGKF
2M1R74br8ZKwpvMLacOjE6aY9k3RGSKoqnHwtLepVrJoX+8g2dkwDbi3CkMQbD1BXxYUMwba
vDg+FznqZaroteHH4abCxoYn3f6863++CDyKRldBregzIYwr903O7/3HqzSs+HCCYXS+yOP8
Js27WuoQgK9hHWfsH9in+WmtHbnv09z1wpTWPy/QP6bpueq0SCs6t5UlKto0d8vavIasdWEi
A/tyAUXShrSpYFVRcFjVzXlw1JbYNwvHk+8Uu1nc5A0j+WV/scxc2DB0pAutMKIsWP8A30Nr
t3aMtxDDK0B3HXrlizTnyzxb1OOYb/q3B5NXQzeP6VvIA00PCUMJ4up9SOasZbzj9k63JJw1
u+sPPt9ad24arv3sH4TB0bkJzMngSufEHFZAukQnNqPm1JDguW0tqTkWUn0a5V2Djz2U8RZY
+OWk1r5x1JhCVxgMK9ZOT/FCJoSP66v3MW8AXt41/MDxKM5fax64Q0fkqeo4ZCOUSzMrk4z0
jWjAMxK1S7tRJ3Wi3zGp9ZUKC1FY8Yv1UYzEIAAqqgTgInvBlimxpq31u4itUvHAKk94TTeQ
8Nq/oRXJ02sZpJzyLHc8aFEYo1tX6eZ5CmCMDbGMoWtAG5Gm2zGxpHwERN7VyNfnp4fD80vw
vsUvWA621ka3YjMJRWRzip9jbT/UAE/GghCxTYZ9e6R2W/sN9x+jh79Q7PwqY5EyUC1LdnMZ
vGw0AtxNRhJjsY9rH5w49UBtgD46uZD5s1wJfAq/dDQacw/fI8mOFf4wrcDXSRDoU6DHcd57
ubV95yHKUlNzffZXfub+FzVIAGWgguHnaifjGnwJnsVxSeLFswW2y2za0Hy8BrCP6Dw9YA2e
XDOCOnyy1tGpXnOy7TgpTtqOhNdExxk5XmLbhsZhb70NRq6dh+2n7tz9U1zWpDwqjQTkodPZ
tdJY0ar8Gov7AILpnKgi0fGwEf6zreMcG0DI0tgRrUt+HzXK8H4yvM8bSO4S0pYlU69Xjkxv
HvPnmRn4Wf8OyIFbgKhdeIOsU0o8ZvS2EuueCBbq+v3Zf8LPK/4xh5jRp+d9W1AxbZ89oKdL
zOF0ATvFBQSyJbtgeUkx7u7d/x9jWtO1gCe4MWgoOHikpo7HpqSTLCcnEpojN/3wFO/BFCX6
+udj1iuFaHxXdJt1qZrT7WWJccUX1IsX4qPm228FxutVzyfgnaPdOLy5XAf3DS4F3ESXLhAp
LGjCl47+ZlT4Mgo8Ws1JeL8evPqUJo3zrSuuKdhTBrktVhBUJxeMxAUCfCuMddMtYicfF9cD
Oks35kaF7/Hgd69JywxLv07D0SSJnTTgXd3LCmMxCd/XWXZ84W+T8mDjPejMw+IxLVNp/XC7
FpjZbX9+dpYKU7f9xYezSPQyFI16SXdzDd147oTe0JSK5YroOrrrlPVOM0R+oCcKI+N5GBgV
tU/BwxB2vG6y9wnhXtkHq7aVToxi0xMY5SKMvsLg5SK66MATA4TAPJ/7AqkNcEUFX8hLHNxb
kk2hRegSXFUbxkhFQoiqeIffFGb+Nscqjovqo28dhj5Cxec/9y8rgIp3v+2/7p8OtnpGcslW
z9+whh2Ur4c7sTSST8UF7MibDfwakZ49Jj27o3D3efid23AriE2k/12bpQyPXSyitG4Dupq+
DzzOycraHa+Sduj6krnqR60Jm+LT0FIvAlcro+imFxuqFCuo/9FY2BPNT/htK0HiNWbEAKLa
xdTOmBAEWPIGRk9dFFtmSeYNCsAZS/I2ZVb0Uy+DtzbjjlCNFboj3k+zWfB6L2TOJsMkT/kn
y1swuGg4UlUKFAuiylI/pqaK++8X3FI7bQTvCw3WUw6fkMWw2jW3NtRJwE1FvLCYl9C/pMm4
NeSggo1IIRo3QwHZMwvr8f6+MBHnvE6rs3Qy49rStA37W8KpqcXiszynspLOHiyN9OEhTNg1
MpIDF9KUczOLTOgGwPFCnRcvQoQEDWALVb1xK+G/kyZoIzKP6zK6ZKOfxE8Rypf9/77tn+7/
Xr3e38XX5KPRzK7ZsSX7/Lif0m/75UZgHyOlr8SmbwA8U7XA5LQN7MDF+/h7GTtw9vY6OvHV
v0DNVvvD/Y//9qoAeXBCqIiVQKiU3mPL5tz9PCFSMJUG6I5NWs+lIQlHDCmuh5A2DhxJ2k/F
dLQMinEA8pbFSXKdcjfI+dQxtY77O3XDgNZrutS3gMjCbK6h9gvVYfJBSyY2i71KlTYVyyOa
pUzTDhm/uRwdBWrATDfvPu+xSAS8/er++enw8vz46D7Y+vbt+QWGdXLF/vXht6ft3YsVXeXP
8B86FEH678+vB6+b1eeXh/+6q+ajCH36/O354ekQ3IrDtAFW2BrCbIrY6PXPh8P97+mew6PY
wj/M5LVJosrhg/vhUeFkQzpVKtI5Qj/PGdjftRqchJcqiUamRgMAeeMP01Lz4cPZefJUKyqS
yIAXfZuFaoOlhWQfCpZVsBQKsKnCTpfZ6M3oX/v7t8Pdr497+3clVrZaeHhd/bSiX98e70bg
N4Jb1pbc4OutaTfgR1gxtBe0CNiPxQB87VVTCIn+i/2hL50rJmdfyuInYrFkksiZzqeaGw4d
pgoDkr6Mv8Qe7syZCPImOJhxY9r94c/nlz/At3v4d9x6SGZB0jt4RwF/RVL3fl3LvIda+MtK
+h2YJhmMSv87BPxl/35DRBq+sJjSXSTqLuvx6nmpRI0yrvizkDPbTrBKpg3LlyaHjzoxcfwa
KDc+604Zndve8Zd034cMX5pONiiPT2J6W65PATkQkq0MOoPffVHnMuoLyTYnS191OwFFVOrr
N1wKkyxUEKBUqOCUdzeT5jlGb7q29SubR/l4h1wnx09tlybH7Q6kfNIOi31izfyHcq7jjWEh
qSvSEytFNyNMi/D6xYPrSR2iDbyo0qldY24ag174RKsxw0xCznF64QBOS7Hq6uprIvnVUSwa
LTViZzQ0XcuODXeyy1xiyK5OPdM6yuRd5teUR/c38q/f3b/9+nD/zm/Hiw86+FZVbq6C2cHv
wQzwIiz9baAVcp+PobH2BUlNExd6hccYLf7qxDlezQ8Sx+JMXoUneLV8uFcL1MThzqcWH+vi
PGcHvMC1ezl8aucK3+HSNDOz/Qdaf6WSe4rsFsv89nLA7CQNz3K+diQ6h+BT0BZnlKlxOB/r
NyV+z2FrJ8s6MXcf0cJoddU32/nWJsRqTlLYBrY3+tYAKPiXYLCoiNXa0MVIA7bQEK1ZuZs3
kfXOgiqIO1xG7z9Bxj3+X/KVRZ4vOnmdLwQAVaRCm3F/WWTyAvjtAqfgJdCZLjRwMd3PdE2q
EtZcmCBe4u9USSgUCP8swBgEjGeYXPkvfBUrqiDoOErPKsBlGl9hLvytAie2aUg7fGsx/0rA
OkxNwoNFwteIMJT4ZoKgtzhSzpc56OywwpiWWOvbNAOm/Z/Ls8s0E9wMa/x82md+yr0F2eV/
PLs4D14AT9S+2iQBgyfBNyp46Jo78DMVOixlGeE0jf+nCpr8YtpdYkiznn7io2giwR2EZCaL
QkY/8VI4uCe4+DBJNER6z7dlLQK4dtWIrSSetxwIo+rOJPu2zufSQIQW2qQ5pSIVvgNKc2sh
04w4aPo8LjLWMJPCo74YngNq+kIv/8fY1TU3buvsv+Krd9qZs6exbCf2RS9oSrLV6CuibCt7
40nT9Gym2c3OJj1n99+/AKgPkgLlXuyHAYikKBIEQeChM+tHMjuQiZr6vA8rbOZEZTtd2vhF
kJHIzPMqZgUhnyvJiWKH8lV1EjQAjWESRREO4NWSo53ztP0PpYAn+K1MT6ohiYAEjqE1MNuG
cGcYQvbVWwYzBR7xLkPJOV3CHDNhVIEYXoZeBJ0sKObe0o09tfsv740x5VLOU2AIhMLGeRk4
OR+gaUhk7paAKb6fdVwBfjdVAUr1qD0jnP7SX00N376jdBvWjkzpBJy8zejgYcyVIU3y29H+
NyvZDbBGjrB2HnvFqUsaIvRaoA5tDZ8uELsKDWjNsoZVLlkPYGWirVQxYfOYNk5j8lvYDTJv
KjNL32Bom8dZzioEmFH3ZxsrYHtnbYQo1b6uIpG12Syet49hTrWoeLYLY/b+9GajGlFLb+td
ZHyYvcgqEQ4pIuXD419P77Pq4Y/nV0wHe399fH0xfCAC144f5i8Y8pnA3HQTKACqqsyz6qpQ
qG2oCtH8O1jNvrSt/OPpv8+PT5w/L7tNPFHt1+h34WdTeRfhQQ87i+5hVJ4xkTYOG1M39PR9
2Nj6gTilmCguKg2dfi+MV5bmqgk/zpU42YQtWEIWYXfq+gh+zULdM2HfM4bkcVT6sRmRVDoi
4VQw3hBJUqQSEydxa8TahiiURqHjFN8jnY9RwUKnufLmhjsbR14SJ/hvHNoNz9r+tMopI3FL
/v6Y26RRF/wmMEjA6RdNRLevW2LHmsy7QMEoU65DnW2aV+D2KHDITZaRNpN8VcRuxkE/eFQJ
zyEOxp8Pj0/O4Nkni/m8cV89k2WwmjdsaQe19ZaGPQF8t7hIhUjmI81psNNjnu/W9o4u1+1W
prY1WsP+4jK5FdxjOhhD58Sw2X2WJbNFmI8oZLUBopgZOqUeG84kYs8iTED0g2Bsa2O51wd6
L38/vb++vn8aa83hGR26blZr6Rn4XdU2fy+Tbe30jkGmHHQm8oOR3Jp7O5NR2TibmnUQrF+v
fU5mwdWiYdpUwhTlMyZagZgfCJp7hD9OoVl15L0gwBP1fsHFSQDrhEgqxs5LxLCyV6U0S+9o
tFfhD6Z7CYprPKeFZ9HrBX1YYFVza2XGx+db88NbxsRAPiVVlFqJyB0F9woGFXcO9okPkWxw
PSIpM2WjFUoM60zGOzT2rVQYvcOYE1pvxodad4/hfI3SAhGfT6JCzGQ1LpuymOFFCIKJorx2
4ZYRw8TELisfRQiahpHrnLqlDf4zsL0xmZ2IrEIxxjDv2Sert9Nk23WRQzlTeDeIG3aHw5My
8zPr24RjdtApg/Wld2Rz5pU6Fp4TYYDMnjATCf3biOw7JUDlnW/xbcLCT6GBunGOXTblkMRs
mfAbPyqeFElsGmJJ7ELDEA1KsXYNREQ9OFCico99ZK0bLQ1dVXV9PxGr2wniGDP3pax0HrPJ
NUrAFsk2rMFEslx8nCO3ZYUIG9tGI7ck2JtAyyzwMPKHRUfSZkMktrjXDe8ZbSCAY5QOyN3P
jy15VrgnpweNn7WP0tLclltkDIjdG+FXUHGdlaaHqaOcMxfnAgZiHgoE9OBDJipdUZxUGagM
jRbFrWXxiRAkzDbCtKxE/6TRvl5Wg/P079bXygqcY5GmW8HG3hFcDhoy4/NsjMQ+eXgO1XA1
knEDqtcz5Hrrp/IcJmgBVMltMTCEs+LIBsKjkKBM7VZUY0/3mqbHCEZUXTAoPNDUyD4eUgTP
JweeddAJGto6t9e/z4mJA9vSlBl32tKyzNyldw+bCfYYG0KQ/iHCu8bmOEBWHOUy6iEUh25C
SBMbqLSPv9KGmrWvhX9yin/nVGttpYbBT+pZbmFBHjSUMtkQFMLwxpgsHUtF+SOUivJh7i2A
cNYohNqMPR+LIbpBkaf3toyBvVFbCeDIFNWNZozDe3qwjK8P394MnXKAH7PsFcEqNLBf/e3h
y5uOTZmlDz8suxfr2Ka3MJaV3Son/yY2UTTz2LZK8fe54rBFktx6sIpDKsnMcldxyClwlbmS
2KqiKH2ftMf3wHxL8l91qrcS2S9Vkf0Svzy8fZo9fnr+ynpN8FOw0f7I+S0KI+lMPaTD9OvB
4t2iyLVYUOKEr9E4kbYivz0TAPB5bhfucINJ7tIZVVB/MmdoAddS2vuAxvY0k14mg0UxtOcK
0mEJEeNqDnWSOlNBZO7XrApPpjsO/K2KmKC27OHrV4wxaj8gxl/pL/rwiEgWow9aoBXQYF/h
AZ537OzvKSHkM0NsQ6Lsl+l4XULF2k6oMEXSKP+VZeC307jPgcmGfr65biwnIJITuW+J1gtG
ahtMdaO8XV8tmykJJbcB5gAq/sYGFAE75/3pxdN36XJ5tWvcT6uja48IAudR1+Qq0oOCvpp6
evnzAwYqPjx/efpjBhJTLk58PpOrFWtmAxNxauil3A7rGS1cDCF+8jFftrgvJIqmYrAq15xj
jphyXwaL22B1bY8vpepg5UwSleoesYZLJUafHf4A1dseUt4BdqE7f8Lnt78+FF8+SJwzPkcp
vXghd8a58Bb9lqDHYNP/63w5pta/Lh1NnUe5YP0eNKIQrjKS0n7VjgrKX9r9ghx3iPXSW89l
I71QGCEOqtcl2MvtyoS/k6WXAEur4A6ChqoSdVsQzgXzagNTrxl9kNT4ZTnZkHDPrrgXdIUx
u++fNfO83dY0E9whpuVgFHjwRjoRKWIPWkgvoVarRTPVHPwLbzMZd1mPLt1qibSEbpj9n/43
mJUym31++vz67cfYpUfKCcXs3r2jG5SYpRwsX9RW46m2nn//7uoxW4XqJ2nbt6RAHrAb+Z0B
imrdqEr/iHSkpnzqWP9hyxdTxEynu4liGmXUdq74CGc7zKejwi4tEbwncHgQtoIxF2JtSKgD
XWwyrlY06/XN5pqrex6suYuSOnZetI3u6GYULIXA0lYtg5kldlHvMC7HB3ggbCfltQB7I8I5
P6Qp/jB8xS3HBPqWobOcQ5OTkJ9K3fN4ZKMUjsmkXASNx5nbCodCbq75NNNO5OAgK4wE0qLg
V72+kmrL+ra7rtha27KOrJr1xEPWEmgQW0ST4apAk0deNDNvnvoXj21leDTPxExyu1lF6NNh
l2kJnHzZ54gWjtmL56i2bIz2QB+aNtlvTreN+aoZnyjlxywyske63RdQtYP587gceoR1m+FT
OjBS1NxaQQKx2MKSZ+yQNdVy1RMJ7OBdxJjrz2+Pxla+U29RrkBBntNELdLjVWAt7SJcBavm
HJYFH+UdHrLsHr0PLDfZZmeh+EFd7kVeeyxhtcOkIsmvdXUSZ9TDfJVSbRaBWl5xtmiUy7RQ
iI2HKfJ4Wma+6748JylvcogyVJv1VSBST7yqSoPN1RUX5qhZwZW1zW67vAbeasWZqp3Edj+/
uTGzd1o6NWhzZVn6+0xeL1b8UWWo5tdrnoWH4OWezf3CMy8dl3KOldgs18YRNCyDNfQg2Hzl
YsgL65rpWMlmapTvKkMZuEHUmgJjDEoT1TmY212lU4CiEvdTb+481HRQDIF1xeBAXnHjQ3Pb
wM/PDjkTzfX6ZsUUt1nI5tpf3mbRNEsrMK5lwH7zvN7sy0jxi4fc3syvRmNd30j29P3hbZZ8
eXv/9vdnujXi7dPDN9iqvaN/Cfti9gJbt9kfMOefv+J/zXvBziYqoakAyAs5nAViCK3AfXVp
x3GTNZR5smB77tmj7QaBuuEljtrBfcyYZL/kC25/s0SC4fnt6YVuFXby/AYRdF7qHVXHUzKJ
GfIRltYxdShojzmBPqZ8+PYHV41X/vVrj/Wp3uENZtmAXPCTLFT2s3s2ge3ri+tGkdxb50mY
TnauauWPtxgk+MNljbRu3S9o4JO+PD28PYE4bFJfH2nUkRvzl+c/nvDPv9+/v5ML6NPTy9df
nr/8+Tp7/TJDK4p2AyZUb4g5bE76Yg+5DEwFXH7oAHM3ZeOAgAzHBguR0b2wLRDaHe+vUGNb
EaSgVZGnVQQn4WsUXQgBa1btyURAVAW8oSse+46xh9BrBoRuIP/y+9//+fP5u9tnA3zh2Bid
2pZ0QjILr5fTRihUA7b12L8NA8pop5lZOyqibeVkNeiIvQ74JNLe6vrooq+MREQkry9Z3iJN
5quGv5iwl8nCm+Wlcuokaabtb+rf6VLqKonTaFoGt+jB9IvTLv4fiKwui/ABHZ3IvqwX19Mi
vxGyHB8n1+8x5Dy48C1L6N7poQl7/xvehjFEgvn0pyaR6Ypytb5Zzqe7rgxlcAVDD69T+GeC
eXSa7qLj6Za3LnuJJMlgX3xBBr7phS5QqdxcRRe+al1lYLdOihwTsQ5kc2He1HJ9La9se7xd
IlXSeZVH9hth+GeFsUWvRBLibcaVsQFCKcOQwWdsbGyktFHb1kk7lX7H3VJly/h0NrW9bbSG
6/4JLK2//jV7f/j69K+ZDD+Affczpx0VG+S5rzTTjKlpaYXibjFQFUeDFS4Pba9ZX7QnvKNj
syH11Af9rsnawiBHorcZ70XyPZoWu519ITFSFQYt0il7Z1pQd9ad5WqDNdETiLqCn95XUSy5
oQGbL/yb4yhExCH6jxE9TbbwD8PAi77PDtC5ZlbldPvS4kSXzhuGFdFraWY5EYmOqOk+wVE1
stltF1rMP2RRaHlJaJs3wYTMNgommO1wW5zOMPcbmpj+mval4k054kIZG58C6QSg5/184cWR
0Gwhp5snEnkz2QAU2FwQ2PhsB61njpNvkB0P2cSXCssaNmW8W0LXj8cWMF4mJCqZKd5hric4
tC/wONRhK0yKF1YvsOumZSZAhXuZ6a4AY+OSQDApoDJR1eXdRH8eYrWXk+O1TjxuVj1zDgq0
mse8bfet5dE7eUC3xPyzuv25p+R2bWsW8818ovW7sOaP3zp1ONEziQc4WDMRBnJiFAJfzD0W
nl5JSx6dBp/NMkfZJh+TEpNSrEtge4bCKDJZV2M1XHssa829z1YLuQaNxRuRbSdMTJQ7+vJ4
yjHxonepOE99YuRf0M5pOVVAKBeb1feJ6Y6vubnhvafaIlLlYqIPTuHNfMMdEerq3Rhb/Xmz
C4q2zNZXHtQgPa9it9tMbhs8OzJA9lGqkgIe9FySoFvsNW0KFeqRjZB7joWAvEMaMtSQ7ucl
v1n063zMtoN08Y4eM/vZ9kJYcg7QJHpBoN/KzkqSBrLV/57fP8Erffmg4nj25eH9+b9PQ26L
ZT9RuXvJIqd2PPNk134SekfOYY/N965uM4JEuzXYMipJA+5gkHhx3JuB8C6P7ks+/v32/vp5
Rneocy8IGyxYAz03rFPtd6r2nBfrxjW+pm0zvZvQjUOfFNtCEjObRN/Nt52lOsOTZ4IjM+MT
eImXT/DQp+wAPI8+wxTTo/6JeeQ3r8Q8pBOfHjaJU8w6Umrs3S7/eV+XNAY9LdDMzAP1Ssyq
9qz2mu13+rT8cn19w39oEphwCWm+39fT8z2OnoHPuyoGPr/T1/x7uofPLwA7ZH7uEHfCPdTz
p7oH+U3A25WDAO/OIP6Ex2fgTzRgynlFAmBQwr7NF0+BMzKq5bRAkv8mPOutFpjwN5FAkYZe
daIFwGj1qUAS0F6oqS+BatTnyyIBTLD2bTO0QMjrNGJOOABbPm+3aiYCmlcIsjNRPSi3a49d
Vk7pN2IyV204AhN+23JKzxHzlOTbIh8HAJZJ8eH1y8sPV9eNFJz23HvPdfRInR4jepRNdBAO
oomvO/LGWzkzfz68vPz+8PjX7JfZy9N/Hh5/sNiWnY3DVoPMqbMDenq8x+x2mMxdnJkZIQ37
0ySPRGWR0Ga9GlHmY8pYaLmyjnSBygZwmALkbOQ3yFtfaEsf25N1t8OP3zM0QnRAbnBs2vkd
3kwzKjsm+9oR1sGreH+J2EUVAcFa/jxHTt/fjKklrtQ2wTA/vPrCqqTES2hh24YpQ9pQNtt7
yPHK4NIHnZLpZED+hVQuSrUvaqdIumYaDKVjgpff8lABWDClm9mPtjeAZXysCwhEFa8C8JMk
aOzzdeFgsjrlY1TZn6IfWDwVtpQehglVRJ8qFfduH1NSma/dcSp4OEzgYbB2fW9VoEnnOLLu
/mpjSCxJvISKIl2V057+xl2+Un3rbl+SjnQaBVzVEgqiIcm+GLIRJp1FmUVmSQcLQ6xLUZRb
GtlUnRUKod24o4CrzsrdlsxD8UE5CN/6IDiKotl8sVnOfoqfvz2d4M/P45OROKkiTG62Cmxp
58K3DesloEUB09CenztN7emFYtUuTnVcPduEOTNxSUi8byQrDira1oba0hmrFH41CCcO7meb
pD0oSFg/E8+F8xSFxjQuujvAzuCjndBIcDMeMMBzHdmBSx2tBWfkEE9Zyao45GFVbBMbPciU
0PegfPbVhXcdHSMcdQcfuusgjBmaW5EK6+oj6H+EdLMWKSDVggV/a1JhfCJch00knJ0F1iek
Mmc4WsBFrgonw9cGBiLYHqDQTQAV/MdMS6wPufXjfKQhUBVKWYgURx3f2f3S0Z25iZiZp5lz
r0SFUHWjuYZZ0kasFGOsUB517VmuiYmnUoQYxPQnCeyVBdJANN3oUXvC57f3b8+//43RTErj
hItvj5+e358e8QZgBiNjtTDCXFYLao2eg1boKXCyEHppnEFrSmAKVP+wWWgltkypPUSiLyK5
E8jqG2f76goc1+vo+uratK/oojrMhkCkRHP0mgzjfadbQBU4RzyOzJ0U61t7oiJZZUr2oIyT
XDtsjpXAj2CEFCK8kwVRaPOxCH2We15IOzL9WFQ+N3d9X+4L9m4nozwRirKO7Ks2NIkS6FDh
XygALEFLNUf1fDH39W/3UCokLvfSis9WaSIdpBDu0Tpy74qJfOckbchizd5zZhaaiY+FvSYN
LCtMHn6u5/M5fjJ+W4L6xbO9R+D7Zre91BZYpvI6EXxrKsnTcQQV1hmxqFNPM+qU97wjg/cX
IsfXw/zgM9t2AGOXO+4hrS7CKLdTz2FB4aIRjRL1ymtPhO2SP+LAs21eafsGTZ3sitwTMwOF
eeJbcjZD1260dK7S2ea+bmmfkeKYHDL2i7eHHXZwhz7/qPnP27P5d+vZfD8O7COXumS2DKxg
q13u9GQeAS2W5Padgc05ksKzFclZ89ooMLRVmsZlTxOf7dQ95UYGhWnA7xkUGHRoX02Xh/fr
RdZ1GdsouNj26CPlKHIfPWqEfc4ZeE5hj83uQtv29hV5JX9DnvnAQZyihG1Wd7P08MX50iLC
rfth/TTgNPTv8/5Um4D9OwMuDX4A27HpgHj0gMmDtmWagWQTJxZ/MsUury50YbIOVo31eX/L
LjzS+o8tdXfMQt9Z+q0nvk/d3nPbNrMiqEXkhdW6LG2WZ1/YRtqs/Hk0wFWnSXbMQUyY7QFr
zR4jt2q9XvKqGVkrXolpFtTIu9jBFIRSRyHvfHuKdp4ZikoG6988iXnAbIIlcHk29PbNkk2l
NWu9r6wod/w9v/J85DgSaX6hwFyAbWNfStaS+FVZrRfr4MJEJ5zTvMgidq7nvApYLzZXtsYN
RliRTGHHJEwstR8XlYzCiE97Gx4sbp1rvvZnx7Ay7NE9e+ErbUH1XTdRvkvsi973YBHC6GAL
vI8QuChOLljWOjzELPQuFQtfdNld6rVH7lLPAIHKmig/e59jb/gwW3gQKYIaW20kAFjnfoSe
W2UXV68qQqPbWkWFB55hPV9sPPccIKsueK1YrefXm0uNyCMraNPkhdZHqa6vlhcmRIUA0Na6
qynTTymRgZVgx8bQSnNxcKsoumObrpLUvvVSyU1wteCSG62n7NjRRG18oVmJmm8udAbe8l3F
8MeaL8oXohRLRAeTl7ahuDm2NHGZSG8AGchu5p5jXGIuL6k4VUhEIzLRCU1uTauD9X51Rg7M
i5/ukNtqpCzvs8iTgI/Dw5PkLRFiO/co8eQw3Yg62h9qSz9qyoWn7CfwxlRY80XK6546ZTHv
jfKOtmKHn+dqn3jQ7JCLAJiSd/UbxZ6Sj871E5pyPq18A6YXWFyycdV9XpTKvj09PMlzk+58
KjEOQ/4zgW3hOdokgPet5zJp7Z4jh7jtDmovrbcoSb0V5tEaUREqZbBuy/09gj0OmJtRiMfX
eHkw8rp4pixJZvDTC8KLvgsUN7PBW0cF0j1eg/XVonHZ3U5IZhhq3bZh2CDJbH3TTDyk1+3u
pYbnWpeA50GZwN5buG/Qbju9LxDC9pspc+CXaE4FnjqJu1y7lRL5+sZbaJw0UegpMpFlelBt
iR2N8mebk7i36SnGctfzq/lcup2cNrW3+naHcpEPZqunkdrUd+sc3LX+pwo0XO23yOliK5G6
vXjXiTJFtSaI24LWKPC+GS7qXAOttcXPrGH72nAOBnRBwqBNpGpb1Os8Cndzm9kgBHNz3sGM
DCr829/FsBnabFaZdVBeOl6OgVFyjVOpvQXC3wSrhnFgnqN2kqHYek+B+hgK/2dEbCN8APnC
+5PBvkBkSVHzChaZt+Lkc7giu4x2Qh04x3GL072er4wjhYEYmD2HZNzF/T9lV9LcOI6s/4qP
M4eO5iIuOsyBmyTapMgiKIvyReHuckxVTLlc4XbPVP/7lwmAJEAkqH6HqrDyS2JfEkAuMfk6
gCj8027pxyqhDxw3GvQcZmB7daM4MdEsz/jN/7IQErsWBRV0S+U4ZjX1sbiqGTlupFGnqnen
qZfqbei4ZlVZt40cx+QHeuw4y07lCMyaKLC26ciyxasUI9l9FXpOQiV7xLWNdOw2cuBSmZpJ
1hmLYt8xq9Zh8Dtu1WXrEHZKWUFfSY5sT8mpswRpnlIaYs93HesTwsj3kFR1SV0QjwyfYAU8
n1V//CMCe0LgDu6yHlgHEQzLkmrZHrQ3Ve7yoyy6LtHfVZH+WIXUQMgOW0+lnxdHFvw9Pz7V
sE4TZdGY1AKhGothcgDEwHbZAFj4oLmrEBSLywMJGlmcSxiIFnU5vbC1JfqgyjUKKzcZ+VX6
jfYxLl/L9uzZRGHEPFLuXCbZMdVLKM4K1Qmn+D27kNZCc2vQ9fhoc4coOVvLE9IIW3RYYOGs
LT6eUbWsDig9frWW813sKBaVadH16rXBSNGDdkxUpvusmOg2zbqJAQquDOr6XO5K/Z1AkrhX
MWr/l7Dm2F2rGwZ4XFzDqHiX4FPHzfEnJanbfGTkKZVDtVpW6fqpU0WeLrnFtk/l4meQ4kg+
pOkL+1lovwg/Qd95mPDzV3Tn/w8zPvY/7z7e7tC1yceXkcs4EZ31de2QV7T8AnSL8V/SprbA
ThiDKmGKHAySh6Y9gr+Fal+1OFOPM30OUTdKXHQAu13yUFTkM8nMAye5sNt5vrKuU6gZQFHh
qoFlc7+hk8gyL/BsqWuTT0XyXeRtPEu9siS2rdhqqbIOBAz6TqIe8C2fPqSd7suena6WBUjo
tLGSkr1KluvvTPD7Wm7IcMAIZegZRwkY1Jamt/aJkf/nmYrZSL778vz++X/P76TXXv5x8mi7
jQKwgKMwdeXD8867x+u+BClc1xeUJJ4A8ekIc409dSUegTRhqrt9Sa1dJyCprkk1dvLDBcpL
HqmwX161n9ectUtS5TbcgSxvvFckrbar+Oiwy1acMAkGPpltBUMGsdgvPoQu23Vl/7SSNmuL
It9Z4pYIlhL+PhYWwxfBcg7DLf1aJ3AY8vcW2fioDyvp/urHnx9Wfx/lsT0pGwb/KSJNveq0
3Q62ulqP9SMQ1C7UXIAKMuOxgh40j+ICqZO+K4cHEYxh8tb/7fn7Zz1M2DzpxGeo0AoZUTOD
M9w3FxGhTqMWjyRRDFalhWx+oMUHD8UlbZJOMXYYKbA4ap4gFXq7tDEjWeKYTBSR7VzuGekf
UqoYn+CUFmnnQgXyXMtb68STywibXRjTFlETZ/XwYPHbObEsfUhTOB83BVWTPkvCjWqCriLx
xo2JVhFjivikqmPf8y2ATwEgg0R+QDV9rToBnalt53ouARyLc6/quk0AxlPFJ35Gjhv5nLXa
fk2V70p2uHIjAqpQrG/OyVm3OpjB0/FmF/a1d+2bU3ag7RBmvnO1cdRD/oQMloGKt4/XQpsz
ygSnxYhxfrO+tNgWCBYe2546c0sYK8SyrihUveeZiBYqLRwctLgxKp7kLIp1n5I6HMVRRD/j
LNmoh1WNCQ+413pQLgNI+Nr7kaWwJ5hk5ZCVHY2nJxDbXJ9OP7vEWV/vXdehP84ufc9a0wLE
ZCk9i/afycos7zgm68bQkSFY82TrBB5d/vxyTFr96VGFD0ndsgOtk6vyFUVf2upf7JMKQ5vZ
HYNr3EPm0w9VKpcUh21Z7psmtxgjarUr86KgL69VNjjxeLZoiSofC9klCqnHca1sp+NTQXdG
8dDvPNeL6KFYVOrNm440dILnBF+Tzuj6Yo1Bi/2kwrAHuG5s+xj2gUDEhSWbo66Z61J3IhpT
Ue3wfqJsN5ZM+A/b+AQhcqDNqNQkHiLXs5US9iAeCe3WAM9B9uuDwQltReF/d+hL/+ZA4X+f
SX0ejQ2dqfh+MFx7XVlBKz9f2W5mec57/sy5WIUoThAI3IHuDH6n29Rtw0SQCHJQuH4UW1ZT
/F4sB/b02+R4X/Z23K/tWNmvgEV/6lLLREF8ZWIinNcZ9oNtI+DZd+NgtTHkk7KSrRBogZxU
1xsJ7Zu+ae3wPca8ssxp3hS2BYODXmkHny6oq1eupd3DXpxtAu2qcMnEp+1KGgm7rLQA/7sE
ad63zWroKL7h3FoagM9znGF1/xY8txYywRXQ416AFvmkq696rDdtTymrIqFlVJ2N/Y2pzXrX
8y2CAOvrXW8R99ip2yVZwY286AqyIQ6DjaXyLQsDJ7JM+aeiDz3P2pFPXD/zZv275lALQc4j
veALwbpkyrgVtDhGz1DDtTmCYL4EQUB1N4MpoQu6VaLTmGyynGBK68QlPfDL87k/OFCtXjs/
yeuGjLUPmo6grKRYf6/tuRMfruRe13COXMk+gbVYDYMtqPvWS5al4SfZFISpgigSB/Mia3KL
sZxgO5cM15Zr2h/pS05ZqL4CgeEmU8nDbPYFpbY+3WUwqKDkW9byYejvt2ZdOFme2a+WGMvj
fdC56OA8Xpjj51IYryEantWuszU/62AHo/tVr/vQejCi2+JhWSd5SJ3TMPMYWR7LlDShElwn
cV+2SL5NqhrVXeypt9kuDiJqKVVGStf0SXdB9fdGCyIrWMRhRs7XVxMLfXouC7HmSpUqyYfK
31D6AgIva6hUdlrmltWJ7+gqCBpwY31AWaBNMMwb/JUm1KOMrFX36IXQoYekRZ0eo0EQDoMJ
XrYJhyMT7upyY5i5cyK9kXBIbAA6O6upxxwO7RzlZmmkiI15QfdyGQjCKM2ODJ8tIc9kt7ir
kiA19gQUbJZFDYLxavQwXriXvzZ3o49gybuoDRFSa8HBf17L2NlopRdk+B+jjlB6ThzP+tjL
ItUfjKC3Sfegx1eS9KxsGbUGCrgqU4CXZeuSs5mSNG1dSw2wWrh90b/ssiuRi7j9ZJ6q0sFb
Sn3PSepi2R7iSvzL8/vz7x8v72ZEob5Xdd5Ul9bCSwC+Zh1ZxfX8mMo5MihaCGeTBnwz+ZqW
3C+EosFyLIdtfG37i/qsz90GWYkymJUXhGoLwSngKDxc5+LGfR7LaA3QL9tlfj27ZFWSW14K
62ZIhApHZQtwiBxc285mJXY5ZtbX/BGsLU5sJXzdW55umqfGYktUWnyWHo2n8AnYM01djT9j
gqxsKfp0ndzT7l+Kx7rQbFeA8rCImibDl75/ff5mvuDLXi2SrrpkqkgngdgLHJIIObVdwWNK
j0GEaT4R0k6buSO0w06nZA6VyRjtWiE03/ZqrllJA9J8lEBqflWQ6svYCB6764kHwN5QaAdz
payLiYWsbTH0xTG36ZOqlbJ4llQz7L04Jh3SKkxVyyx9UpfGujxBMNWM0XN8+/4LokDhw4h7
CCECnsiE6mTwaetXjUE7xkgEW7Aqe0qGlRxSPjCJykhZpnrPKC0ECbIsOw7UGBXAmOxaAm5Y
MrzKIss2wWQW46e0hGOwLdStJA6DLy263GaoIrnkdnnfJ/uTRXFZY0QmYzYoGHYjrvjmpFCZ
0uSUd3jmcN3AcxyjVOVuCAfLG6hkQdPGZYmNynUW6ysBd63FvbOAd6yC6bLeKrg+PLl+YDQJ
OpxDwxRVA73j+oNEYm2rvcgfHrPRm8zSi884nGfpua1LkOCOueYpiFNz/MePswuAh+vgZdkl
mQEmxzITL5XakWHG0NucxcWUyJcb6cwZUCcG5NPd/ggSKy0W64iekz475M1K1vww2+woRwwg
DElnUn8ZJJwrKNKJfdNAR01SA0hUd4ozeV9obT4DaPqlhiJUgKUUM8oGj1pk0c7fhlqkvqRt
0TmMJUBkc7yQ+kX1OVHdVrHsJ0xCYR81Edssjvzw54J6ZNlImcW85LzmYujQkk+8MGb32aFA
d3HY+Nq7QQb/Wmp1hn7I0F/dXCAYbDLs7/T5UFbVJT2Z4WhwOTVVatRHJfS6iRSQXrpiX2rX
WUDlL+IYi1kn41ND0i9oB2DVNFmAWJ+G8ahW//nt4+uPby8/4WiA5eLBzYndU35m09EY4arP
Nr7+6DNCbZZsgw11ONU5fhplvUIbUCnW1ZC1FWVEjRyHomoL9G7TL5oJDuAnpmeSVPsmLRdN
h0Qo0thS2DrTwRaDDy7CGLbZHaQM9C8YfHB2D0tpnYnkS9fmDHrCQ1q9ccItzpY5XudRQDt7
ljA6SrLicOBeAW0OgAVY07shguj1lnZgg+iRX1/TuyHvOoyXtbW3GeCh5UJDwtuQfphG2OYU
WGKwXRlTmbvHtXQwy/ST2Tz3//rj4+X17jcYK/LTu3+8wqD59tfdy+tvL58/v3y++1Vy/QLS
LYbx+6e2UlwzGMILQ1Ikwym23B+5Wr8u7i3AKYCAjYE7ylvOOTUBi7YkshV7z7EPgKIuHslL
Zs9c0UeacMUL+989Dw9v+boRylFalWD+WirLylp780OaMO2blNB/fry8f4cTBUC/iqn9/Pn5
x4d9Sudlg6rvJ1Jc5sWRweFfCeK1wlswTRQBsGvSpt+dnp6ujVUmAbY+Qe2oR1KfGeHyeNGN
EcSYbjG4Bd6WyCo3H1/EPiDrqwzRxfgT2ljo/VE8ecybvdjEaR9hvOH7U6o3wDjYliQZeHfZ
JMKFsT2m9MSCC/gNlpS0SlweZNrSajKCWI3Px924T+ALVv38Bw6TOQSIqSDKg6Txo4gisyNt
EAHUpM8TDTPsyTnx1KOAW1108ui4TUtgnsFG/c4WAy0J1rU+NZFskQUQquoIzvhVq2ffiJGo
DRcgt0PikfaHCI5Wv3rt4NAZw1rveMu0etiyq3K3w3OZJcWB+1TRCiYn/qJ+T5fjp7q97j8t
HiWnbm7f3z7efn/7Jvtbj4TX8n6kNY95E01uigvV8TOvRFWE3uDoRGNJnohccrXkIhjYBUZo
PTpz1ROxXB8eSJOhttUMg+GndWYc+1ayC/GoZXe/f/sqgl8vhV9MB7oNHYs/CDH8Vc9EglUO
kgdZXIVJrqd06UcmudVMRfs3esZ//nh7N+W6voWCv/3+H6LYUEU3iOPr8jDQxj4PAKBayuvM
OD6t2MOjHo+9PGZ9RxmgYC007xF8t9TjEkmea9l9WvrTEmugZRrzpMbIhiptjmusUrn+szOf
K15e397/unt9/vEDpBmeBbFpiuLWeUvLC+Il/Jy0qR3GO1Nb6WVJyXhJnKG0iLEcrC7HoW3g
0G1nqdM4ZBG1dAm4OD6hfuKipRr0Eq32Ayc/DnEQGMtMCwPuF9mK+Jq22pK7yKVvXkVl+zgy
cqUjiY6Q77qD8QkRHmPBwNww28Sk7MvL//Lzx/P3z9p2KEaCNGx4JUaWQ403b1jw8iOkb1Lx
HX1YpNC3ZebFXEFNDNld/jeK5y0LkubbIHLr8+Mi06UasSgJf/M3CsLCYOsuE5Zkz+gAqXSw
0gH88d4cS7DBGxU05qL1VChq28cWD2miV6pr2azMqXZtwkH5riV6yHHpY+vIVAgujz5HCqWI
PPM9oglw177RBPz+f0t6SFaGo7scjpnvx/GyC9uSNaxbDIyhS9wNf+kXVkwsXR92mpgugbM7
fu7+8r+v8kKCkELOrpROualLQ/fczJQzb2MJI60zxfQZXWVyzxb7+YlnufGo9WHfnv+rvlLD
V1LWQbtytSFGEQcvTU0yFtYJ5m7Rgdj2RYym1TmKZ5ZPVQMI/VPNzEODSF07lSPmCpH0x6QX
OZ3DViTfh/OaphGtw7GtnyaeKCRdEqgcsUPnHsUu3YRx4WxsZYoLl7aH4Rfr1+TR4leAo13B
yJtegbJT21aaQx+VbpVmW/ROhYzKZJbSRZJn1zTBQ5h2spEaVNaYEBIXiWq+4JjUhiM+kvkY
La7RXQtdOyyNCEupEzBeG6MHMkDVj8bIQvRHY5LpJw9dh5mlkIDuf38JHvJPdjDvryfoCmgj
tFqdB9ZUT7HpzhE8pXKf7Ln5vQLoKG6LahJ1kQy7U1Fd98lpX5hlQmuPyNk4Zikkou3cGuaR
28vIMioV1sJGdIF2Q6B08NhRJWsxS0V7RwKQX7xV9cpGYDTBM5Kq2jhShVaVrgpnI315azfx
95kfBtSyNXJAr27cYDCz4sBWM5VRIS+IbqQa+YHl4yAmPWhOA75O/U1ktjofA1glb7txzR4f
dWFMpOsDxyeav+u3m0B5rxX+rfWfsPXn+kMdEuX910H3IyZ0IURoWeJ8ILQF2TVJy/60P3WU
i0qDR9lQJiyPfHdD0jdWekzRa9dR7V91QOs9HaJlQ52HspLUOHw65623cSigjwbXAvg2YGMH
XLp2AIW0tqDCEdlSjQICYFkUemR2D3Ff2JTORhbXucmzS2o3OFj3q6kgsLkWrM6oIqKnTbJB
uGOEtUT7oSX6MWehRzQSSKQhNeBy9JbItBvBERG60wtL/REtgwc4LtE3E1PrwIHcCSg1AJUj
9nZ7M/ddFPhRwExgNFmwlGsH5/Z6rdl2PUjfpz4R0dwW4L4K3FhXA1Qgz7EoK0kOkBMT8tMo
tKm4CIZDeQhdMvTQ1NxpnRRkuQBpC1rfTDLAIWpcXoluDGx+jCUHvjQs58EyEbxaMdryPtt4
JhWmSud6HjnkecxLMjLExMF3IGKqc2BLjHt8kncDcg1AyLOEstV4vPXe4zybv5EOeYzQOYgZ
ys1q6UUTodAJg5VkOYu7pZMNQ2JvQmBL9Ce/GYg8z1KQEJaX9XKEoU+XIwypkcKBgOhSDvAS
UuWAMpIizrx+tL5Dbwp9FpJu2aZPi+POc9M6W4or806UqYL/1LV16JMDsI5WR0QdESIIUEnx
AOiUWKjAMf0Z6aVSgS1Fj9dGHcDECKpqcoaC3EFnsaVuDBQ48HxC5uLAhphIAiAWD6FkRRQN
gY1HjrRjn4nLmJLRb/ITY9bDNCMbEaEoWmtH4ICDLtk8CG0d+hJwLv8uDrb0fWZbpxZPoOPX
7NDfWB2BY3XSA+7/NJsVyBk5AQkFl6VQUhdu5BNjqwC5YOMQ8wUAz7UA4dlziIGCDl83Ub2C
0CNWoKm/XZuIIJ8EIVdIrsk1hOMeUUMO+CGZcd+ziDxrzkWrYTElVyzXi/OYPqQw13HJj1gU
e/QXURxRhwto65gSP8tj4unWiypiuWtXWHxvdQD2WbQhV/pDnZGmrBND3boOsSlxOjGYOJ1c
YAHZOKtlBAaqaTDoQNaeUPai0gU4jEPK6nLi6F2Plhsee/Txu9q259iPIp/U+VA4Yjc3C47A
1s2pjDnkrYnnnINoYE4nNz6BwFHMeCamWKsoDnpS60XjCY/EmQQgmJmHnQ0pOGTmSr9H2ZTn
pjmDWrDGydJk6x8c1yVd4OD2lGj6DpKEwTP7Ev1CUS0xMhV10e2LI1qdSYVuEZT7WrN/OWaa
GCEbPUlh/IZ2LV0Z7/26bx7RL32LttwFVUqVcZeUHWwciUXtifoEDQTRo57NIwDxibxgr6om
SxbbuvGdvVQE42o9kQE1m/h/N/P8m9X6/1YHowFyK0daZ4yHceDpZVViuRURTKzJrnnPxoTp
cQ+s/sYZ0IPt+6tm/aamhixUOstiZYdVLvWpguCTXKNdg/JeIymG4fMEHJtzcmlOtI7ExCUM
Q65p02AwL5wjtPrA9AHXOzEa7vz88fuXz2//Nr0uzotCs+tJAw2JyzudqaqvKhD6KjCrySDk
rZt9zCejVbZznvToXIgGxYvQagIy+sRKDZ/KssNnNLM3pUqgisx1PK/nO75JrGSMp1J/GIiM
uScGqmWT7NMJw9UvWmRE80d0Hg1jG3DN2qQqa9Sdt7YkMkQgulkZijS7Zn68seTM7+3iYpkv
azGGEchUFkNfSHRX9m12Y6wUp64Zq0VkXqYRZIJZz1qyaZ2wTp+AO1jYbNUrQ99xCpbaGTDI
th2FGtoK14N46+1k8ZQv4sia3KFdbw8GEriosQX+ScDjIQ4PqK6/LM/x0dpLobNSc+hCEGRs
mQEaeZtF34CEGhgDBSPRSP0pW1rA4kdpJNpN/RjFXvqbUfxafgH0OIp29oUlhhOZiU/zNjs8
6XXCkVy0cESjF8RjucXAUbbsjmUWOW5syw59THqurMOomPTLb89/vHyeV/js+f2ztrCjZ4bs
xtraL1SYR/0aW+LyQ+CYk/7X62Kvad9fPr6+vrz9+XG3f4Pt5vub7mVe7lgtLHJlXTQnLkeR
e6XCoopcx6Yh9QNufNYmml8xS0F46nPH2rgWiTF0LNcwVqaacbvq5x1ZGFfP/z/GrqTJbWRH
3+dX6DRhx0yHJUqUqJnoA0VSEru4yExq80WhrpLdildVqqhlXvvfD4DkkplE0n3odgkAc1+Q
mcAH/asgxrgQ/Nc1V5sqiBVnM65HHnn04ZfkR62kqyehifWnpbsSLoLUZ5NFRmc0kb/c94/n
e4xDYI3Gli7DjspENOHaXL6Q7YvxjIVv2aSkvBnmh/SJXzrebGi4+yAHiu/Oh+ptLFG71oqU
DNlJcDTdWIMq0UXiVchWGB9VxobypcpUnouWqztoD1TL2IC+Ddd1zA6o1D/Bu6O2AtIbs/sp
dzNXM6eO3gFSozSbCagGhJnOTjLuCRhZ+O53OBz0TCpi5bLCMLTuW5fobiTiYKzTQGiThGaN
5dni69Yv7hpXLLbgySawmlIjz+ot2ByXsMv+gQgMinL/TwXxrGMfZlIeYSjonuGfyFlDBIDY
H3727RSkuS1UOMrcRSnvropMiaxnzG5JdM0xROSpBWKXOt8/jCauBVO6EpjNpnPee7QR8Cbc
+0PF9ubDmTliiOzYFzjis5fDLdfrJFpO+QtlYtbnLvWr6Bs5E3O7Kn7DGdQiHY8pZlNvgqUL
s9jeUIylscqtrX/0bwK3dD1b2wpc/DrLuYgns6mJ4kGM1B2OzGIT0ebZQQJ3Rw+GiGOmpUI+
+ouDOzS3Fn+B8Ck8MS83eovCMT5QndeRpsH0+mFnnU0247l13FU2aGaCSbrVaY2dfXuA3Yjp
aOhaYKkJc9MSjaYG5LQOASng8YZJrYDFsLoW8CazHoGYqj7+RSG8qW0gdn0MFKrDU3VMAo3T
2W6AA6vXWIW+rm4MuiO25vjbULccBAZG+7b7duLX+2TkzMY2IHcaJOnY7U66X+DQ0MJguuDo
2lkRf8szv1fBqWX6FJx96k340MKSOdZ9blqqBYdHETAcV2uOawdXrETmc/4dlW6SKsB+XiBa
4a2p5Wq1CKz9hAHQyOhaoma0yvXT5eF6HtzfXpm4M/KrwE8Rwaf9WOP6mZ/AAafc2QTCeBWX
CExklSh89C9pmcotH5U6LGqm5S6QSol6bldKl8nJIVPDzDE5p3CnOPjt4jCi+NMmaTdJHAyA
iYA/vjo7W7ZJ88NdN/6SZMkgx2mcUSy6bGVBx5PC6Lcj7qIk4mFWqWRplDrwn1Fy5CwTX6wp
7HUAfykmaVDvziEKaWnq87fvyORjZ9Jn/gFq7G8wdOLvo6nKwqgOqDRSfRXvLOJFCDUCezK+
DJwSOCfC/1ZmmbZJ1D3FVo6QOJy5yFPUzxTB85djiVq4RwoasnFyrMPJ8T3RdkQ3zK/szban
CDkp4ZGTpCx03C7aamlAFuTBYC8FtpdZ2HoFEHLGXx4GaRp8EahNV5gLyulaTs+mL3/q9DLy
3ZlqVF7NZtCfhgpVhk4lmg5GYNDar3X49Pr7EaeqNNVrvjNy6KaVFh67KRCWvljoQK9UJhjQ
Mf3FfFWVGo7Qd52GQKKjN8RdFKlYAxSA2Ueg5yzXBVM402rKptLmUxYsVubp+7PZcLrmvlxO
PYtxqJSQ+31nXpWXv89vg/j57f3144m8ylHQ+3uwTKvZNvgkygHd/H2ufbnb4bW8vl726Gj2
CYMNDkagc34e+J2hhmN1GRdRWO70hakiNpHQmkIHRwrN3cRXtc2dxXbpGLpRS2dWa6LDvMw3
guOEqdwz4hWbXkpPoK1zNq5J5+f76+Pj+fVni0Lz/vEM//43FPb57YZ/XJ17+PVy/e/B99fb
8/vl+eHts7kd46ZT7AhoScAmEHR35LL0KTaBfP38eLjeBg+X+9sD5fXyeru/vGF2A4zl9nT9
W/YACRehaERr2u76cLlZqJjCWctA51+edWpwfrq8nqv6Kti4xFw+nt/+MokynesTFPv/Ljjw
BgjP07Cpdl+k0P0NpKBqeFOoCYECMaCm1snp9e3+Aj3yfLkhjNTl8cWUELJfBh94nQ2pvt3u
T/eyCrIPm6Soh1ELVcZ0O0YPoeN5Q4ntUXAAFbLjym3W1UyIiPA5G/V2V+WVoe8582EPU/XF
Npgj4I6s3LnnzSxMWoJsXxLT8mVaOsODpUCHwBk6no3nDoeWWh6CiZWXBpMJHJYaB2DSet/e
YeieXx8Gn97O7zAIru+Xz+2ca7pVF72nKLn/NYD+hXH2jvCnzEewXP0m+tNFkRKm/y/TCapM
GbYPx/nBpwyW178GPgzJ6/35+csdqPHnZ1ism4S/BFRoWDuZNGIR/oOCkJReo//8h5+G1x/X
9/Oj2mIwjx5/yun49mWTJM1ci4Iaxa1eAwbfYZGg5mzWj9vTE8zDuA5AOfgUZe7QcUafeQQ4
uXXdbo9vGMEYkr083l4Gz5d/d4u6ej2//HW9f+PQ+PwVd7e1W8FaW6iHBUkg1Xe12ZLa22pq
wBT7uAzWUZFzOkSoQmaFqKttYJE/NJCCqgqMXHJLS3mnb1UAlOlkiToin+fpLhUVeJ+ePdKX
i5alJb6kg0+/CQ/KJbkfnmAyhn0bNAquEC8HNlVbSWw88kpt4C6q/WYA48ZYz5VPJE7jbEiu
4wZdxMloOtGzIKS8w4bWw7mnIRUjG9QmW6hYZPtpCGOBM0oafJJ7c3Db1HvyZ8Sw+n798fF6
xgevZq6n4SC5/vmKysPr7eP9+qyHXsV8sny7i/yttRzxfMS9plAbrgzgcGrX/WrJX39Rd6W+
y+rPyNyGidlIvuBPUshLV/7KsTgFIT+Ii2IrTl9htFllvh54SyzkLfJgzZ+nqaISYdfoI0Vg
Q1FmftYL2tvL4/nnYANaw6MxrhZFHK4ifezQxy1HS6NdxRav14cfFyM5ebESwyk6O8w8HTIa
+etYxPC/RcpdUqEAYn9pi0pFwHB2oIgstLurmhcn8dxxuJHSfg1b9Phr2U23iDb+RnXZrxmi
nLnelMsOOLOxy7kz0OpBMQjMipdhz8As4FDSN9J6xoGdJ/wd7ybWdnFeIM4VLYYnNLK6a87Y
y1fQGAd/fnz/jrh0ZjiIpbJ/1EskLZgKeQGrH0b+jTRalpfx8qiRyOBvFwnmsg4TWeI5KkkK
7cxQMYJ8c4Ss/Q4jTqHqiyTWPxFHwaeFDDYtZPBpwck9ilfZKcpAacuMCpXrlt70CXLgH8lg
ew0kIJsyiRghoxbaCW+JN1DLqIDT5km1WqCNMNgu9Doh2ISEkVSpGHep2quEUeoyTqj+pYGk
3R0ofUHUsWdoTbRVfZPyJ3z88LiICmdoWW5BwAaejizYHaEt+ZWchooorUzQf3ScIYUFI1Yf
2uizrbX9SoFthN9tbGZtiI3C+slezTmDg7llcgO3iHdWXjybWNspibyhO+PXGhwEdvwfzNSu
M2A7l0fbKia5Npbg302R01nBNG5sHUq2ZRHbNcphPsfW4XJ3LPjHeeCNbWs4ZpnnYZ7z3iLI
Lr2pY61oCVttZB+ifsEHV6FJY0008IsUll8bm4DfrW2LT8N2pgi2S+4REZioRqnDG7b60+pQ
Tlz1pIvZd8AwqN+Kcusn2qxJI4xgl6dazDekL6BFWURQXOMKUOHFOopKLS0MW303muuBOxQ6
pxsq7JHxmbzfsDfTbMSZ6TTr7ykJQu4BCcn0zFFFJ+hNQxXUDNMaicquny2mUhZ6D/2FkDR8
+oUQwTj0lnmTevPJ6LRPIs39qRUQPhwf+SncCnUdhrpFqazh2EyA6Xmss7khM9PQexqWNKrj
WNCW0ombyXWDQRTYMIBK9Wu7i6cur8Lz5npwB1WdJfyzVyu2CKejIWcpo1StCA5BpgLNhGlc
a4Zw1nu7PcIWXx0Iqnv0zjMsXh0EnUBfoBqDrkkOGCLAt0sdPo3nw0T7Fv0+nWj3EpwcKi+x
KBG7VXqQnBbH2h6WU4S3aXrsFlIjw7/JNs3E796Q5xf5XvzuuM1yUfhptNgu0fK+kzLDhOKV
oI5iwJXUL479shjGsZSRHtrVIl+xAMv5NtOdC3U0TurLdRx2O26tx1aCny0OWFlE2ark0EBB
TIa4q35v1+ppABOpIWEr22nxcrnHmzUsA6Mu4hf+BD0g+MxOflBsD3oORDotl2bxbSsS8YQe
+IZoWzgHcM5P1BZRchercwNoeD1WHM1sg3UMv3i9h/h5IfyYO0YSl66D9QpW70ZmeaHlV3lW
xMJWyQhvxZZ6WvgKk6d6PaJvWgRQ2WvpIi46I2K1LPhLPGRCIhRI2FKau2Ok57H3Ey30NmVw
LOqhrlBjdE8yq29E29J4f/h8zFXklfs4W/tGDndRJuCcU5o5J4GB7EfEqNMwSZTlO25CEjNf
xTikzRrU9FP4h7UmjQz82HA3u42A2tNILLYpLIUbP3Q6rNV8MjQmDJL3oDklOGQs9SANOs23
otMXqX8kWw3bhzFabsOqrbdjmqMVgRpglqiwasd1yHItl6zkTLORA6oUxejVxGHPRYfGJC84
w1qSiEofoZz1Ym1g/oIyxhK1OxCVzhyvVTYMGWFwEj+TAeCFWU/aFPgjB7Jh9eDDD0pmKrZq
HAAiIloWxoo0yCX2N6zOKtoTMbbZJukukIUNDx4nLgYPh0M3r75RohgH84/8iCnbpma8y83G
gCVC8FhfxF3DrDWWs3JdbEXZRF6oOCq1sypiqLf9aSPGOnkfxxTQ2ijSIc5S21z/FhU5tZ3y
TU0zZpaW5rdjCPsYayRFjUcO7af1dmEWpuIEULk8rX7ZNr1kI+p9GKGFdT1AMzlBlq2om7ir
UlAEJE6toHBLqk6AqefrINbvvAzjG/NGEIkVJohGoxDBa1+c1oGehS4mo2pqFfSzDFSlIDpl
0b46R3WdivVXd2yy2wu+dbyZzVU7X1WaqM1Wx2JLRk1Srk77NUzsJBZGxXHtwLuCFWJDokNa
p2k67bLfqv5YNeUULPxlV5DIjbVfOzowVlVfmBL6dDo7DIfU/Fp2B+xh2SlaQxE9XKx4C/xG
QguD2lIZrH5kRlVmlhTzw9YZDdebziAhZNTR9NAt/hK6A77pfoEYWhNn1GXkdYWfOCpViOcI
c7C231iqu+2vrki8EVPAhgy1Niy3Cs+fTt35jOuwPZOZvlLs/Z7C1DU0qoBkMgVMjduoZvRV
bvzB4/mNiTNEMzhI9Satglca4z40pMq0sXXKYG3/nwE1TgmH81U0eLi84Ds72s+IQMSDPz/e
B4vkjkJlinDwdP5ZP3OeH99ugz8vg+fL5eHy8L9Q+IuW0vry+EI2AU9orXx9/n4z14xakqt9
/HT+cX3+oRgY6QaBYWC3CCRlC9UhvSfjrqW2+hH1SlgExnAnsuGW2TBWfriK+OvLRibcYhRT
Iw6t9Ox9PL9DAz0NVo8fl0Fy/qmYKNEISH1ovIeLYlNGvRznpzxTQxpRNvugYzaJtNM2sZjb
NxJYvX6Jbj1NiaaW9dDSKyeXztrEUB/G9L1cHsyc+Ss3WnbXMcYP4o449bo2mw67i91sOgJd
JzB7s5Knpuh0FiMnG6SuMJuUvd+xbykQM3P8p+VNiJnDP2XQtKHgtWyq+nZtST5KY4tNacV1
uJcfWnDCbbk9mBUW0U5EvNc5ra1xzhsfyJ19lZcVyLtKNtfu2nA0OM6C6dgsQXAk3BZbn4Xy
xGZ8tCzD+BQllidJqi5en4TQn4nPX2ZIM2cB/+wsb9VUGdvWUBY+6F+7GE7qsBIaYzXf+wU0
nUGmcFgaJVoLGIi0lSzjQ7lVbWblcMQz2XJvzq4jSHKXyJTmN2qgg2O2GWjf+K/jjg5cBDsS
EaDfwR9jd9jpp5o3mQ45c2hqLDijnaC9yS5RDf0lJ72fC3lT0wz5zV8/367350e5fvIbJYaa
aholyzdSoQqieGe2iowpYoM+LP31Lke5ntVBi37S7hFmU1QLiM253xTB5/tI9CVyWnJnSkUK
a3Wiu0qH4VZ78Snbpid5+SpArm3ly+v15a/LK7RzqxCbC8sSu93yVq3qlLD+WmVWhclm1DRD
6zn4aDNrugzsevNB9tg2MREMUcdwROoiDHqT9NPQdcdTe/GzqHScWWdSVWS0UremTTKevWlX
+R1vbkXT2Yw5qm6ydKfPqL3yT3ZQlceNGhyUfp7KYKOZpUmqHBLca6Dkb0HH1HKG33aX8yon
8rP0upB5OFDLny+X3wI1cvOX8KLGcRb/vr7f/8Wd+mXqFGs5HlO53bF9n8SdXVQO8Hg2s25w
IZ1c9TUBdTKKPK+fQvCpQ1qdKoz9QvuBxw1tZO7lEYXLH1jxaOINdcdt1gQtjVIE/FPux2qK
fi6WoevE+/X+XwyyR/3JNhP+MsJgM9tUtYNHTJTTQo8HmIqK8tTNwX4Cb6tT51nGyxQSYzus
EfqDzgbZaexZnIVrwQIWAKaZ8K5Ev8mkuwnpnMfQpAOfwVkUuCVnqM+s97ipZSu6T6dqIfob
o7jRh/6Gn+SSKcbTicspxMSmd+6hUZLKGfjJJGqI20SEBWhimDUSfV+w9xjEk/HmnM43Fd3m
gU8yZtwUWTL0fuc0h4ar+uxXRNdt4XS7PGfEEcdM1q5r0ZorvueyOK41V0aH0T8KkmiHrmox
9+bWNpXbbfaK3tuEKDMdHzq51u7QpV+y99AkZAboq4jByJmIoecao2MROohDbZaygh0RE5vB
sGyccuyyWN5yWDemDCq1CvNglK8MfAQj6NS4TAJ3PrLABTcTwf3bzs/L3io0QBudPamdznQX
8ufj9flfn0afaa8qVotBBfb4gbHtuKfhwaf2kv9zZ0FYoLrMv0fKciWHwEBV6QgUEaeAEhex
RDudigBm3qK7+2JNytfrjx/alqBe3ZorZH2jWwe15Xg5LJPrvLRw4XB21ylgzUzLnorXQuvI
L8pF5HP6kSbIPG9p/GCztZbED8p4F1ssATVJO4qQVu3qsl1/LKFeuL68owvR2+BddkU7uLLL
+/frI0bevievhcEn7LH38+uPy3t3ZDV9A2dUERs2emz9CXfA2gQbxFD7dc1gm7HBWvlBECEO
WZzYWjKG/2fxws84vT6CxesE52x8fhBBsVW0KmJ1XlyQqlaHpKSNexeBVZeyneoqZoAmx6lu
tiaLl4ZTHmqiZs+m/CJG/AijwPWxXaeHHXuON3N5K6paYD6zYMRIgbHNUrli29ZQyY7Go16B
gyUWo/zanfQmDpWb9vALz5n2fu/2Vw2hT3vYszF7A1aUMKLUCNVIwEgFU2/kdTm1ltkkjsR1
UOYwHNnMkY/RzfM1P/WQbxuryMt2adR4bAFhcK2dYFTAAYRIy8plEw5bS544oPXbC0ASfCR4
Kl+xq2+CmndWLErn8FELS1iwg9505IO9WLjfIvWFu+UcPA3WoKKHYjQezmz0KsxLJ7WKG8Ci
udWNo1SJmQVTphWZzrgTSC1ggj3VdAQanpPNcSfNCpesJ9EaZKxT40K4wXjmdLOLRQKz1uOy
kyynrxIHENAA3GoGhSZhQ8JqEgaEoMYbT3mrXk1o+sssvHG3NdLJqPT4JiaOBdy1Flp8HTt3
3aasYLk6uTXoVBynxpXqlETAyW4+5I6DtcQyHY/GQ679CpgObMwARcBVI6mqHzouV5woHQ+d
vqFX7DxvyPamcDUN9z/qUNW9qwB2xNzSdfMJlw1N277BSgIuP98nY9s8n/RVGgXmTMfSJB5N
u3kV89mQ7e7iMIEe6e2y6UhFONNm9sTjWkQuJX1NAjPEGTls3dNgM2Nj9RQSUvMEaloFydX0
KAJU/HJ9D8XY0S8V9NLwuI7tMINOnusPi/p7ZW/mQZozMxS6EdQLy6ByWdBaVcBltiRc/z0M
W5LGiW0PmXo8HpsmwkX7VARmjsfOV2RNfp0+bEG2Pq5qgHs/AqF1NIOKT1oDCfyioOqVVEt3
Jmpc34ZuRDpW6fyWIcq70az0vb7NceKVul+syrEgF6sibl9fpCKdOlwdF18n8m7FHMkbN1Df
mmo6DnB2Vbf6jbRqEAJVchWsYIc7k+b2/Buce/unzLKEv4bc0lNj9j61RvkSw4VPMEz9ykxN
LWJLtWCM4bNKx5EXEYGibKV56SKtcsSiS9ksSoTOxYcJNW8/KRFrLxUr29uNvAGLgW052GFw
EtvHX4McHccx53SVchpFK6GAI+wxwaCLDifpbE71Nxv2HWEttsiuV2osbvB4RViptkF9ccyC
U3moBNtG01+s23Y/FX4cKkkutkvFtrASp0Tx6VOtiNgTnSmovz1Uz/Wq/DqcTGaWt7M7ASOT
m/RxinUK4riyRWg7DB3I+Vchy9UNjqkexDcJadA2UQVxkEaZjh0nyXwPVcwFAlmpUeMqusTh
MqlpymULxNqB/dROt8oY9P719nb7/j5Y/3y5vP62G/z4uLy9c29p6+MmYrGTROlD7yvPYfHm
oP2gKVMox6os2JyWyqYLv2HD2PjBHT5bx6tMJtdkLflxHvw/ZU+y3DiO7K84+jQvYuq1uGg7
1AEiKYklbkVAslwXhttWuxRlW35eZqrm618mQFIAmFD3HGpRZhL7kpnIRWQNvitZztsGFUf7
c+LrAv9Qk6XQJfcBPfyMYySxuKSF8bbkzF1sshc1046cqk557rfGvH05sOWTmH4frUU28+Y+
FRsDUKhPeDJ/w8F+UwmY8CivXDixSZ2466QybxpZP2U8VWNmFGNB1zNvNkvoB61a8LFv7ksl
/MMWe3tvLQPNuEHs7u7weHg9PR3MIHUMTgRvYiRy7EDBEDQfgGTOc1XD8+3j6UGGJmoDJd2d
nqEJdn3TycjgBRWkSZcsSmDd1rBGEurBx6BDzlhryhQOMKvMmUfHVAaUN6dfqgBlGRHoHet6
9cfx0/3x9aCSONBdxMzuE719EtA2WqtOga3wuuqcuH25vYPqnu8Of2NEPT3Rr/ztm6MTTrpZ
imXT+1hW/Nfz+/fD29Eobz4LjO/hd3j+Xn348AvOurvTy+GqjfdnL6nRpF8ZxeH936fXH3Ig
f/3n8PrPq/Tp5XAvOxfpPdKGZjwPhnEbs+PD9/dhhYJn/s/pz34hwtT863B1eD68Pvy6kgse
N0Qa6U1MptOxscARENqAmQ2YmxOYTGdmzmOlCjy8nR7xSesvZ87nc2PmfI46XhviGWtbuZA7
0kAAcr8a5rHhL4fbHx8v2ArppPv2cjjcfddHnFcJ22xp9XZ7KalAdMT2uH89He+NJxKRNMDz
Tf2Q9MNP6+QaM3cpS03NE/9aiBsZcEyUGGQZHxw4+vcO8BGr4xYd+Od6u+ABKjo4bcEg4jNZ
Qb+FIA3sVcRigL+5kZdSR5ZFnCZJRPFaWaHHGMBfsuEVu8EoYp+9EUiP04mB70KbaZ9t0bNW
Xe/nwVVAZdWW7Ct0TNwl6Gsa0eEg4lVBs7Ur3iyrFcNAOzTHVqQgfnI4k6lZXDRiadjtKUjD
VrnnT8JNs6T5wJZsEU8mQTilzBVaivUezp3Rwgyi0yOmMQkfBw44QY/hoTzTXFbDBA4bY4OE
ku51glDbzAbcjhnRYUJSS2UQTAYdqaIYzqFwAK/ZbGbmO28RfBKPfHahJiDwPJ9qJF973oi+
WjsKHns+qVjRCAxVoQEfdk/CA7IxiBk7I5JIEmdQLo1gNt8N5gmjehmG1h084zN/FBKt2Ube
hNRmnfHTkTcocFvF8N10NJy/a+lfXwphVbbMSNvk9qvlAv8ehv64TrPIG41G7gQDLkeHVZ3c
WEa/Z9PX079lKLBHZDd/SR1la2Q40FD0lpCmt50MWLYo9zLkMNGtKg0DTQW4n020EOBDjQew
h3WD90uWcFrUQIp1TLtaot9/kzHg3im7rTjJMrh9F6mu5tSAmClck+YRocrSJ7ClL2czV+Cq
7ZdU8C3RjAGJzBnsmLQKr0gpBi4dVvzrSpoN0Oc0Zl68NIog6TOO7smX2omWOZuKxW6j1S4T
8zpmFV2RUhKBwJ+V1+45+4sZr9Lm2uGdjA7EgtUXu1HydbpgzQLO1OUmzegR66jWrp7IZoAs
eSkLFfwNe9Rvdk5bF0Un4zLsXNGhFM1uIS4lJE4vDniVDxNwnEkWOYqzlAZD+Zd3615XTLWY
r45cOdKfpFnlW9qGQrWqdhxRrS0dupADpEgimqzaVU5Lm3O3U8cM8W2tpNS6DJrFVojL+Z6B
fxLOsvJs3x9j1KGXK3Oc82nSc62GYXQPrdJKC58RresyT/oKjANS4UrqmBvSVOj5QK+BLtle
VlEMcIeFsRKGqapEbBYy5MHZbIweIzgpWVFeHKgo26DzZVaWIL6cx2WNyWcAh8kqgYHV9NjK
1hVxn/vQRTIQc/R4uvuhAheiuKoLNOdviGcCioqnYxdfYlKFtN5bI4riKJk6OC6djGMgxCZy
zKdWqZ9X3PvLtqnndkrdfY3iT2ukrgZJDhw/fbxS+SyhMF5LEyP9IQ+gyU7YUPmzMQ3ggXKR
xTYlWgUDz2ConklBrHuEQOJzKg3o59bOILRCjcHx7koir6rbh4O0FdS8Mlvp/un0fsDMA8Sj
ToLhIPBNr1NG1C9Pbw+UxXpd5bx9oVhJry4A0Mo+Saj0z/SphCGd8Pobiv1ldPUP/uvt/fB0
VcIC/358+R+U/e+Of0I/Y0tD+PR4egAwP0W28nDxerq9vzs9Ubjj/+Z7Cv714/YRPrG/6duM
CRa7kd8fH4/PPy3Kvn9t2vJdRCtDK8kFLuvkKzH7yR6vg66e5Of7HWz0QQZ4g1gmuv/CpMeF
hdhXvmmm3iKcV3WL72/2IJxTzqMtGcYOCMaaXNTC+4R0JrgWs/k0YINm8nw8Nq3NW0Tnwedu
wRaTN1M5WmFd1zfEd6mMOnf+0TrHaTu6hzWR4eWvIdDLoyzQF4YS05Bws0yXktysrDWLxXtE
VWtg1X/1txHtG7OFXfUcA3T0JL5OwrsoIGZxAO7In/5K077PgnCsK/ckoM2yqmkVFdglpS1y
5jme6wDl+5Rh0iKPvPFIMfvnBuhQM9ergTF07THzTVV7zAJS5o2BFYv1BwMJ0M20tOA0qqIg
thdIx0QovLIupjkunArRlcP2jhiwmz2P5w5M9GXjjciMTHkU+IHW8Dxn03A8HgDsmezAjozB
gJ1MzGJnRnRHAMzHY089VdtQG2AmC5Y5RBzpCPfRxCeTEfOIoYmyXhAXG2B3KBsnxCzY+L9+
/sE3yZyhECyYvhem/mRi/p575rYACPUUDYhwan46tYqazj3rt6H6n2JiGP333A+squdzmuVr
81wz0qlV3ReI1Etbp7PQYQ2z3tMpvNOC+ft9W1ALUwauduGZiPxwSjN3EuewWZK4uSPnL9t7
I4fdGOI8j85IKVHaCwoCAiupNdvPaZVZHlWBbwbkRVBI2svmSdF88/rRaKEF207RNKgHqHsU
rkBr0DCrbByNZh41iR0y8KlPQj7y6dFWFJ7vBdSibbGjGff0FnYfzbhhn9WCJx6f+BMLDAV4
Yxs2nesvguesucb4AFhkUTgOtc3RpVfN7SHC7KoAl2NH9vecGNneDS13+fIIXKd1GMyCSf8y
GX0/PMlIBXzwoCgymLZq3d4WmpQb8ZlnnBIp++oIYrP7Npsby0m/XzollP2tMrw63neGV/jA
rqTFc+u0a0yxEtKVkrrldPbDYCJy3rdAXSGKe+dVV29fp3nh8UprOVZLyWsmJQaIMxkYYdVN
4wwmwMK191MrS388v2tiQJ80CfOryRuCvhbGo0lonrnjwOGRgqgZdeIAIvStSwMEbIrjlgjD
mmE8nvvoxmbGrmzhdAnjeVCbRYyMF+TxxA9r+9UfT9pJQJ1i+MHMMo0YT8mbGhETu6d0EkVE
DG7SYETxObAfZ2Yw85iHoU+Vmk/8QDcSgIN87BmepXBah1NXOnfAzX3aCANOpZjByeqjH+1g
L+IGvP94evp1zlmnrUkVrSHZrZLCWqwyIrvCuzFKn2roygYkStAYtGv5evi/j8Pz3a/eouI/
6J0ax1xPC6YUJVLPcPt+ev09PmIasT8+2vRI/TTMx5IBUYbX32/fDp8y+PBwf5WdTi9X/4AS
MT1ZV+ObVqNeyhLYjJ49u2S3oa0MabnhkC4U1gsuY+ndJm2FJoZlw77m4diMwZ6vPMee107R
1U1dNgHtu5pX22B0IWN1e3CpImwpoaMRq0AZYajT/3D7+P5du5Q66Ov7VX37frjKT8/Hd3sg
l0kYjmgHG4UjNxXI/yNPt/9oIX7fmI+n4/3x/Rc5ebkf0Fmx1sK8JNfIeYyoF0QjkmiexqnQ
wz4L7vue/du8NVqYcVusxVb/jKfT0Whs/vb74U5hb7yjk/fT4fbt41VlyfyAESYWqsulscWS
d8QiTz19HarftuTWQmnBbZPvJ1p/0mKH624i152hDtERZvk6yiXnt2s14/kk5tRkpTKRccob
w3JRh561MaT5lPkuxUjTSxZ/gSUReLoAlcHRPzKirLAq5nPaiVOi5saQr73p2Po9035HeeB7
uvsUAvTLBn4HfmD8nkzGxhJfVT6rYFmx0YgKVt1zPDzz5yNdSDExvqHtkzCPtPnQdRmZHSxZ
wata10B/4QxkA0OmqKsauH5KGOoaNYhHIuqxeWFnOzguwoiaSThLwnCkny5lJWDOjO8raJU/
QijVjNTzdAUWF5sg8Cx9QbPdpZzOuRbxIPQMLk+CSD/Orsto2zeeaH2WgJkhRQIoHAdUi7d8
7M18LebqLioycxB2SQ6izdToxS6buFRs32DQYIS8AQeQ3z48H96V1u9qaBO5mc2nuu5vM5rP
9U3VatxytipI4PCEOqMc+iW2CjyHvg0/S0SZJxjr2lS75XkUjP2Q2srtiSTrlLfnQCLoWnoJ
jYmDLXRvA5BH41kYOBHmXWMj1aWjJuMc0eqc+fX57vH47JogXUwroiwt9MEZ0ihV8DnxRltv
F+Dj6tOVyrT7eHo+mDzqupbxPGhBUBr319tK0GiBL6VZWVY0WvmKWerojvF7Ob3DVXo8q6V1
0cEn92DMvZluBY5MfjgzzgsFcuiGgMuHs5VW7oSeadCFIHoPiyrTWSC7PzDOuqNNlldzb3Rm
3ypMog18BHntLarRZJRT/g+LvPJnBpuAv20luYRZ8p1x4rvsUdYVKYCBnOHpyhz126y1hRkc
FsAC9eF5PPl44njkRVRAud22u7TLJUJASRWBwhgNEuPQdFZeV/5oQqnXvlUM7nZNqdUCzJo6
oLbFJTPzjIbd1MzyYB4Mpcfq9fTz+IT8M5qp3cts2HeEBXuWxmgPlIqk2ZlX9BKN6UmfX14v
demf7+dj/ZpB9Kw/Jg5PLygCmuvyvKXSvJERW8uo3GKmdOoEEkluWJXl2X4+mni0OYFCkloH
kVcj0yFDQqj1IeCA0R1F5G/fuD0KsSAbsMuTxhU2tLoeOrCn9VeZ7XiYL4Bhwl6Mkc/2TVF/
9vrFiC5PrW3M+ZaU+khRRalPMqfKAh2+LSOhW6LDik4EvgoKzCFlRnlSOJHicRu58h4Soa6q
9c0V//jjTT7Hn/vTpj9qg7CeWx7lzaYsmIwni0jKRmh9g9E9G39W5DJ4rOYbpaOwCMNQApBR
FbHKEasV8dIwQQWlNUvVEHaFAsC2t4LMjkMH888jw3ELfjrc9xCTVX1U9urwip7ocus+KeF7
uEwMTzH40USJEa5IrLdFjAprMwOYy6OBFXFdppSzQMzMZMYJulFT4poRLWZ9ffX+ensnjy+7
6VxoEenhh622QhAvt3WU9JnEKFwfukuXSNEOQRh5czqYPfZDAtuE08avhJHAqIdzMjFYj875
lm6P+Iv2DPyZz9uvcsSb5qkjjSnP0pyycF4eX59k5loitGYSU+uhz3sMs50zzSJNmv3Wi+15
OuIoXjDDtyPOU3qR5WkbP+jJAEUMrUaiNXqjFmXRJMu0WbI+e54muWLg2HSB1uFpQevOltdN
tFxdiN21KstVlvQdHIyVODy83l792Y1Yr6BtBxLdjuTZp/uZR9D4pLku8dVIBjDTbODRS9UY
wWQvfMsZpgU1eyYEpaUHfNAsTdsZBMC5xDEbeZRZdjISyZNoW1th1M4koV1gaBdoobrirKrC
Jimko2hKZvWRFF1w2Rb2ZRH75i+bAqrLF3JUzTsrhasOcI6p/TJAtYi9ROgjjpCvW5B7HNTk
wCKipm08EVUW0p9axp1zEsGaoy9bRLrPgtWS+65ul9EQ2d2/ou66bkGome5x0gtLHlEre8Z7
mnoLQjArAC0jd9FNU9Su6GMKyzhMqqDrSJbNDviKJbWGizRT/dbndem71gC2g+2NJUYudrSl
NCOcdTAVwbgpK7L4FA6V1hNdt+8sYgz7f+PAoz94v3vOk7Tkdib52AakCjCI3rlkCkE0Ua73
cwnyJ8ZilHabUmZHs3DDM70QLRkuW6PlCtxt2776r8tcNDtaYlM4inuXhUXC2GxsK8olDx2T
Cd02lnWksvV1OwIWTcZurLVxhsLCitMaE5PGZIZKipJl10zmps+yUssEqpHClZQYXJSGK6Tn
P64jegufKfcws7Lzg5spur37bibJWXJ5Rg4p4091mf8e72J5Yw0urJSX88lkZI3PlzJLHV44
3+ALx+mzjZfWHCkFR8l/XzLxeyHoJgCuMbdZzuEberp3PbX2dRcfFQNtVmyVfA6DKYVPy2jN
apB2Pv92fDvNZuP5J+83inArlkaIu0IMzhLFub8dPu5PwCIQ3ZKBkMx+SdDGYc8hkbu8DeOi
A1EuE5kFxH5iGrRUpRIx6wAGKovrhLqFN0ld6OPXRXHsxIi8GvykTkeFkFyK5qOwXcEZstAL
aEGyubrLAv5j3Uc5MHUq78UNF0muFVLWGDJ9cHOz2M0AsKXr9E/kIWvU3IOAx+XcCliytpoJ
v1VqQ27QtDCaXVgk7pYunA21Kv6ybC+5XzakPXxHOv/TYq7h1k6Gb/wWIQeBjJH20H1B3VQP
q+h7fOlzjWU0UCB8S3UbXHr4fAP/DPr3TQVGtSrOvtEW6gorddLO9gBXlhbDIiPMzYZiB+0e
pBNVmKqHZqh1MpnP21HPku1ArrW60e2PmuXGnSZ/K64DBHLT+0iiXMGv+dct42v6KG15Yf3g
TQuYSpK6zO19UFmAr8U+HIImg0paoDMQbVeTzu5LGAqBaBp/owaC7K9NaY2Lq7xSaEkbFBYW
pJW5oodDodppLB3K7N94lWRMJP0CN85oRQJz36NpRWJHF/5dunX0tyhnoU/SmVRa0y/3rbs3
B4QDgt/uD38+3r4ffhs0KVKan0utRr+hS3jYCZRK9IbvjEW5HSwvBVFnJc3ZXJTIkn3pOsOB
p74u6w19rRVL8xbB3zvNLED+Dix8YN7DEhaav/k1M/xUFU1Ds+J1WQqkoBq/lCkBuiDocWG1
1ZLUAWSqzuE3tJesVeEom6FVLR1SQdQrtU0mDz7r56DfMDDDsO6IsLOB8G1RV5H9u1npS72F
2WMJMLjKkLTZ1AvS6UB9OJCHoqRa04skSvVVgL9ksg7Tx7WHUlKTxF4nbNNU15gdeG0Vt60i
lmUW0GLeJEze5RbMWG8SMuxbD6VtIM941P1WwITeuAaiiV3t5fkCzXY0JjJm1kZmrn04r4yd
Jn9SbK1CDJmVQg8NCT/OB9pQkEB0J4k0IIkYe0LHTQP6ndkkmlKLzCCZjY0gnhaOTGtkkmgv
tBZm6sLo9k8WxjNHSsP4zm8C5zehc/hmE9oY1yKi7DctkrmjXfNg4sKMR44WzwNXL+fh3N0X
Mm4QkoC4jeurmTnq8/yxayoA5dk1yhiXzmHrKqPMFnS8b6+3DkEZAej40GxqBx67ynNNXoef
mqPSgec02Avo6j1Hs0wLBMRsynTWUHqiHrk1i8Ioq8A3smIIjpJMpJFdg8IUItnWlGTQk9Ql
EyqN/PDzmzrNspSyTuhIVizJ6LpXdZJsLnyZRphDNaY+TYttSkWtNcYhlUMx+FZs603KqXc1
pLD1MXE2fGHfHF6fD49X32/vfhyfH7QgPZKhSOuvwLOuuO0j//J6fH7/ocwnng5vD8OYtFL3
uZFJiwwFBnKrwIissmSXZP190OudlCaBoAj11/xSdOXHiSvrbHxTMMxiQ4c7jk5PL8fHw6f3
49Ph6u774e7Hm+zNnYK/Djuk7uG0WGrRYM8wVHNuo8SIgatheZWltGJQI4qvWb2kDTdW8QKf
RdLK8UyQFBgASCqZoUQQHiIQNMj8Poow33KhHik0lSAIAqqIz97I18abC6gYjsAchAJH5sA6
YbEsGKiIWrcFMMQxfr4oM1Omw8kurwvS5bvL2KppjKAedM/umm4NI3AgqAtBnVjORETtC5tE
jZmZKFyNRFWqNPGDWpYlvqsrvlGltKKMFRhap4DwUn/VXzN6YK80VTPyefTT0xQKGt0wj7XR
GFRMJtlnI+/kVXz44+PhwdjPcqCTvcAwgWUx7BTiMS4y7TAhv4YBwUBPZKBgVUgNvKVgXfpl
q4Zy8QXGnl4/7fRljLJDkTFc2t7mSZ7BwA9L7zCXihdoGrTF8+UC1Y5awKyGlQISQkej4p8P
W9EinAOkAijAdk+JAWoXE8y+IyCTIlunqzWUc3mgZF/xUWSpHluooejQl4ZsjRZYg6cJXF5X
6Iv08aKOzfXt84PxsMLLpUBxc1tBSQLmvaQVqWtWx3+HTiGbNQaOEv/f2LEsN47j7vsVqT7t
Vu325L3pQw6URMdsS5aiR+z4okqnPZvUbpKuOKnp/vslQEoiCdDpqpmaCQCTFB94EQREwy/z
6hpS5aXzrOS2aAUZn8APVZaV65xxwf2NyDs5RZMZJAixsmsvD0cmovlPRu05BKO1yTsV8Vdm
F8plRlN1elMPnS6krIxX3cQ6wrOx8Wwf/H334/EZnpLt/nnw9P62/bnV/7N9u//8+fM/nCDG
cihOi8lbJ0Hu3n3cSC4J+EiBbcCH7dkqdaulSivXcu8JtymD9pB83MhqZYg0vyhXlfDDisJR
rRoZkVmGAD+NMD6PZCiHl+vVoEfJzlsvKjWmbuU7xK70Bofq88gjmR6nbyNZYHHjoFrmDgLF
lx4/FBOWMtMbrNZ6ZsnnELKs0nDi6Pfqf28gJK6RzNeqSOI1y8LURxQRX6RB4s27CgoABDSp
1rS0oq+Cd0omy1LaebJv0k/SDtjrjEy7R/HB2gAJ8Ge9EHq+B6ZwfOTiyfoAUF7v84PaTX1t
9YqaaBQBpQmi0KIcggz5j4FRzsu2yg2rR58zxrDyJqyd9V7WNb57+Gp0JJbYXgnvpQEv9zK9
5XNnQryFs5ep6xGl2KxbGj0NieoY9qoW1ZynGfT/2bAkcWS/Uu18qL7j9WPQRVp2y1YTpGWd
BSRwy4zbAShRZQwbSe0PTSvOXTC2nfqXJQCMsGkzGF490xxcZVqRnqfq6OTLKRYQASWD30ZQ
o0Wf1OhVkh6m3tx4DEy+b6yxMSzuImuddIRAhGdei/zaS1CLmCYWsJFMG0Bzuj3nMmm1aR3H
o46upXa/n0wffjgUkZNtOPz5KcN1TcUWqMJy3vsY/L65XINrNpgPsJiWYK3klann60/KQuPb
kgsORjSatjPyq0S1hYjkJQV817Exo4irwbuNSWLJCgEm9rN8URB6PL9pWXGXuGaclZcoHQJN
Yex9onnCvBA1L/zxp1xMabCfMKgj1nWH7gCyGKLVRx2c58HiLYrSedalderQcEGzRVvUYNTo
IwwvsmI8rxGQHYBNlAhMAA2IhTbj3ebh733GRpc0wsYIqo3sPd8+4rzbOELM38khmcjV1bKI
ZY01NMsult8Wpxpo9ltKEOjeqwa1q5XvGoEDkraWhmkFkjtbHQTdPW5KTynq/Nb6f9w2XXif
JVeRGr0uFbxfWGcJp/pheukWr13CElETKqpCrZzboKzs9LkbbnoDYQ5xP3nHnkDcN1BoKCIn
IdEFbHfMp90fri8OJwMlxOnZP+Jx9sgc81iI6rg8ITjszI0rnxCSD6gYKbq4x26kCWNJxhkb
4tGcIbrhO1Y/QvegqEVE708rERV9EEtTwPFREIoclEyypRa0IhXxOBodtpjsgMi+sm4kvxS6
SRMMkig6um65ghDJmjioTJ6g7f37KzxqI65LZH2TwatFkpbX+jsAAYLKfytlf8A6DzHiS9sY
PjPVf/XZXE+erMUQizQddXsrqNUO2eCzKTz7vGsuuD8cIF7k3dCeDRKIY/r1rC4YNJiMjj7T
FJA6r4Ionl5kWX15fnZ2cu6dQvBSyKX+bhB+IPuMxSiCIEJCxnykVvIx7Ni8znFGZ6QU/BLi
nIzq8AHafMmnP3bfHp//eN9tX59evm//9bD934/t6yfy2XpTqmW3ZibEYvDk4MH5HZrRVUJX
eqDNVAMqx56lnkjB2V9WezoWN+l4vx+jQY9KLa8h2bQd3yElLkTK7RqE9wkciK5id7ChEFUF
3huoqRbYoPQX+jSXt9yF1EihWxN6SWtmQAPqt+Z8JA71uT2kMT4zUkKNmkotmbFZjPVeZwzF
rXBLHLJPIUagmUywvZnRTFRQzseToSpSElLexPwfRoKEG2ePsCHbJt7YMK+/13UmeI+TT3b5
afd0d//f8TSvYTuAydiEJoqfHdTAtHKVVrchdO3mzjOg6pq3eMBydUqimHp2g8BJX3/9eHs5
uH953R68vB4YvuMk/DbF70R+JbAeKAc+pnApMhZISZN8kapq7rLJEEN/FIT5TEBKWrvxzBOM
JaSxfMPQoyMRsdEvqopSayBtAQIFmeE0gsAy+tEyZYCFWIorZkwWTjuzz2dY6kEAmPdNhOpq
dnR8UXQ5QYDlwQJp9xX+l4BB/F93spMEg/+hO6yIwEXXzrXaEx6BwBVggY0qaAtXmmNbTwAo
f8PhEe9vD5C44v7ubfv9QD7fw2GCUoJ/Pb49HIjd7uX+EVHZ3dsdOVRpWtCOEDapuZZyLvQ/
x4dVmd9CtSUufsyOXl6rG2aXzIXWhG+GcSeYuw4UjR0dVeLFRgzQGWfkDsiW7p60bcjUSnwk
7sPyesXsh4Qu1prZfFpnXdUYpGgeYt/tHmJfpRk/5RgccM11fgOUU9KS7e6N9lCnJ8e0OQM2
D51Js4jkf6InIYdjxfykPTrM1IxuHcsVw6X7eNMU2Sk9S9kZhSm9j6B8j6IzVBdQKIzpHhDn
XL6GCX98dk760uCT40MCbubiiANyTWjw2RGdXg0+YcbZFFwA18ApruqjL7SpVWU6MJL08ceD
XyxjkHsN052G9i33BN/Bn12ck3kG+FJF9pNYdomix0TUKV1grYCsoNgMaWRAkOy3ww4UUMpF
CY5PiablAxMdAi6ubRBwkg5+NgiHsK3FXGwE5ywdFlQr9sIvD+9jYH73MDXLc6mAkDJjgLU2
KKgMs/C+aeQxrie38SJlYyy64i+YRxkmqFxblezKWvi0sGFfA0EwMWOwFeRf8tKbjuuGjyIo
c9+UZBAXp/Qc5ZtTQocvOoazVd89f395Oli+P33bvg5JV7mRiGWj+rQCrS9sMKuT8BrExVhh
EE6JwfHudZeEk4GAIMCvCuoAggOqrG4JFh3znKo9IIzuS5duxDdWI42PdyTlZmlEsjo8dD6E
z4UjmK+YLrUdUhQSnEXoYEJn3y8GWXVJbmmaLvHJ1meHX/pUgstFQUgc+AU9hbVapM2/x6jD
ETt55RBvbgsk7/YD21VmfSXNE3V8bg+dBTcF5iRAVtM/UenbHfwJCWse//NsEkBhEKIXsmVe
vvRt3TXW51Z7Tywpvrn85DwRsnisl+5OQsw7UC4zUd+G/fHUpukkx7pdTcsRW1J0oC1uPN3U
hkmpDT9L+eO317vXXwevL+9vj8+uSmasUtdaTVRbSz3njbPqxgspHBtiyK7UtPVSW8T9rMbs
Re5OcElyuYxgoUBv1yr3XcOAwouumarNVR3FV6kKM5kMqAA83qHMBGRL1GalqnLl21na4E81
O/BAR+c+BdX2dFdt13uWi1EjnRMJGiTnwA5J9KGTye3FxyRcjL4lEPXKMP/gl0nk6lpjI605
Ty5ylVCNOnWSu67XlhMO8w1+pWEx3MGYUJrIfFga91Hg1CFAM0nh8CoXuKAv8xBKJKH70NH5
uk3Jtuw+d3Sp3ceNPjU7vqbNmGYQ7NBPU7kBsMNw8W9r6PowTAFWUVolzk8JULie+wnWzrsi
IQgoTU3bTdKv7lpaaGQVp2/rrzbKS9c0IhKNOGYx+cb1dTqI9SZCX0bgp5Q5uFcNw76UEEhY
5qWnZLtQaPWC/wGgXE6RpHPvD4zSH27QXKaaqbWJskCOVNaZy5FE05Sp0owXL7tr9xYeOJnm
cLIIQXCf2XucDy+O3blsrnIzAc58Qdkgk1LEC+Q0OXdGT7KDqDptE3o5uK5d2ZCX3q08/L3v
wC/z4AVgvoH6ux4T05OjWPdu5mkXqr4GG5uLZygqZR7w279LlUGEkpa1tRupXoKBwMQKaTib
9gXoL35eBC1c/HQ3RAPp+kpnhkZ51MAsC+9CwESlOAAT+jIG0vz62/8Bln2e0B0EAgA=

--wac7ysb48OaltWcw--
