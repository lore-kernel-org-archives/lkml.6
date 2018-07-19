Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E46B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E46B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGTAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:40:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:49498 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbeGTAkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:40:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 16:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,376,1526367600"; 
   d="gz'50?scan'50,208,50";a="68553927"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2018 16:54:38 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fgIkn-0002m2-DO; Fri, 20 Jul 2018 07:54:37 +0800
Date:   Fri, 20 Jul 2018 07:54:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@01.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries
 (mk-II)
Message-ID: <201807200713.X3kvIzIF%fengguang.wu@intel.com>
References: <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.18-rc5 next-20180719]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/perf-x86-intel-Fix-unwind-errors-from-PEBS-entries-mk-II/20180720-061741
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:17:0,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from arch/powerpc/kernel/ptrace.c:32:
>> include/uapi/linux/perf_event.h:147:39: error: left shift count >= width of type [-Werror=shift-count-overflow]
     __PERF_SAMPLE_CALLCHAIN_EARLY  = 1UL << 63,
                                          ^~
   cc1: all warnings being treated as errors

vim +147 include/uapi/linux/perf_event.h

   118	
   119	/*
   120	 * Bits that can be set in attr.sample_type to request information
   121	 * in the overflow packets.
   122	 */
   123	enum perf_event_sample_format {
   124		PERF_SAMPLE_IP				= 1U << 0,
   125		PERF_SAMPLE_TID				= 1U << 1,
   126		PERF_SAMPLE_TIME			= 1U << 2,
   127		PERF_SAMPLE_ADDR			= 1U << 3,
   128		PERF_SAMPLE_READ			= 1U << 4,
   129		PERF_SAMPLE_CALLCHAIN			= 1U << 5,
   130		PERF_SAMPLE_ID				= 1U << 6,
   131		PERF_SAMPLE_CPU				= 1U << 7,
   132		PERF_SAMPLE_PERIOD			= 1U << 8,
   133		PERF_SAMPLE_STREAM_ID			= 1U << 9,
   134		PERF_SAMPLE_RAW				= 1U << 10,
   135		PERF_SAMPLE_BRANCH_STACK		= 1U << 11,
   136		PERF_SAMPLE_REGS_USER			= 1U << 12,
   137		PERF_SAMPLE_STACK_USER			= 1U << 13,
   138		PERF_SAMPLE_WEIGHT			= 1U << 14,
   139		PERF_SAMPLE_DATA_SRC			= 1U << 15,
   140		PERF_SAMPLE_IDENTIFIER			= 1U << 16,
   141		PERF_SAMPLE_TRANSACTION			= 1U << 17,
   142		PERF_SAMPLE_REGS_INTR			= 1U << 18,
   143		PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
   144	
   145		PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
   146	
 > 147		__PERF_SAMPLE_CALLCHAIN_EARLY		= 1UL << 63,
   148	};
   149	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICPgfUVsAAy5jb25maWcAjFxbk9u2kn4/v4KVVG3ZtWufudlxdmseIBCUEBEkDYCSxi8s
WUOPVZmRZnVJ7H+/3SAl3hrKnkpOZtANEGg0ur9uNObXf/0asONh+7I8rFfL5+efwVO5KXfL
Q/kYfFs/l/8ThGmQpDYQobTvgTleb44//v26/bvcva6Cu/fXn95fvdutboJpuduUzwHfbr6t
n44wwnq7+dev/4J/foXGl1cYbPffQd3x3TMO8+5pc3z3tFoFb8Ly63q5CX57fwOjXV+/rX6q
+qZJJMdFlvGPd8F6H2y2h2BfHqqBs912Ve73212wP76+bncHaG06FKM0nd6a4vbm/mdnpOLT
hx8/2oN1iR7a3ZWn/Y5uFzdXV23CYGIwq7rt448fzS/IEGV5e84stnImuGc0Y8NCqbw7Qt1Y
Lb7VPmEzUWRAMHmWpdq2P2NURnxiFpq0PQrP8mKE60tCyZLO6G2225uRtM2vnQkyzSfQwrJC
JyEMZk2h2OL++rdLDDK5v76mGXiqMmb/eaAOX2e8RBdSfzb3H65vTk3GMj61mnHRklVNq5qh
RxSzsRnS45RPQ5ENCXpuhCoWfDJmYQj7Ok61tBPVMIxFIrSEfZoLOZ7YnswmzBShYoURFhYz
EVokFlZspp1taH4RTMcPRaZlYtssLIEvWKlEmtv7609X/Y8nM81aczJ8IsIiVdIWERBAf1IY
UOj+hrKHWr1AgcPWLFgO1sPx9JcjR0InzMo0gTGNkaNY9FhqCcKyxSjHqY8Fi0G8PrY80+lI
tM5WNrYMhi1iMROxuT9vL+eFNMWYt0aCX4qZ0Aamc//bFRzfM2/MkvGZdG4e5TIOUYyFWFQf
MdVmO+M0dpb0GY/S8bUxTCOdTkVSwIrhuDXflgmISCQzWA6ojwRZ39/eNEcTNVfCB6wwljij
IBAWn+b3yy9NvzYB9sGmRGe3Z1PYCBEX4y+yNSmyMRQRy2NbTFJjE9CG+1/ebLab8m3rq+bB
zGTGSbPINWx0oYRK9UPBLByyCcmXGxHLkW+6btOdXsG3YInxSepwJsEZfN3/3B/Kl0bqJ80G
cmEm6Xx44E6USlFaGwPtYaqYTLptUao5nAo70YKFMhm3jkvGtHHWYfgVpy2zZs49MkfDAd9P
rCGIKkX9DpkVp9Xa9Uu521MLnnwpMuiVhpK3TXySIkWGsSCF7sgkZQLWqNDCuBVoM3DF4BX+
bZf7P4MDTClYbh6D/WF52AfL1Wp73BzWm6dmblbyqXMjjPM0T2wlvfOnZlLbHrlAIzGj54yb
4cTasA9mp3kemKGQgPehAFr76/ArHGeQnaW/Nq1+oHV7rNM8MyStMqJ4BB0TyaNFzB5Iyiie
wsGbOTOhQ+JUgOlKMxCD/CJQNXHz4T+KJVy0V9dnM/CD74zFIXySodcMRQFaxwqBhqmy1+1B
LzISo6P62xikzEXmbL9zpy2v5cTf/oICgyPBImhatGNh0QkW9bmimR5MZC5yRBOW+A4GeCe5
IHS/YXA+lt67nNaWEQMrEeW+2eRWLGhgmaW+NcpxwuIoJIlu8h6aMzkempmAsSYpTKZ0eziT
sLRa1rS8YMwR01p6thQOC586mIFGx6aa3pYpjv+g6E+MsujifqM+OVcWUQfqjLeamRY41AhQ
oekYDCM+E/2hlwhDETZqXWEj+GZxtvCN+vDrq2F8UwdVWbn7tt29LDerMhB/lRswqwwMLEfD
Cua/Eyc1w5NrnqmKWjhT6VPmE07WtEKbmFGO2cT5qBNOxOnI2x/EqsfiBCb8bJEWYEwMqAEc
zpTWwy7jhOkQPCatzIAOIxn3XER7f9KKo2M0/8hVVsA3ROzrJaJIcolyzeEAwilEU8+5MKaH
U0HnHGwEz1OMzJxlPfWQoOkYrcAsbI807SPbqlULSxOqVgSaUc++NgjKESYQjQ7RBqBThxNq
hEMEIuA/rIweAPTmejC8FhAXwZZVYVQtjIJlss8Hp4c6ItifasdDW48Z5qovPje3ZrsGkwaW
RMnCsEgAnMowDuvxzAWboh8WaJwZ/5xL3Q9J5gz2GeBtUeG8E+wmZmIEx6NUgEJ1wqUszseg
AIigIf745ek///OXTmcMRCqejpFoNdMIAHfFyQbVR3Awm4Dokv7WEPiqr4VDSNXjUGlYLzET
XEayFUUBKY9B8VDVRRw5UEOMLxYQ8IByOtyNcyY0zHV35x5gCiXgTorgUn6hFeoDxk7gEMIX
52ApWr1SwDHgQU0Oa0rCQTvjtrPN7iOpAzAsPoVKer4g1mEsnCjb5WmsV594yRllkweA4Ckm
ATo+SERuowZwoopEeTp793W5Lx+DPyuP8rrbfls/d0D5+RPIXdtJkHI7SnGAxShsu2558mq/
PbAV4hliPTIBGwxjZXAK8gSZuuFSTUfDU9Mv0ci+cy2t8HVuE7u9u9kEZkH1eKHV/BRxZc/L
AzrjVsaxkz3kE01jeySqjH+4vvGnHpF+cyE1mSlGB9Uub3mp56fbS8SPHuIJw/joTMGxgNNE
YzPAGuO8l69ogViWabSgDM2Rd2pphMlSi45KAeyV3W+dIs8g2pX/eyw3q5/BfrWs9bpBM2Dq
AB18pnrKx+cyeNyt/yp352w1jIfN/SG8QbNlOdkOnrTQlt4wI1UGx2ucdSF0G/VtXzGH3kF3
GIT7wDiE9ddkwhkINx+u2tYCWm67rL1R6GHuYZizBwO0pTJ7ci8tfFW1z9IYzBHTdDRbcxFf
GckkUhYNfyscjMG46c5najbDtcxo5ak5lDSeNBSMiADCZ2xF4hJ6dZ5qklp0vIRpnzOIzCuu
HnUwAiC7dNZZxlQshC9LxsykuDTBKGYWxq4/07JwcSzG4JDqHG0xY3Eumpxl3a3hxwbYxtDN
tFADRIrhT9eGdprrroNuJxg5zluUJHWnufN9k8UABDLrBoNzZu7veoEI76cRGtcjx9qXZHAo
BzzlKO9gqKlRBPMpp+kwgwKnxMJQ399d/f7xPHUBkD7DGBBMwVR1cioAFhPOIGSlt1Ixsv1L
lqZ0YPpllNPRyxfnfFOPDxAa5wZYyhP7wVYUI5HwiWKacsoNyLCiwnWs5fzRGt9NXQK+hZmq
4KAwExnZ++vbs1JhchSvYoovYCBSCMg0IrCWTELnh0c9EZxO/ALsPdhViBABurXz2Rm1e9Iw
dytSRRfOYI6O+5YBPYkPgV+FnHrBTj1Ce1cjExfxiLxz460gBn6p08Om29jkeFtBvhSIK0Al
6R2EbspILw2Dkam/q7sh8VKNzeloHIkynXlpmfbPKGNGhgMHBpRgtd0cdtvn53JXu9f92b8u
H0vMZABX2WLbk4gKJFZwBvE8qBOGS96ZRBb+/9rj1ZABe5/2ezDjsNyvnzbz5c5NK+Bb+MGc
p3NelNg8vm7Xm/4U8SrUmVtSEvu/14fVd1og3R2awz/S8on1OIWMc6Zpy6BB90MCS7DHvzBt
9Hi+hWon6TA5HNYhzDCjH5bflsdn14Dp+30AsDdYnsZbtS/6T0ctQAEeIc5ozlycztGvYJ75
/uoHwA73v+YmciwA40VGWKCuetQ6JAKLpikyxkISztiZ4arHYF1OuPryuXNz1yEoAOKcF8fU
4R/yfJUXln+tQWPDriK7C771qm4O0iFey6tc20TEmSfPGYqZVVnkuTKwEPuy2AewAUW54SMJ
8QnTVWJpeBqj9e7lb9yY5y2cvF17ftEc9gdOFz03dDVzd+tAgaXWEvBiNtRy5l2jYxAz7YkS
Kwa82qyHKSqoRGzP+S4M0xe5TV2Sq230H91WdXZBWSq/G9pWziKN2nYago48kdZz1wpUxEwA
50R7gPqunSQhmujkAqGtE3WmmCYxQs/gPFboqD0ZEIXuXQy1XbbCQoHzzTuEVP26jrppoBnJ
TIm+mVPr/YoSImy/esBJ06o4YYn1ZWfH6F/4HUm0MlJOveggMeFxanJQbZSN5B79mWSAeumr
CANxo9clnMz24Fa9wSk3pOCEAL1TlMOqKMXvt3zxkR5x9Nv11WDF1WVu+WO5D+Rmf9gdX1yW
f/8dzu1jcNgtN3v8UgChLYSrsEXrV/zxtGns+VDulkGUjVnw7XTcH7d/b/DIBy/bxyNEuW8w
Rl7vSvjEDX976io3B4g1FfjE/wh25bOr/Np3VaJhwQMWdoJlw2VENM/SjGhtBpps9wcvkS93
j9RnvPzb13MdmDnACgK13CyfSpRh8IanRr3tm26c33m4ZvP4hNYijCIhlDcLVBuf05Dh2RAZ
DiiuOkTDyjQkYtKsAzZz04tiqjUKIYLr29/vgjdgxcs5/PuW0jrwAGIuPYfoRIToy9DhuGIc
TkGKAaczv0MsIDevx8NwRecRZJLlw2MygY10qij/nQbYpWNRDJYn/P9smmPtZMKZEuTJ5HBi
lqsDgqyhDbOWXj+4Jl9WBUhTHw1nBegDHaQP0ctMAfJ018q0b5zML11suTos2jdnEDZzTzfL
4d/Mu6C+4M60hYzjh95Squ2/4eSu33iSWxkdMRiQBi0FX9CTDeeS2SxYPW9Xf/bNlNgsv4KZ
A1SIdUNYgQIIb57qKQJFd50BeEplePd32MJ4ZXD4XgKgfVwjbls+V6Pu33dguUy41XSUjrm7
XoXSmTa/pteTzgHcsJknhnNUxAGeMMfRMTcd03o8mStPosROhFaMXsecQcgRptSNqDGjdl1e
s5GGuv8dcYjBKfZRLwVSAQ2ILdbfjpuVCyBq00JERioKC0xZxQCtxMKn8g3XJOYhrZbIM5Ef
726ui0xJmmdiuQtq+S1JjsEYSU/BGtKMh4af/oMlX7CGK/RUTSDPVKgspiM8JCv78fb337xk
HfLbm2u6aATpRn24ohWTjRYfroawpNv7wXBfHg7IVhZM3d5+WBTWQMTu34LZ4tOHD3QQK8Y5
wOeUNpVKhJKdrmYG6jTeLV+/r1dkFoGN6chlNmbgbegTHGo1+AbjWfCGHR/XW8Ac59rzt3TR
O1NhEK+/7pa7n8Fue4QQujzDj2i3fCmDr8dv38BRhUNHFdFzwjvL2DlG0HFKEs0BTfOECnpy
ONDpBKBvDOFNLAY13Egf1Cxj4zk3OOEd4JKTlgB7VFkytypkcvC1lwnC9uz7zz0+PQji5U86
NZKkmRtwwYWks1RIHbNw7LGb9iHzJFSwYx5n0uu/8zm9E0p59Fsog9WNtDcXWFwa0l+qCiTk
SMLOUJGeCBk/XUcarl2lTZs0rDQHSwbuqXNLbLHClBlPFK4YgIN+kFXlPxQb5RF1I2UeEo7l
DbTZYPkilCbzFTXmHkvoUvcEFO0wyBSkneSDuar1arfdb78dgsnP13L3bhY8HUuINgi7AHhg
3CsFavlSvJzuX19XvR36MNvjzuOxmIxHKW2GZaqatxeDkXX5sj2UGM1Q42JSxGJ8Ocxf6teX
/RPZJ1PmJC+/pejHDlUQA995Y1zFbJBuAFmvXyH4eC1X62/npNf5KLOX5+0TNJst75/y0Q6C
0NX2haKt36sF1f75uHyGLv0+rVljKfVgygusafjh67TAwq9FMeP0dW2mEBz3L4qb4HBhve7P
XfHR++0Re2JpwwKBiNcYZfOhS8KEzAp2ZhhmAoVP2nX7TKtiDNYDb2US3a7gkBmWU/k+6wAp
QIPE6jT2xTGRGiolwO5O0XWDnOskHjKQfo6rYpomDO3zjZcLUX22YMXNp0RhBOHJmbe5cDwv
l4KYaoI3RCpUHz/6bhIQg3NG4wnF6U3VbGhS2eZxt10/dmBKEupU0ugvZLQ9SfqRaxV4zzFn
tFpvnmizR2NovC+OIVSgNxhzSyTBE7sZ6TGBJpaKCjKjNURvlbJ0jq1YoK2MTFVMVKSe+npX
roQcPosOI4iE64fMe50cJikWNHqE42iFtwg9Yhd6f85TS4sPk9iRuSs8VwAV2UeNsMbOQ6uT
xj1yfQO3+t4DnGZwf10d4X15fNy6p6DEzqAr8n3e0cAAxaEWtLRdQT6dI3X/8S/bpeNwv2EI
KzzV30k8XDiBx08mR1q8TdFGDC+HjdUJz0CSmNnF/adZYpF4qNUNa1Uj0SxSg3w4wHBaBJpf
exLI0M9eX4Uy8pKlzQvq5gJo3bewrqEwIo48dx01QwyocPTwiehaUejcfs3C9JxZT2mE4wDZ
+6jegekgGPCuG9JXU8M/eewzZuA8kmjgwxfAB1Q9AIZFsL3topaqCe1WvzTGdAsQXFmJceAb
YoNkbCdD9alQ/8e7jvhTHXo8XhjSBgoLbfsvRxq5RSH11tTgS4zq6VvLfWh8kUXJql2+9n25
+rMqxHOtr7v15vCnS8s9vpQAVgfVGfAfkzobPnZP8E5FOffnx7wKIiS8MB5w3HXemb9zT9DA
xK3+3LsPrur351QAU909yiSicVpdxDVnOgHWTAsOuux5Q1PXe+XGVs9XCEFXz2dxtPvrq5u7
rlCzghlVeJ+zYKGN+wIztP/OEzA/mKdRo9Tz6qa6b58nF29qu1b3pLkC74lNtbK2OlR9jHBV
WmiaFeYTaYvfY6rEmiaedGY9G1dK5Mry6/Ir2icwxLbgEDT1GKcaqqonOGUlFARb4AvC8uvx
6alXMurkBIhfJP17md7szu+R/eLOUmnSxIdKqmHS0R8gG1LueAVSTx9MTAxyGEr/RLnwherJ
RI7n5wLXzHdpgMS6khGfIF6eqPsW4o8odi9tqamcyJTTqR8ysAQr0aun9hknxpn0rqPrWg3Y
zyCGEP34Wh3/yXLz1IseI1dumGcwUvVOwrNsJBaTPKlqSUim+Wcyg97SAXxsD1qf9pArRT9X
azZzdc9Gq90T+CcM+palJxS855gKkVGvYFEojb4Hb/av64278/iv4OV4KH+U8EN5WL1///5t
u4AHn9rg2GNn9od/NgKg3uwy9HZjYGHiJQUl0i19BcQnkRdrSObzignfns0z5ollKl43Kf/Z
rZhOGbcYRPoPY6F0WCbPjpGep/sqKJzFqgYv1mjWcQmRNH+hgh4ErSssEByDAZgBanThqrE2
JJUhurRS6ZlMbQ/lP3GYS3bQhVDSl/areLiGtSRWMgLg4ztv0qDjq273fswrTOT4x31xTF6B
u6fjn82FQsxaS+u/HlBovz87SaIQWqcajO4fwl8HXRUvkzxt6xzlCW/eW+v7nzR1rFk2oXnC
h4TheSBfFFaNhapeIgFUAozaY6mLYqvBXe1Nu5ZYYx0CaWIiv9Drwt8LQtf4gk1Vu4rj99PG
7Tyed+edl06q1+2wMJ370wiG4dsOrzN34Ho6Djupefyd6HAG4vkI3CG6RGnx6X6vsNhRL3Wv
KhzwD564oj7RucPByu5QmgroOnWj3BQwVcRWmTO+eT89xhQZxC4fW5DW/TWADF2jL1xoby/E
8wvwxxfZlJEYLGKN/kU+nKt7Vgh+3v11nAvKsfBdmY9CWZfj0uQ0tQtQqYV/ClVB4ODTVXK9
XB1368NPKiSZigdPPajguZYWxoRIyCVm3dPBi7w0mEc9PL2TdkkLnmYPlTPE+9fOY6E+G72D
nbfAPm9lwXTgMApUY1gUe7aR/zdIcYbwrSPSSk10WZTdAeDRPdxzSqGOPp5RGPtFABP9Nz0E
TQAA

--KsGdsel6WgEHnImy--
