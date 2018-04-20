Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeDTUh7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:37:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:17520 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbeDTUh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:37:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="gz'50?scan'50,208,50";a="222088520"
Date: Sat, 21 Apr 2018 04:37:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: kbuild-all@01.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] prctl: Don't compile some of prctl functions when CRUI
Message-ID: <201804210452.WobkyJdV%fengguang.wu@intel.com>
References: <20180420072903.GA594@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20180420072903.GA594@jagdpanzerIV>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sergey,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc1 next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sergey-Senozhatsky/prctl-Don-t-compile-some-of-prctl-functions-when-CRUI/20180421-040826
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/sys.c: In function 'prctl_set_mm':
>> kernel/sys.c:2108:10: error: implicit declaration of function 'prctl_set_mm_exe_file'; did you mean 'set_mm_exe_file'? [-Werror=implicit-function-declaration]
      return prctl_set_mm_exe_file(mm, (unsigned int)addr);
             ^~~~~~~~~~~~~~~~~~~~~
             set_mm_exe_file
>> kernel/sys.c:2174:10: error: implicit declaration of function 'validate_prctl_map'; did you mean 'validate_creds'? [-Werror=implicit-function-declaration]
     error = validate_prctl_map(&prctl_map);
             ^~~~~~~~~~~~~~~~~~
             validate_creds
   cc1: some warnings being treated as errors

vim +2108 kernel/sys.c

f606b77f1 Cyrill Gorcunov 2014-10-09  2103  
79f0713d4 Cyrill Gorcunov 2012-03-15  2104  	if (!capable(CAP_SYS_RESOURCE))
028ee4be3 Cyrill Gorcunov 2012-01-12  2105  		return -EPERM;
028ee4be3 Cyrill Gorcunov 2012-01-12  2106  
6e399cd14 Davidlohr Bueso 2015-04-16  2107  	if (opt == PR_SET_MM_EXE_FILE)
6e399cd14 Davidlohr Bueso 2015-04-16 @2108  		return prctl_set_mm_exe_file(mm, (unsigned int)addr);
b32dfe377 Cyrill Gorcunov 2012-05-31  2109  
4a00e9df2 Alexey Dobriyan 2015-06-25  2110  	if (opt == PR_SET_MM_AUXV)
4a00e9df2 Alexey Dobriyan 2015-06-25  2111  		return prctl_set_auxv(mm, addr, arg4);
4a00e9df2 Alexey Dobriyan 2015-06-25  2112  
1ad75b9e1 Cyrill Gorcunov 2012-06-07  2113  	if (addr >= TASK_SIZE || addr < mmap_min_addr)
028ee4be3 Cyrill Gorcunov 2012-01-12  2114  		return -EINVAL;
028ee4be3 Cyrill Gorcunov 2012-01-12  2115  
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2116  	error = -EINVAL;
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2117  
ddf1d398e Mateusz Guzik   2016-01-20  2118  	down_write(&mm->mmap_sem);
028ee4be3 Cyrill Gorcunov 2012-01-12  2119  	vma = find_vma(mm, addr);
028ee4be3 Cyrill Gorcunov 2012-01-12  2120  
4a00e9df2 Alexey Dobriyan 2015-06-25  2121  	prctl_map.start_code	= mm->start_code;
4a00e9df2 Alexey Dobriyan 2015-06-25  2122  	prctl_map.end_code	= mm->end_code;
4a00e9df2 Alexey Dobriyan 2015-06-25  2123  	prctl_map.start_data	= mm->start_data;
4a00e9df2 Alexey Dobriyan 2015-06-25  2124  	prctl_map.end_data	= mm->end_data;
4a00e9df2 Alexey Dobriyan 2015-06-25  2125  	prctl_map.start_brk	= mm->start_brk;
4a00e9df2 Alexey Dobriyan 2015-06-25  2126  	prctl_map.brk		= mm->brk;
4a00e9df2 Alexey Dobriyan 2015-06-25  2127  	prctl_map.start_stack	= mm->start_stack;
4a00e9df2 Alexey Dobriyan 2015-06-25  2128  	prctl_map.arg_start	= mm->arg_start;
4a00e9df2 Alexey Dobriyan 2015-06-25  2129  	prctl_map.arg_end	= mm->arg_end;
4a00e9df2 Alexey Dobriyan 2015-06-25  2130  	prctl_map.env_start	= mm->env_start;
4a00e9df2 Alexey Dobriyan 2015-06-25  2131  	prctl_map.env_end	= mm->env_end;
4a00e9df2 Alexey Dobriyan 2015-06-25  2132  	prctl_map.auxv		= NULL;
4a00e9df2 Alexey Dobriyan 2015-06-25  2133  	prctl_map.auxv_size	= 0;
4a00e9df2 Alexey Dobriyan 2015-06-25  2134  	prctl_map.exe_fd	= -1;
4a00e9df2 Alexey Dobriyan 2015-06-25  2135  
028ee4be3 Cyrill Gorcunov 2012-01-12  2136  	switch (opt) {
028ee4be3 Cyrill Gorcunov 2012-01-12  2137  	case PR_SET_MM_START_CODE:
4a00e9df2 Alexey Dobriyan 2015-06-25  2138  		prctl_map.start_code = addr;
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2139  		break;
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2140  	case PR_SET_MM_END_CODE:
4a00e9df2 Alexey Dobriyan 2015-06-25  2141  		prctl_map.end_code = addr;
028ee4be3 Cyrill Gorcunov 2012-01-12  2142  		break;
028ee4be3 Cyrill Gorcunov 2012-01-12  2143  	case PR_SET_MM_START_DATA:
4a00e9df2 Alexey Dobriyan 2015-06-25  2144  		prctl_map.start_data = addr;
028ee4be3 Cyrill Gorcunov 2012-01-12  2145  		break;
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2146  	case PR_SET_MM_END_DATA:
4a00e9df2 Alexey Dobriyan 2015-06-25  2147  		prctl_map.end_data = addr;
4a00e9df2 Alexey Dobriyan 2015-06-25  2148  		break;
4a00e9df2 Alexey Dobriyan 2015-06-25  2149  	case PR_SET_MM_START_STACK:
4a00e9df2 Alexey Dobriyan 2015-06-25  2150  		prctl_map.start_stack = addr;
028ee4be3 Cyrill Gorcunov 2012-01-12  2151  		break;
028ee4be3 Cyrill Gorcunov 2012-01-12  2152  	case PR_SET_MM_START_BRK:
4a00e9df2 Alexey Dobriyan 2015-06-25  2153  		prctl_map.start_brk = addr;
028ee4be3 Cyrill Gorcunov 2012-01-12  2154  		break;
028ee4be3 Cyrill Gorcunov 2012-01-12  2155  	case PR_SET_MM_BRK:
4a00e9df2 Alexey Dobriyan 2015-06-25  2156  		prctl_map.brk = addr;
4a00e9df2 Alexey Dobriyan 2015-06-25  2157  		break;
4a00e9df2 Alexey Dobriyan 2015-06-25  2158  	case PR_SET_MM_ARG_START:
4a00e9df2 Alexey Dobriyan 2015-06-25  2159  		prctl_map.arg_start = addr;
4a00e9df2 Alexey Dobriyan 2015-06-25  2160  		break;
4a00e9df2 Alexey Dobriyan 2015-06-25  2161  	case PR_SET_MM_ARG_END:
4a00e9df2 Alexey Dobriyan 2015-06-25  2162  		prctl_map.arg_end = addr;
4a00e9df2 Alexey Dobriyan 2015-06-25  2163  		break;
4a00e9df2 Alexey Dobriyan 2015-06-25  2164  	case PR_SET_MM_ENV_START:
4a00e9df2 Alexey Dobriyan 2015-06-25  2165  		prctl_map.env_start = addr;
4a00e9df2 Alexey Dobriyan 2015-06-25  2166  		break;
4a00e9df2 Alexey Dobriyan 2015-06-25  2167  	case PR_SET_MM_ENV_END:
4a00e9df2 Alexey Dobriyan 2015-06-25  2168  		prctl_map.env_end = addr;
4a00e9df2 Alexey Dobriyan 2015-06-25  2169  		break;
4a00e9df2 Alexey Dobriyan 2015-06-25  2170  	default:
028ee4be3 Cyrill Gorcunov 2012-01-12  2171  		goto out;
4a00e9df2 Alexey Dobriyan 2015-06-25  2172  	}
028ee4be3 Cyrill Gorcunov 2012-01-12  2173  
4a00e9df2 Alexey Dobriyan 2015-06-25 @2174  	error = validate_prctl_map(&prctl_map);
4a00e9df2 Alexey Dobriyan 2015-06-25  2175  	if (error)
028ee4be3 Cyrill Gorcunov 2012-01-12  2176  		goto out;
028ee4be3 Cyrill Gorcunov 2012-01-12  2177  
4a00e9df2 Alexey Dobriyan 2015-06-25  2178  	switch (opt) {
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2179  	/*
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2180  	 * If command line arguments and environment
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2181  	 * are placed somewhere else on stack, we can
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2182  	 * set them up here, ARG_START/END to setup
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2183  	 * command line argumets and ENV_START/END
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2184  	 * for environment.
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2185  	 */
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2186  	case PR_SET_MM_START_STACK:
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2187  	case PR_SET_MM_ARG_START:
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2188  	case PR_SET_MM_ARG_END:
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2189  	case PR_SET_MM_ENV_START:
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2190  	case PR_SET_MM_ENV_END:
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2191  		if (!vma) {
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2192  			error = -EFAULT;
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2193  			goto out;
fe8c7f5cb Cyrill Gorcunov 2012-05-31  2194  		}
028ee4be3 Cyrill Gorcunov 2012-01-12  2195  	}
028ee4be3 Cyrill Gorcunov 2012-01-12  2196  
4a00e9df2 Alexey Dobriyan 2015-06-25  2197  	mm->start_code	= prctl_map.start_code;
4a00e9df2 Alexey Dobriyan 2015-06-25  2198  	mm->end_code	= prctl_map.end_code;
4a00e9df2 Alexey Dobriyan 2015-06-25  2199  	mm->start_data	= prctl_map.start_data;
4a00e9df2 Alexey Dobriyan 2015-06-25  2200  	mm->end_data	= prctl_map.end_data;
4a00e9df2 Alexey Dobriyan 2015-06-25  2201  	mm->start_brk	= prctl_map.start_brk;
4a00e9df2 Alexey Dobriyan 2015-06-25  2202  	mm->brk		= prctl_map.brk;
4a00e9df2 Alexey Dobriyan 2015-06-25  2203  	mm->start_stack	= prctl_map.start_stack;
4a00e9df2 Alexey Dobriyan 2015-06-25  2204  	mm->arg_start	= prctl_map.arg_start;
4a00e9df2 Alexey Dobriyan 2015-06-25  2205  	mm->arg_end	= prctl_map.arg_end;
4a00e9df2 Alexey Dobriyan 2015-06-25  2206  	mm->env_start	= prctl_map.env_start;
4a00e9df2 Alexey Dobriyan 2015-06-25  2207  	mm->env_end	= prctl_map.env_end;
4a00e9df2 Alexey Dobriyan 2015-06-25  2208  
028ee4be3 Cyrill Gorcunov 2012-01-12  2209  	error = 0;
028ee4be3 Cyrill Gorcunov 2012-01-12  2210  out:
ddf1d398e Mateusz Guzik   2016-01-20  2211  	up_write(&mm->mmap_sem);
028ee4be3 Cyrill Gorcunov 2012-01-12  2212  	return error;
028ee4be3 Cyrill Gorcunov 2012-01-12  2213  }
300f786b2 Cyrill Gorcunov 2012-06-07  2214  

:::::: The code at line 2108 was first introduced by commit
:::::: 6e399cd144d8500ffb5d40fa6848890e2580a80a prctl: avoid using mmap_sem for exe_file serialization

:::::: TO: Davidlohr Bueso <dave@stgolabs.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AZnWFA+/x/3FzroKaQIftTuLT/8fk+z3zeZXAAA=

--mP3DRpeJDSE+ciuQ--
