Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeDCAqH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 20:46:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:59150 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeDCAqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 20:46:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,398,1517904000";
   d="gz'50?scan'50,208,50";a="42887561"
Date: Tue, 3 Apr 2018 08:46:01 +0800
From: kbuild test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: kbuild-all@01.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7] fs: Add VirtualBox guest shared folder (vboxsf)
 support
Message-ID: <201804030824.1b93W1vu%fengguang.wu@intel.com>
References: <20180329163745.1214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20180329163745.1214-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/fs-Add-VirtualBox-guest-shared-folder-vboxsf-support/20180331-001843
config: x86_64-randconfig-g0-04030108 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   fs//vboxsf/file.c: In function 'sf_readpage':
>> fs//vboxsf/file.c:236:2: error: implicit declaration of function 'page_offset' [-Werror=implicit-function-declaration]
     loff_t off = page_offset(page);
     ^
>> fs//vboxsf/file.c:241:2: error: implicit declaration of function 'kmap' [-Werror=implicit-function-declaration]
     buf = kmap(page);
     ^
>> fs//vboxsf/file.c:241:6: warning: assignment makes pointer from integer without a cast
     buf = kmap(page);
         ^
>> fs//vboxsf/file.c:246:3: error: implicit declaration of function 'flush_dcache_page' [-Werror=implicit-function-declaration]
      flush_dcache_page(page);
      ^
>> fs//vboxsf/file.c:247:3: error: implicit declaration of function 'SetPageUptodate' [-Werror=implicit-function-declaration]
      SetPageUptodate(page);
      ^
>> fs//vboxsf/file.c:249:3: error: implicit declaration of function 'SetPageError' [-Werror=implicit-function-declaration]
      SetPageError(page);
      ^
>> fs//vboxsf/file.c:252:2: error: implicit declaration of function 'kunmap' [-Werror=implicit-function-declaration]
     kunmap(page);
     ^
>> fs//vboxsf/file.c:253:2: error: implicit declaration of function 'unlock_page' [-Werror=implicit-function-declaration]
     unlock_page(page);
     ^
   fs//vboxsf/file.c: In function 'sf_writepage':
   fs//vboxsf/file.c:272:6: warning: assignment makes pointer from integer without a cast
     buf = kmap(page);
         ^
>> fs//vboxsf/file.c:277:3: error: implicit declaration of function 'ClearPageError' [-Werror=implicit-function-declaration]
      ClearPageError(page);
      ^
>> fs//vboxsf/file.c:281:3: error: implicit declaration of function 'ClearPageUptodate' [-Werror=implicit-function-declaration]
      ClearPageUptodate(page);
      ^
   fs//vboxsf/file.c: In function 'sf_write_end':
   fs//vboxsf/file.c:300:6: warning: assignment makes pointer from integer without a cast
     buf = kmap(page);
         ^
>> fs//vboxsf/file.c:311:2: error: implicit declaration of function 'PageUptodate' [-Werror=implicit-function-declaration]
     if (!PageUptodate(page) && nwritten == PAGE_SIZE)
     ^
>> fs//vboxsf/file.c:320:2: error: implicit declaration of function 'put_page' [-Werror=implicit-function-declaration]
     put_page(page);
     ^
   fs//vboxsf/file.c: At top level:
>> fs//vboxsf/file.c:328:20: error: '__set_page_dirty_nobuffers' undeclared here (not in a function)
     .set_page_dirty = __set_page_dirty_nobuffers,
                       ^
   cc1: some warnings being treated as errors

vim +/page_offset +236 fs//vboxsf/file.c

   231	
   232	static int sf_readpage(struct file *file, struct page *page)
   233	{
   234		struct sf_glob_info *sf_g = GET_GLOB_INFO(file_inode(file)->i_sb);
   235		struct sf_reg_info *sf_r = file->private_data;
 > 236		loff_t off = page_offset(page);
   237		u32 nread = PAGE_SIZE;
   238		u8 *buf;
   239		int err;
   240	
 > 241		buf = kmap(page);
   242	
   243		err = vboxsf_read(sf_g->root, sf_r->handle, off, &nread, buf, false);
   244		if (err == 0) {
   245			memset(&buf[nread], 0, PAGE_SIZE - nread);
 > 246			flush_dcache_page(page);
 > 247			SetPageUptodate(page);
   248		} else {
 > 249			SetPageError(page);
   250		}
   251	
 > 252		kunmap(page);
 > 253		unlock_page(page);
   254		return err;
   255	}
   256	
   257	static int sf_writepage(struct page *page, struct writeback_control *wbc)
   258	{
   259		struct inode *inode = page->mapping->host;
   260		struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
   261		struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
   262		struct sf_reg_info *sf_r = sf_i->file->private_data;
   263		loff_t off = page_offset(page);
   264		loff_t size = i_size_read(inode);
   265		u32 nwrite = PAGE_SIZE;
   266		u8 *buf;
   267		int err;
   268	
   269		if (off + PAGE_SIZE > size)
   270			nwrite = size & ~PAGE_MASK;
   271	
 > 272		buf = kmap(page);
   273		err = vboxsf_write(sf_g->root, sf_r->handle, off, &nwrite, buf, false);
   274		kunmap(page);
   275	
   276		if (err == 0) {
 > 277			ClearPageError(page);
   278			/* mtime changed */
   279			sf_i->force_restat = 1;
   280		} else {
 > 281			ClearPageUptodate(page);
   282		}
   283	
   284		unlock_page(page);
   285		return err;
   286	}
   287	
   288	int sf_write_end(struct file *file, struct address_space *mapping, loff_t pos,
   289			 unsigned int len, unsigned int copied, struct page *page,
   290			 void *fsdata)
   291	{
   292		struct inode *inode = mapping->host;
   293		struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
   294		struct sf_reg_info *sf_r = file->private_data;
   295		unsigned int from = pos & ~PAGE_MASK;
   296		u32 nwritten = len;
   297		u8 *buf;
   298		int err;
   299	
 > 300		buf = kmap(page);
   301		err = vboxsf_write(sf_g->root, sf_r->handle, pos, &nwritten,
   302				   buf + from, false);
   303		kunmap(page);
   304	
   305		if (err)
   306			goto out;
   307	
   308		/* mtime changed */
   309		GET_INODE_INFO(inode)->force_restat = 1;
   310	
 > 311		if (!PageUptodate(page) && nwritten == PAGE_SIZE)
   312			SetPageUptodate(page);
   313	
   314		pos += nwritten;
   315		if (pos > inode->i_size)
   316			i_size_write(inode, pos);
   317	
   318	out:
   319		unlock_page(page);
 > 320		put_page(page);
   321	
   322		return err;
   323	}
   324	
   325	const struct address_space_operations vboxsf_reg_aops = {
   326		.readpage = sf_readpage,
   327		.writepage = sf_writepage,
 > 328		.set_page_dirty = __set_page_dirty_nobuffers,
   329		.write_begin = simple_write_begin,
   330		.write_end = sf_write_end,
   331	};
   332	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICPzKwloAAy5jb25maWcAlDzZcty2su/5iinn5ZyHJJKsTHzrlh5AEpxBhlsAcKTRC0uR
x4kqluSr5ST5+9vd4AKATfkkVbFNdGPvvRvz7TffrsTry+P9zcvd7c3nz3+vfjs+HJ9uXo4f
V5/uPh//d5XVq6q2K5kp+z0gF3cPr3/98NeHdbc+X51/f7r+/uS7p9ufVrvj08Px8yp9fPh0
99srDHD3+PDNt9+kdZWrDeAmyl78PXxeUffge/pQlbG6Ta2qqy6TaZ1JPQHr1jat7fJal8Je
vDt+/rQ+/w5W8936/N2AI3S6hZ65+7x4d/N0+zuu+IdbWtxzv/ru4/GTaxl7FnW6y2TTmbZp
au0t2FiR7qwWqZzDyrKdPmjushRNp6usg02brlTVxdmHtxDE1cX7Mx4hrctG2GmghXECNBju
dD3gVVJmXVaKDlFhG1ZOiyWY2RC4kNXGbifYRlZSq7RTRiB8DkjaDdvYaVkIq/aya2pVWanN
HG17KdVma+NjE4duK7Bj2uVZOkH1pZFld5VuNyLLOlFsaq3stpyPm4pCJRr2CNdfiEM0/laY
Lm1aWuAVBxPpVnaFquCS1bV3TrQoI23bdI3UNIbQUkQHOYBkmcBXrrSxXbptq90CXiM2kkdz
K1KJ1JUgNmhqY1RSyAjFtKaRcPsL4EtR2W7bwixNCfe8hTVzGHR4oiBMWyQTynUNJwF3//7M
69aCHKDOs7UQW5iubqwq4fgyYGQ4S1VtljAzieSCxyAK4LxYPHSmbJa6to2uE+lRVq6uOil0
cYDvrpQebTQbK+BsgMD3sjAX50M7/OXkTO1TqNK/dJe19i4jaVWRwZZkJ6/cSCZgf7sFUsDN
5jX80VlhsDOIvm9XGxKln1fPx5fXL5MwhEOxnaz2sCcQOXBY1mP/VMNlEj8ruNB372CYccHU
1llp7OruefXw+IIje7JLFHtgNyAY7Mc0w+3ZOiLrHRCZLLrNtWp4SAKQMx5UXPuCwYdcXS/1
WJi/uEZ1MO7VW5W/1RhOa3sLAVf4FvzqmjnJYK3zEc+ZLqBtRFsAt9XGVqKEi/vXw+PD8d/e
9ZmD2asmZToD+wL1lr+0svUY1G/FzqktJqCjEqDzWh86YUE7bf21tkaCIGSmIvaNboA4iwA4
C7BixO18K8gOGwgBarRayoH6gZVWz6+/Pv/9/HK8n6h/VCzAacTFjM4BkNnWlzxE5rlMScGI
PAelYXZzPBSLIHkQnx+kVBtNspUHp1ufHbAlq0uhqrDNqJJDAtENAhVO9bAwt7AarpaEngDx
w2NpaaTeO/lfghEUzgQGUAoi1gmfQMaaRmgjl3dOUjf3RF6KVo+pWxjQXWpWxyLbR8mEFXzn
PWjfDJVvIVCnHdKCuVuSpPsZTY0aHMcDSV1ZxmzwgF2ia5GlMNHbaGAzdSL7uWXxyho1SeZs
IqJZe3d/fHrmyNaqdNeBQgS69Iaq6m57jZK5JEoaGRAaQc2rOlMpK35cP5UVkmFSB8xbOp+o
C7Yi5SyPykK2YG4hRdHxa+Pj0L7BHvnB3jz/sXqBA1jdPHxcPb/cvDyvbm5vH18fXu4efptO
Yq+0dTZQmtZtZQPqY4B43iHxEg0EvceFJiZDqZBKEG+AYdndoI5FU9Ywh4dzK1MXA3PT9nTa
rgxzpyCtOoB5lmYK9tsVXJ1v+wcY1KdvCheEnZkF4ZCwWLi2kUw8iDPB5SZNCuXTKPxlwd7o
0OfYRWcUw5wwWJg6FxX4TBfr83kjmEQi91wFBwHWJTqK1lmnCZ5tZBeBx1GdeZab2vVO16yF
bnVqLmocIQcxr3J7cXbit+MVghPjwU9H86jR4FPsOiNyGY1x+j7Qai1Yd85aA6M+czJhyZqs
WnCAElGIKp2bq2QjJygXYZi2QjcKrOQuL1qzaAPDGk/PPni3udF123gSjWx/on/fuQV9nm7i
Xm4D/v3nQunOg7E8Amy4gBKO3qjMBMTlmnW2YDj18BzY4FpqngHBVfL3CheP0/QQZrJM7lVI
wDEGdF2UBsNGpM6Xt5k0+exgSRN6fA4UMoKckpskK9h0oFhBLLFLcDSG1jV153EOJkefp9ES
tD57JTp0WpNih0dD/oLO/AAJfIsSRnOK17P2dTZY8hMhZHMzeQL1JryPzdrEhFpHmLwtnKaj
D4iSiS4GwzVVKoO7j9DQ5WZGiy1fkFwVnAAYRB6JOY5X2akXRnIdQZqnsiEjisI3UZ8mNc0O
lgjqAtfonb1PL7FGiGYqwfJXQNoeJxtwpdEy7WaGjiODqdmnD1xvD2FOIt+KKitmHoLT6D67
oYSMv7uqVL7s9uheFjmIIj82MD+VST8LsC3RCOEW2IJa8lxy/ATG92Zq6uAo1KYSRe5RNu3F
byArzm8wW+fcjwsSqmbZTWR7ZeRwnJylAAMlQmvl3xvwcbqjuBVaSzY4lR2OcyjNvKULbnhq
TcAOgUNADghU54hBpznEywLi4ygESYzczJwTHmMYa9oXDFKl0d1SdCqTWcwIMHQX291Nenpy
PthQfYC3OT59eny6v3m4Pa7kf44PYCQKMBdTNBPBdJ6Mq3DEcRN90AeBsJ9uX5IbxF7hvnT9
B0XJmnt94JMiNhMvFSLhhXDRcm6xKeok7g/nqDdy8OyXRLqVJSmLbg/mfq5SMjs5H1/XuSoC
6yLVwmyj29nJKxnfWO36yov7aeahrT8gkkBNIa+Ymel6xzFmo6JgcHznrSKOrv3clg14dYn0
uRcMcHCidvIA4gxkCIal/OHtOMhEwK6J91BwmZQmAG4CwYD6NEU3YGlLMofjVrj7tgp7RFYZ
khkaq+BqgHtxKTzHfqeljfdKgyu4AbT0ABiHS2aH41qXRvIPghkGXMou5zRT3lYuBSK1Bu2o
qp9lGsYrCC0Q61M4h0bc1vUuAmKkH90HtWnrlvGwDdwzeqV9YCE6SZQuoBCsyg+D6TFHABOv
D0yxC3PRUhd57S63ysrQ8RltbrCVDmB2YciAFCn1iIbUcgNitspcfqa//k408ZmkBXcQgBfb
gATbXoI8kcLpgQhWqiugswlsaA2xJQKCGtptqytwnOC4Ah0Ty1vmDrdCZ+iwkJFqJcaoqQc3
CDP/IF11fy5ZW8bBXTpmjq3duYLH57yn3AX0wkt2dOecsLRsMDETH7hrddHnBVhWtws5i16o
qwb8BgpmDWFtBrcuMg+f26WRKSJ0IO3s7B42YIY2RbtRlc8NQeMooqZmDG7RrCBylT0wIsrD
NWD51vuFgUD1owiD/3XdHFjJ6A9FTABu++5rmBq4wmEvyU/AJepAEUcUFhnnIRDouOLM8zki
0GNbiK+MBkurqw3vzs2Q0a9iprZbjO3BDYPtFHOAow9FKI4Hco0uXEyK8yiLD/5qMMvpCjai
xYnkCmOzsk/KYQjgv8XrmjY22BwrYnIPTCiWu02d2y6DLcSCuKyzHqORKRotnitTZ20BWgl1
JvoFaJsy20WqR81FQXA8XkYPUHegwrqc51LnSfAIgSZgdVDYa8qrM+N6SfGlQXwUZqgeTOho
q8/ppzkMKs0WMdQRXh8Vn6tuOFvlIlRjcYHPNN4tg53Isgrm5pOWFB7DHygZwcXqk8TvPcPT
7aqHi8GsmDiwwXifZ2Dl+aIVRgvc97UFaWCET628g4Y9a3LNRTFk1/Tl1T9C5szzmUFiwbKx
Xiffhl0Exd0dZ7DdOdDYvdmCfWzrsIZihGqsUml9K2NoGeL/LpEMCuS7X2+ejx9Xfzg37MvT
46e7z0FcHpH6rTAzEXSw+SPHMoax+gxQXNUNyWNnlswG6THed+cLCmrCOe9+WnYEBnvU2atb
idKQi0qh6wMS3GdM8qkNupUXp5FYi+WcC5yDkSKC+GoPbCsEsGsEjN4k4Z2ZfgSj0zHzvpCy
GTAVrwx7MHKs5n2hQWJTXqIAi78Non8JmpGcPyrCPJ4w1akX4KqodgPW1YACxYNYDp4LW6OR
rksvXUuX4jrD3uvLyre7XDXPAhBnWoKN3hzlxDNCo/TjhLIMiTvrS77rrH0SBEMwpUtkjn+h
hd1nZqfY/DwuThzcPD3eHp+fH59WL39/cRm2T8ebl9enoxcyGQpuPAnjG+5YFpNLAW6FdAHp
CISpmwGO3nhgvCLG1RloCq4CAYFlQ7Z2wNKgInIVKp9RTNmmRhLx8bHcC8RoxrEqTgGmFmgi
LIFiIouIsIf9snyAQG41AYKbvlRcdGyCF42ZHYwopzUx2Yhhe7XJuzLxnLWhZXQjo4wAcIZ1
ludQDMfp0QP4a3tlwNLdtEEQBS5EoA3qDzy0uSnZsxhRRjbgj0xygardvhyXMdW+7Ms+cJfz
Y41TRoYwK3l61CElNw7ys1DFtkYepQXwmfGkrm0UAi53H3jh2Rg+sFgiF/N1QyWKM07/DTUD
fhx3ICqN6Yi+fNAlI9c+SnG6DLMmqnvrveOoOhZrFfZhS6kqVbYlWWu5KFVx8JK8iEAXBt5i
aQJnrM+uoxMmC8n6hzgkyHfHMJ7d2DcDt8wbU9DQovXd60baMbA4hX9LxVsGAihC1WXZsuBU
FIBxmGMM7Hap6qB2kRC7rSyacP5SXEUyZiAtKso06LJsUMJvsGqXB4IMu/jxdAbsTVHvFnqI
1+LEgin98gJqKtN5C6Zu6vDqpCwbu+SLD+B9XQD3CQrAxX3f6BYZokS5GL5B9yIiUlUzjVrq
GrMdmMxLdL2TFTErOokzgVuGAtapSC+zcP/4cPfy+BTYt37IzInytqJI+f0yhhaNR8BzeDpU
RE/n5OGQWqgvQ6nt+Tcf1gua5nQ9K3eXpsnVVczWQyFUJ8u2iJxE9WE3bQ1MLODbyNgYG91u
eIE24sBuOPtxhKM/SNIsD6LRdF2hCCGB1LSKN44R+iNV2y55ZeQTiSzTnY1fBrjafQzOsmCS
a0qD2Oo2CUZGOEMN1APwaKoPTaDE8DY9EF9B1YZlD4HFS/aRG0EwxdgjeBAEEZyk7VCziXZj
7KZRocSOLEyMSnmUUBRyA4zY2xAYUmjlxclfH483H0+8/0YB8tZU0zpLUbWCg8TxIjcOeiDS
lxDegVyB+1FKDrSHPzAQEJ/ZhEEJwM4tqAFXeSPtNsilx2PNl5eEDkrQ3JFynncbNPqmjavM
MwU8qTNm4P4k/Pqy0G/trRNXDY4T8zzphtnWFqO1nDprCjAcG0vrJxVyHqzQHeaAhlLKsgtN
8Gx9mdI3uBBQlE/i2pgy2TeY11mANcakpsad8ehpqJMmknC1mZm+OD/5n7VXTMcEQJd40iWK
7Lbp+sTeZDEUUlRkdnEGju9jwcfcfh8b2dAXQvEFiLn4yTvxMOI6DnXd1DUvm6+TlhPJ18Yl
xT3F1r9hgFNrgvDygErZ2Kl5oG16ETEkM4NbkFrLMQ1HIWasKvJEDiYBqX0eGx8FrfNXyV2a
oM7d2c9SCq4Ioluq29xgkRaI5m0pwlw+KRssy+gScLfQAddts5Bld2YI1k1jLOQSDa+J6azm
9Thtx0WqF/UZHDNnNE5eZVuGVVeeP9rwIU0PY5CvlPDAaBEm1ZnpZO4X0+QKDrNNwhbKTwaO
qMt+8aG26+705GQJdPbjCbMGALw/OQkEH43C414AbuwUbzXWUrPvLq6kZ1O6WoiwasG1Ua3F
AYNmHhdTNUWY6URRpdCCBaIDL/rkr9NQT2pJFfihYhpzFhRJDE0PqtalXoaZhaoQYJYzN8lU
KTeO6G6aOymnCnr3coregTpBf7n0EbiTds65jzQL9+8z4729QYMiPcT2Z2Bdxiix1+HJyoyC
hUkk5wbGqzO8rSKz82o4UpqF2oOQt7MnZShi8MEfZ+f1GjDUpEO4vHn88/i0Ak/i5rfj/fHh
hcJtIm3U6vELvkt9djXvPVG6/AjnGPmvyMq5joA2ke2xrjF7IxqTAdrwrIKdJKxOuPzFuRxe
+mVuT6Z+hQN+DZdFtGymOLB/ZCU+ueyzNtil8Z9YUktfz+TmJ8/IeM9dJ4GZDoUTGzag5cZq
Ut1FrOVW2qhoK2T45sbNG4G03Hc18LtWmeTeOSIOSITpUUu4SsFFOwmSCAum9CEaKmmtBWPn
Pmjcw9x11JaLKuqahTFybKLQjJZwo0FR0rBlF4VJo0e5EVhls/2mTZMC0yRLfaJ21ZQqWn0o
bviJxWajgajsbDy0zsHq8MvR3LJaY2tgE8PGfyeOpjGIe9sGrMss3l4MY+iO1+O0/lRhNR+7
AlpkXVmhqhmdDSei6jCw4Wg5MfEBgpINW/rdl+C81FlMVRuGgcD+alFyYK3PJRiTXV0VrGoY
GVY0clbsNbT3RUQR9QOAUxaNzXtmu/elmcKKbLhz3rYajg/+nRu/o23M+sP5TydfHQE1KIi7
qNjQkFEzvEJa5U/H/3s9Ptz+vXq+vQkTnAM7hcFHYrBNvcdnkBjTtAvg+SOtEYwcyGu2AWPw
W3Agr579H3TC4zZwZf99F0wv0ZuDhQjtrENdZWDnVxm7Rx8RYP3bwn+yHrLeWqs4HR+cdFjw
z2IMpzExUQAft74Af3Onb+2Qwx335ZPhp5gMVx+f7v4TFDgDmjsjG6yyb6N8EvhG82xBAeog
jjoSa6Tp0H+BeQalQkxwvwSBv5NwVjruqr7sdh+ibmXWc4CsjILDUuC6BhhgG8kMrAIX4Neq
qn3Wp8HPXSYHzLxZSPf595un40fO6grHjh4rj7egPn4+hvwfqsOhhe6xAFsxqOX3gaWsAsua
1BGa82bCS+u2KdiHOe7a+rlpdcnr87Ct1b9A6ayOL7ff/9sLVqeeqEal5KKWgfkIrWXpPjjD
EDvRe2IT90qr5OykwFS20mxyH+xGNNpcHMbvKsVCMJtgpuFSXwgCuR28D8EWW4Y7pEqkMC4U
7tVwygghtI/ZLmea3oNp95MRgxsQ/q4B2QDoGd/7LSJ82aCo1KCQ9GML2BYClZ9uw4ZGRxfa
CKOyaMS+lHZyjXurAglkRt83H4+Y6gDYcXX7+PDy9Pj5s3t8/OXL49NLQEuYXcxkIFD9Vvrd
gYE0s+Pz3W8Pl8B5OPYqfYR/mHFM5yBB+++Pzy/evJ58G1Hkw8cvj3cPLz7j4j7BXaJQ9DyF
A52e/7x7uf2dHzkYxVxi2g4cIyv5NG1f3sbxo/tRmrDSG4VZlYRUhHFcdmwNXbOFp0Mkmw4m
n8sk+dfx9vXl5tfPR/pxpBXlq16eVz+s5P3r55tByvXjJKrKS4uFkDNnnAPBR//wY9JpmAvA
mMaoiLGqcivh1tnXMP2wJtUqzH04Y7FuObu471QqPxWNM4fBFCXen7FpKmzHoWPFcPWee3PY
H4D/mzKuaXZGmEds1+curFLKODeJLyORBmr/XW0lRzaoji9/Pj79gap70j8DYYh0J4MFuxaQ
0oITOW2lvNo+/CLMwApm35hd5f6jQvyiny8KVD82osHD0yJCTZt0WG2Tcv4BYbg4vZyNS490
jFUptzg4LIw0BqeHDd5oo/4L3+2qxj05wt9f4Fm3mUIjlBXm4gSA1FQ+hdF3l23TJpoMmykW
tjQZImiheThuSzULvyTjgBvkMyBu7gGVw+hsW1UyerGJiZR6pxaeNLmOe8tXPCC0zYZxF1Hy
mq+I6GHTyvg14M11YqF8GGHSLByqW/1i7JjgRGPzDfgo47HN+mFesk/2BD+oFGO8PUAiZdyX
WDNssmkzNIc7wBuImT7E0OLyKxgIBerBNw38Cw6cHf65GXmCOawRJ20TPwAxCP4BfvHu9vXX
u9t34ehl9qNhrUigv3XITPt1z5GY0M0XGAqQ3ONslB1dtlAGi7tfv0Vd6zfJa/0mfeEaStWs
3+i+QH4R1pv0uf46La6/QozrOTVy6yQ4nXz/7H32VDTceyQ3fJBRdnan0NatNeu8ILjCpDZl
pO2hkbPebx0iwpek0AD86gDDC9U+Qv0GIh3RMtzIzborLr82H6FtS7Hw8zvS4o+8YXIM040L
Qr+xwHKFMEbloZKkvs32QKEsULFlE/1CC+C412ZL+ipL00VdZtIFPacz/tws/7NiAhw0P0Zr
MdOguDQmgor/J+xZttvGkf0Vre7pXuS2SD1MLXoBkZSEiC8TlERnw+PEmonP2HGO7cxN//2t
AkARAAvWIt1WVREAQaBQb7AidcnzqqSLgCByXYfLiA7zz8KG6kY0xmG/rnliJkCp3x3fgrAr
irKsxmlUktcK5kw0guj4LHilLpqGAWVOSdK4SA3DjfqtOaPhJsti60doWH0blu3NGUOBlFWw
xhFBC3PhghhKxipba9mVMBSygWVWnirmYRppmuLbLuhvgm/nrxaTxFRafFJghooosX6g8aXg
6zOM3Diabz9A+z+PlK5hUGXWlzQwCSPVlIGgiD1P5l6B1Gx+HNZxISurtDgqrZQYwhFLxKR2
XH0P88sIx1ya94856Lw9NU3IazgSPqaBz5jxYu9TVPIqs7UhCem2wvBfSQgudNxhz/YKKchg
/52oXUI1R7DkvYstm2FtPpQzPqIqYtIqVJtKXb2RtcDMc7etqKJFkmnXnEoWNSgUS0/saaqx
3JS46+wKJetbS+DHuhyfObk4sWJHU6csVxnLtd36BvatrvRpa6eT9/Obrq5mTUu1b7Ypvc93
LK+Zz3QRM8rxsjYY3RqLZaSJFZoDsHqD/hF668ATRUoxdMDseFJZbABA9MpdY70xP8ZztgGu
Ly5BD2Dw/Cq77NOv8/vLy/v3ycP5v4/fzpTxCccY8wOrPaxCoo+7mFqYgMzro+383MDqqSta
0gDkPqasqp7VsuHrrrZz1U68TrPUTlqJN1vk9QF9/PL1CKnev3/qx/n88DZ5f5l8PU/OP9Ce
9YC2rAnIS5JgsJT0ELQkyERUWZlNlkeeDgPEktPP1k8dkSLDgIfM2nqz51k2kKrf8uubb6fB
vKhIg5VGbytucDXcNavK3narSvNUV2RYVV7rcsz4xppp+P0hMTao/Dz2MwdBl6CJ02rnOjyG
wW3IArGCYakB9y34ht5PlHTcn+hYmBODIoeJAsYIY8rccwNeCQ+aAYjVuTE3Z4RQCduaNw5G
aLn7EtuoLAsiP37T4Ek59gsdVEEblbhBym3HJq/M8qU9BBQsK38BFmyRsKy0U9RA55UdbHit
jmVZxpDoaHOSeaHm3sQoZ3Z50qi6dqFVRTcuWScfobsNy7K1kzKNTo2TFCR7+ystrcm9ldT8
6JkjiU6PtV1+R8GRlepnQbjLS9JBKomYzHjUpKpUr8H2xJ0wUtfIcRpJUzpMlIz8NKjQkeMp
Cozo4yHDWuVrnvGGmzyyTrdWhKv63XGzNqWG5Tkvx4RmtVwNE7CeEmS+xlrLmaqjnmDhyY35
kRG1kb6YUSa/TGK28wouPkR1ShmmacFxq2OchOO9g/8VMqiWEvsaQ5yBHzr90/haCIRhy4Qc
OHM80iVS9dF8IyqDptwotCFUNlhT4uYCVu6g+9f3R9zik5/3r28GHzjAj0n+8vDr6azKhzWv
9z/elANlkt3/Y/nZZYeWlR8h2BFHCwqmSkk5s2c9Ncv/qsv8r83T/dv3ybfvjz/Hvnv5omY0
LQI+p6AF9uvcgMMKvFSqtqdqw6VGoQoT+CZLFY8Amf3Ek2bXBXanDjb8EDt3R+DgPXmQxCBo
sxpBSTpx+pfnzstIWEhNE6e10gs6+qgX9L5jQswzMf05HGmeJH1NAgcBldPTo3Xkh7lPWD7a
OmRSqFz0a50UI9defv/zpxEsIoUquQLvv2H6t3nSyf5VCaE+rt+3gjDCOLfTGwyw9pd9/Cxs
WfedBoysr8RgHjzpKjbxNsXUU9905MnNsoXpcnvj8a71z2Iq1qF6yJydfTSdtyOwiNchaFQg
i9pwkFrez09uv9l8Pt1Sbh05KBnXccTqRvVodjOGVVZHXFucn/71Cb3b948/QGwG0rGqYTaT
x4tFYI9UwbAK58b0KxqoUayxfPHMGY/1fXDV2ryjSVwYRpI3ZYMR8SjBy7wbGwunq9DXnwRh
pGW5x7f/fCp/fIpxIY8EO6PHpIy3M0PVlBV0CpAk8r+D+Rja/D23X7BgZBy2PACKFLH2PGpg
nw9wqrnptDQptBDhLo4eXZL2SpMibPEI2KoJlbOSVUlST/5H/T+cVKDlPZ+fX17/oVROuRLl
A3Q3ouLUGsybKPj9GzHejamflKL5XFq08UITSuGsNCfFv4Z5tMAybMmU8WykrpDgeYfDmtuf
BwDdKZP1kcSuzBJ3vUmCdbrWlpFwar8ZYrGmBZ1601Nss0Nqdlxa2huwq0PBG4/5ALD7cv15
WDIAwAgmq4YkwCzpsNx0jjccIBiinjHKPe+G3quadraXyQcAYjtGQUFBieCM0u6Gx0BL2dip
4wNKHOTVBOSK6sm2nsoJPZ61UXSzooWIngb4B1UeWrn8B+pC6+JdDtOOmR4jjlu9vry/fHt5
MgM4ikonQShr2jFP3Rin/PHtGyFepwVoKwKWnJhlx2mYWJacZBEu2i6pStoyBApZfoergTbA
r3NQmcgIuh0rGvMYE1uMMIvnA6Thm7yzs9kl6KZtjcODx2I1C8V8GphTCFpHVgqs+oIxr66W
NRgOQc3JPMWSq0SsomnIyCAWLrJwNZ0aFcQUJJwab6TntQHMYmHlh/Wo9S64uaGSl3oCOYrV
1DgRd3m8nC0Mp0sigmVkCZjauq4TW8m3O4i1tld3G8FW84gchHVWmlFuUpkyM/FF3IGSY1i8
4tBNkVEQWDDQKqu7MLBz6VQwWVqhQDQK91PwjjWhUSxAA1Waz9CzBuesXUY3ixF8NYvb5QgK
cn0XrXZVKoypjtc3wbQbBaBJqNf8NWBh5YtDrvSgflc259/3bxP+4+399dezrBSt44HfUdvD
l548gQw1eYCd+vgT/zSPzAYl9w9WC+5gqeAPHjn0uDKU9yvDxtjnWJple3oQ/DP3/wBvWsoq
Ynhy+nfkP0DmnOQ8Bkng9fwk7018sxnRQIIKvxKczMvAVNGiWOv7SsaM+YakRoQk1Br2saxs
umFflJUbPOmMZocBoJcHHWR8//rgIOWgqAH1gzGefvl5qXcl3mFSQDG6JOP9EZci/5OQINHI
Ayjz3dzuQI473Ro8Uv0eajepYsl1GuOBfDeYqNN4Zx2HcZvJ9E7aQgtItjn0lq+yovkpkvns
uCXVgctAtLTV8zpZXDNJhzUgeK9ZjHgEIjGixOKzCPNd2yGR2nlIEmwOwglHUd80TdNJMFvN
J39sHl/PJ/j353g4G16n0lL27EK6cmeLlBeE4+MeoUthBF3kLIaNUmKGr/wolmUMkBiYmmPp
qHVDOcCUiR5PRtvI7bK7dSmvDfMf/iQmvT2wjH/xRHvI8LOU0b41GDqGKdDu4NaHgaeEJ2Ya
ekPlqvSo8oUs2+aPNkSkzJGr4Q/PCzUHelQA745yVuXldJ4RHNOGjhfT3m9f6EOR5Z7jHSRs
ei1hlAqxXCTY+zER23iCc3ScDKMDOhGbFn4cLm3l9fOSfIH/eJEFx1RRTw2DRh7rNzfhgq5r
hgQsB44kWOLRJpFkV9b8i2+esQ9/PBCWRAynU/qry7b9KFivJXEpGYMDZ5AVCLVaOtqahv6S
Eol6q8i8eXdIshP0N5NItSpHQ0seQah5/PoLj3uhEh7Y67fvj+/nb1jTcWwKkjVtCjNUNU9c
9+URJE44vWZxaZW3O4IkmdI1JJq7aleSuZZGeyxhVZNaITMaJOsi4LK80sA2tdlk2gSzwBcq
3T+UsRjtMfbFlCLjcMT7gtEvjzapnanJYthYHge7Evoa8qg1G83ZFzNtwUJZ5yj8jIIg6HyM
qkJ2M/Nsszzp2u3as9I1UntMY8rVaw4LjpWi4VaUFLv1VD4xn6tj+jVxCZYOK8x87CKjYwsQ
4dvHWeD7RPTqNcd2ALmNstLL8+SS+mSegFTAmtGiuh/S3knrOe2FWMc5Ggg94SBFS89R7FuS
Dd+WxczbGD0ZqvYCao2+B8mCmNYLx07C/LrwTal+JmZHfrCmqNkdCvRUF3iJKh0dbpIcr5Os
tx7eZdDUpIVejQ7DcM0RZvz24KZuEW+2SzNhB35oUNfQK/uCpr/cBU0voQF9pG6hM0cG4r81
Lpe1EY/gnSuFxQiUE+ZyrHgUlA6vmqOlWVpkMjpN7CND5XLQ8cPmUzo2ZOgoC2mFQ8Dnd3Po
x+1hwpm8VGxY1Gl4dezpF32B7zDJEtIVlcCyd3Ci5erajasttfZVFiL0WE6PLVmlzGhqZw1o
VwVkzSTzgQM7mWYLA9VXZh3ej24NwUYpIPnT0NLU7253MnNj+dbInIUfgLauLUVQElurEUAe
TsDhwKNMingOGr2oY9HpRwLdnubTK9PMo3DRWivmc37lkZzVx9QuiZ8fc1+Mpdhv6RNQ7O8o
Z7nZEfTCitIaXZ61884T6ylxqKT6sIsPseL0IXpzujJaHtf2KtuLKJp7LlwH1CKAZmnlci++
wKOtmwlNdHpXW4VM8Hcw9cz4JmVZcUUQLRjIhnZxFA2ihRIRzaLwys6EP+uyKM2ceAMbzVZT
m3WG++svXhzhVLPWurrj2xFDxw+We+vlsACN7zzRWa5psXUqt+9APAYGSc7IXYpRaRt+Rey8
zcott46M24zN2pY+/W8zr/h0m3m+NnTWpkXnfY7MqzNHeGAZRjlbY4zZDfDAzhsNfAtPwCnk
SSSq86snCJYqaFI7zM+T4BMFs5XH9ICopqQZUh0Fy9W1QRSpYIJcrnVifbV6OZ1fWf41JijU
ZGOC5XCw26XwJR+/uoxFalb2MRE8Y5Y2KOJVOJ0FV5rjlqYDP1eeUoeAClZX3hgLvtYb+Gft
GrGhVwXAMbwzvqapiVxYU59WPPYVZETaVRB4lAdEzq9xLVHGGC9nVhY2sY0sBW29X5NL2+rV
T3dwKuFW1V2eMvokwOWR0lauGBMzPBa0glN1341BNOnu0FicUEGuPGU/gUV04NRkHuNlk5H5
FUZ7R5uFw8+u3nFP4UTEHrGaJH2HnNHsiX9xgg4UpDstfAvmQjC7JmeKu6KsQP+0xPZT3LXZ
1sf3NklCfyYQsit/vrtYu5VCh3MexK2PLgKXeMehNZhkdnc+T0yVeRL/q8pzT7fzgLT3oa/s
09vjw3mCYf3a/yGpzucHnTyBmD6thz3c/3w/v449JSeHl/XJHd0poaxiSD7Y8XJ1jlC4Zmcf
MLuPCuU1u4VPILEbzc2cKxNlWFcIbK/iEijnSgkXVQvuFNBBby79/Wou8gUVYWI2Ooj2FDIF
ics7pzWz8xws3OVQp5CC0wjzbhcT3njov9wl5pltoqRtMC2kUUCu0NNjztoJ+ueezm9vk/Xr
y/3DV6x7OoTAqKgDme5jLeP3F5i9s24BEYSl/eRzUuUtWkNpJnH4zBtx6DzxKNoAtC6zxu/1
kY47wenzgouE8Fj++Pnr3es4lTlFZiQA/FT5R882bLPB4rIy78rBoI8ME34csCpTv8c4XQeT
s6bmrcZc4t+f8OM84qXZ/7q3QpT0Q+jNJLrp4ZgUdGjdN7lgBahuICu3fwfTcP4xzd3fN8vI
Jvlc3hFdp0cSiJGqz+bc+0JE1QP79G5dstpIWOghwOGMaA4DWi0WUeTFrChMs19bRv0L5rYJ
pmQUkkERBssp0WiiM2/rZbQg0Nke+3wm+sRMNVorNinkwiJ1mAtZE7PlPFiSnQAumgdUHP2F
RC1Eauh5NAtnZLOIms0+brW9mS2or5DHgoJWdRAGBKJIT6r47ngUmJeNpgyak1zItPZxhagp
T+xEBmsONIfC9zFL2MfUqTN8iDzsmvIQ77C2EvmlTtl8OvtwDbaNr3t0rnce5/9AxCpQFWhd
4UK0jj1cdeASH+CBRQi3jrtDIkt9eOpDKQKcJcWFKBuhGodVlkzBoqjKo2nblYWaYgvJkptg
3tJQHS/mDEPKOThncjzekaxzFiymI/43a6ejstH6oIhFta/Hp0EbrVY3qCU1PB5hc9jF415Y
xbDujAPdViEbw1BOTtPKru5rIJMUr/vxlCbRE5Ix0a0bz+2WPRGX+YON5ya1C7eHg7HQlN65
3bfN55X7KhKouWLnXrTYn8UnLEbtKxgjae5S5o16UhRxHkwpA4rCqgut8SLqyydz13Ellosw
iLrqVKul4G1M7/2BkmhNkxz5mnSJXqjQUKOo3Jk7KDHHXY8sy/FGWn/XVbxZTJezWVd57mG7
kEWLG9oRpilOuV6EV4g+fsl6H00XOGBin8u1XJd4zxlGQOOSdkkStpouwgubcLpH7HKmsN4R
nOD4C5DTEGwjabPZnLI+96uKzdD78kyC7dBVheJJChsdE33grzUjNnBSH8MlcD61Ej/anpJy
uaAoCbqeHRnndZ3zeR+Rbtg7AQgjJ5qTKJGvnRY2Ztx4D5EpDKVDGSY6ttelD4IRJHQhM8vi
rmHUMa1Qi7nbwGLRa1K7+9eH/8PqqfyvcoLag5U+UJvZw0Ryh0Mhf3Y8ms5DFwj/tbM+FDhu
ojC+CaYuHNQLJRPY0JhXInShGV8j1GmhZieXUEfPKOLBBKKaFmFOX62tn61j+kFWYe/e55Ss
aw7v4EzaluWyfrG58npYVwiQ+YnGLwSZkVZxAab5IZjuAwKzAVEi6BWY+Pv96/03tNyMMkca
+1anIzUxWBl0BcdAc2eo7fpqDh9Q37sYLpb2PDJ544qqYuApYluUX0qfG6vbClq8k+npnXBO
RI0EBc+5XBUg+zyl0iBfH++fxoFueujy5qnYdOdqRBQupiQQeqpqjFfAe3MviQQEnZNAZKI2
aEOi3sskilV8rGcQ1u3LZq9mQW8TMYoQMHA5qNc5GalkUhW1dD8Zl7yZ2Bpv0s3TCwnZUX+z
Mm3RNAiZLLreHb3+Lms6hceEb07Y6SpJ3YRRRJ2TJlFm3ZFiTSJPvPNbtp5wd0WEdQqIpEWV
M/by4xM2AhC5kqUpbLAXuU3hhGWcFGE1hQ4mHwONFee2+tmzSTVaxHHReszUPUWw5OLGo+tp
Is3lPzdse+27a9JrZC0HkboFLn6VEk6Jj9B1RWsPGg0rEFbGtT5i9GoxvCmJb3lcZp4AZ02N
m/JLMKNK8WkKNI5Zdxga8LipMzwL3IwvAKFJumjIgvy1NG4b7L8as6GqcsoI6Yj4eBzP30tw
Vc5B8CiSzL7kWMLlbaKX+1x9T4NuhvcEHq3y2gZG4J0PWwel3DTGZbHPTt9kTTeFEXzjtNZf
jjVqRSp35YaKp9ud9K1qlrOgB6orZniZe/yMA+Ho3twRhRMcPCCOnNJbTLyuPNWfyEeVYTgI
qbPVkpJQsYYkdyJX85MvhB2v2abGwYqtujXRuW6nifHGHt+8VR6ZAR/ilBKhMagTaH/RM4Xi
ACmcoG4TXxyOJa02I1Vhu8kRJPvykBudGdC4XtuAI7wt7pL2bjxm0cxmXyozAdPF2LWFYBWp
6+yNgqJHW7oHlpndqdS9y5v0MDioxn4M0LLG7ovQvZsKZ6+/c8nYWACVVj68iNZiDWFM1Aux
0XgjVUpV70Rsfmh7YTn/9fT++PPp/BvEZRytrA9BDRkOgbUS+6HtLEuLrRn7pxrty7lZQ1Fw
uix7j8+aeD6bLscNVjFbLeaBD/GbQPAC2fsYAdPrDk1Wi++f8M4l0uRZG1eZp4I20Oh6YFj6
yvOaoFUPuaE40+zp3y+vj+/fn9+cec62pXPzSg+uYoqPDlhmtn9RgTG39M29O2QC4wG4/wIR
q3EeLGYLe0olcDmzl6sEtjOHMk9uFkuHUMI6MY+icITBzA0byCM7W17CBG3nlah8NH8V563H
2oW8S8bpUfqu/HYc9NXVwl0+AF6SLgCNXC1beyacwBINAvY1YhzyokvyY4g45+Znfvvn7f38
PPmKdch0waI/nuGrPv0zOT9/PT9gZMNfmuoTiMtYyehPUzaW7AL5l+vhsjaK4NtCJk7bErKD
7AV19y0NEn8il9sWGdvgEK3ZHejCZvEnJEjz9BjaUy85kzMqyc1UZX5efB7VZbNo92lekTUG
Je+Wbi27Q9iN3umoWua+noWv9zMftxQ8xzwwqyslyPccPf39fn79AcoQoP5Su/xeR7IQMQFy
OKrYh6fHvhRIhiYydws0DD1Zx7FmVr5/VyeKHoKxPu31rDmr/QG1g6wv1W+9rX0rlITgkrIb
kCBdK2HM9bHWgTeoeiBBpnqFxBfMJDwBVKLy2Hp29MVadolk+DkOCVIMvRKTb0+PqkDDWP/F
B+NMXkS7l7KkJ5rqQpXhVQP0gHqSvuDNM4HTcsBlaP/GmqH37y+v45OoqWDgL9/+Q1yZ1VRd
sIgidTVdz/N07IuOFsP4C18x/z4mBlYi7IAHWcQQtoXs7e1/ff10+6NZQ0RLEyYgN0M2kAD+
MuyeutTlgDDMcLhkPhI3NK5jYnYTUqfRhSBPRoPs8rgKZ2IaWfWGNE7AhJD654WgDRZTK6mh
x/w/ZdfS3DiOpP+KTxvdsTPRJPg+zIEiKYljkmITkEz3ReFxqacdUbYrbNds9/76RQIkhUeC
rr2US/kl8UwACSCRKa+cVj4VNzzYl/PsvPIt398Mw/2pru7s+lgPZJZ0ucLPHC+cl4Tzrjt0
TX67VumiKnOIc3lrZ15W3akajBu2GZQvtz5JvKnuaro5DjtliMyNfeyGmlbCNY1ynM1HjRYS
GBz19dqhOqxYeuTo6SPwaDS9l9KkDfkewqJRgzb7VtOpwipECIXcK0jXaM8P375xpUKoC9aU
Lr5LwnGcfbReD//75a4C7TiJt2WPLUTy0vvOiLIgqHB2605wy+CP5+MGq2rd11yjSb5B91Yt
iHWxNyjNfTfOHatn1G7SmCbYyi7hqvvNJ4mRXMvnpGNvECEGu7pVFMTTmEaRlalUDuwFg0+1
f596Eu7IVnpzm/hpOpr1ZqlZUmo1BacEvr9oJqCuinwuf37jE7ehicj+l3ZiribKy85sCimj
niUWgk6cjS32j8FoNZe8FsdPYgUD6+uCpL7tCqrdlnbtNPEVN9lG8aVeaYpQH2RhYBHTJBit
egI5iiN3gZ3T91QdGkdeGhuZzdYQGDmN7VIIIPOxJWvBIb60IbKTmYRNBbMIK5O7fU0htF1x
cOwgJJe47XcVBNDIzJATsyxcFBauma92pLVFlfY6LB3NUdLyReywNxhFaFKwhPfNVhfhQAWk
nlpJI4myCIg/mlP5ocxPdaNfS9zhb6PFSew5P6ErucD4HkZ/n6CQEZUEZXOaSZpM8F+Wo7sO
lbVhBcki4ioVkgjKJyfMT/KSTMuRtWJdUAmf25P50qzKS24Uk6nSY9839zh18Q47Y2U+hXO3
NMm8LCD0DQNnWMp0NVm1gPv5I/age8LnRLXv4C4U6PhBMfiNd8NTUc4lJUmKL6saC/bGS2NQ
DoBmelPt+MJ+Uv3QTgjd6A7V9/mwg0bdoH6XxStxgdopbX4lyTiOduYTMJ3TWpWa4ZKdj7zX
eGuduxOmNCyV5PO+OsepdLEeWLXhiOFs0G7az1n4CugnxjtAFxM+sGem2Zqt5aKIMs4Fn23P
VlpjGFVPyvOHwqBSWBlZabotbWcOWAK53vSXSTdPo6+ZCbFYS5EVQRz5dpLQXGGUJHYNyoqJ
EyTJEkcxVhcuO6EfoX4yVI7Ms9MHgERILQFIgggFojTzbIC2myBEqjAt+onaZnO37fLjrpKz
cYiN6DmNgWVhpBwVS38A+s/zqdbsoiVxOpbZIy+3uocPrphidiqT09EyCX3FYkijpxi99T3V
fF0HNCVah2Kk6jpH5kg18B2pZgR9qnvlYMnoI15aAQgFgKQKENZNGkdMnB8njgesGg9++z5x
0CKJCVrn2xSc5Kx8e+t7wGFXeZu3frSfljS7QSBuH20LBBFvFtHKClOatXqwsUdrUdKYrDcS
+Lkla51QVk3DB2NrF3gyepVvaayE6+gW/MCtZg6bNi/CrotUjpRsd1gO2yQKkgj1QD5z8L1d
W2Lf7prIT50mMQsP8T7jSWIPu51XcGK33HSm32El29f72A/WO63etLnD4kBh6R2+3BYWXggx
q61zRRH6rHfG4Yh6Ggj2t3z/vfLpP4sQaRw+cAafYC6fIVpMrt7oLoCY8SMHkGFJsYKvccjk
CgDx0clVQI7dhcYTrs05giNGx7mE1gYjLNuxFyM1FYiPzOsCiFMsP4CyZLU+4O/ZmB9wngB7
1qBxYH0tgAjpHwFkCQoEfpKh7dcWfeB9UlhWxOhT3iWNqtsSf9MWplKwdFIbBxg1CdAubRP8
1ENhWO8BzoCdNF3hFBNvvn1Cqbhgt+lnZUDdVigw0recipaBb5SDEC8Gh8L17pM8a+OrL9Ik
wMcXQCFZm5E6VpzB0RmEIz8gq3dXMD6WkGoBkCTIuOQA34AizQNA5iH6oDjcy5SpqW8NY56F
szVu9hCVjiRol0MIgWK77dc+r4cgIpgC2rSEb6Bix3SbILrsBFxfOOkWqgtTkPprfTtNf0ij
cYR4SYQqQXLKSNfHITCF4aqSC9u/OEVnUr4pCfn+dH1t4ExRECdrE+WxKDMPVwIBIi6XLRPP
b02Me2dbJOaunfQOA6B75iPSy8mYAHBy8CdWSA4U6wN4slJZUzjbyk+CBEu+agufb7NXPuYc
hG9j7CJzIL4jHlaZlhZh0qKiM2MZ/shEZdoEGVpmyhjlgrneKG0bO07Hr2O58Elapui76ysT
9T2sHzmQpAQV3Zw3TLq6A6i7nHgZOotwZMTt7ReGAJ1CWJEgo5jt2wLTBljb+x66DxTImkAI
BmRG4vTQQ/sckE+UCHCnU/RHc4eI8cVp7Ho4MPEwn6zugk8sJfi+/C4NkiTA4mWoHKlf2tUH
IHMCBN0zCQh3wKGxrA1uztDwqVgN6KhDcbdDoZgk+62jVByr9rhXyIXLdd+iMmCiN8IB93zp
Yhi82WMJ7GStQ2mTid16vnpWIhSOXDHfmAhgITbw7OH11nTaD7vx/P7c0n8oIaxm9gO2kZ5B
CFkGr+TPbKh1e52Zo6ykldnucOKTVtWf72rHu3zsi21eDzJi6Q9/ImLU0h5/M4B9MF0ONc2h
mHQIg1kvCFZJZ+UQvk3e7cQ/eEbX4uO4XdrrSauw4ZmYkVKU1Wk7VL8qkmFVBNzV5g4X3TLS
i8i/aPJWcxMjQqwdinPJ+Ox8oFvTVFJjmPNXxZ9zBKE3gsHS2zP2Lm9isMVajI65/IPqnEl+
Eiv5acXZjIzrunWh4Et7THUt9ivNqd5RIUnMz0KwMUs3vB0prTfaMz660X7AlSj4j1JZr3PD
FXdkQOtGPorRvpliwjjsXTdFmyMlA7L+6ywLVtQO7gXXbpEWgKIePgU+h2tGPp3LDj79ihY/
X9IYXfexkgk1JhRvAn7//vIoQvk6A2NuSyv2CtDygqVZGKHhWgGmQaLenc80ot/xtkKo+ihC
HSKKj3JG0sQOdyUw4Q1k21RjgYcrXXj2TVEWeml4y0SZN2q2IYJeZlHit3cntD1FkmNPvNHx
tl60l7RrNYs7m7saH6I87pcdos3EZaNqnzgTI6LXcjpiNi45FwRXmWc4RgMKz2Bg5eTr0eSA
yvcbwXTL6khrX8dcWxQ10G6LGNgk07rA9SWAeZq4sTYkK6e1X4/5cKtahk8cTV/oNl1AkJZN
xsQIMzmUzblKzAwwyd4V7gR4l3L882Q4G8yyaoDOpTr6y1udLg0GHR+Zkwyg/8y73/jkcsAd
9APHZLWkZSgd+njmqJFktzgJPPbQ6L7b8nrhaopPPiZJ7JwcJJzG+GcOVXthSENs3zPBaeYl
ZiUFmWDa+YJmWBU4GQ2aDSiLA/WUVtDmE1Qz/6FimGdVgOYreWVKmB3EGNdLC92xMIqMFjMk
PX8WeYG7UYciYlHqalMwH06tFLuIxfqOXMMpTIUHNOqNgOswiUdDAxNAG6knFQvJmAYE/fY+
5bJHzAT0h4z5Zow8b8VHO3zDN77OkhqmnEBjEBM9CCKu6dEiN9enxTpQywOMIFDDySnBpj3q
yUi7QEXB7mnse5HWt9I60MdGmYSS0Sj5bE5odKeko0fdCywtDwyqbjQ412U2hbTJURwhJdIs
GReqYci40DO0wgpMkMQ41fRMNmF8UkQdXc9WNZgCM2P5EZ+EZ89R2Ld3jU+SYG10NG0QBYGV
ZxFEaYZfbAq8dU4Llumx0IZEGLJ8ZYW/a9PQM7pXHidgNP3h7EyPkO8jD+WVNp5LGQd4IkR7
V0OpB+omybTeuwLbegTXHIeGwXWq+lJ8YYFH5Ufp8YAeXW9xruywGRZ74R/9YFqI16oklPRU
HSoKVEZBlqJIx//0KCJ1cRSS+v4zVtIVm9Ir06yOf8ImFd/VSpsG2Dqi3j1qCNGNbAwMG9mK
OORdFESqQdQVM58kKj7qhOb7SYUl0ylyGDRcGWvaZIFDA9O4YpL42LbtysQnjjgYscrAopT4
mAAIhOAtKCz3PutZOduvlwtm/ghvzDUDeYVLzn4/wBUnmBHYlUcxEURSAJQvPJ/kI+7DQuw6
y+CJHaI56amfJpBFjp6ZdNbPEpiVbBzTbmcVjKu2PiorgBB0HJrq8BVZ9BikFiv2qArT9vhb
5atO/hTslKZe7DlSB9BhAm1woZqPwnPXYs0xa8YWsKimSJHhLtTnzYiXedbyPik0sJEgXi+1
VOpI4M4JFMQfyAk0xh9h8x0RGw02rkj+GBumLhtMUkfEMU0RVLDpUQsCnfTHpFfA1Hp0JHKM
cqk/fVJXqfjgTO49FHjVF08V5BPf67ng8+XL08PN4+vbBXtoLL8r8lYEcZefO5Pn+kRz4Lrs
acnoL50BXEExrilpHEZeQw7vZT7LipaDK5MCYqg6oMMcRNmNnMuTcmR9qstKhMBQO0wST2FD
eEYbcECV99hr7yvfVXYkLS9Pi8ppJCsVzrbuRLSDbldhdici7+1dB49Urt5tTpvZN6hCacHF
/V8qxQhawhgcecun9dgFC6SRj1N42oH+w1d8IgJY3nc5HGeJIuOv5wWb8M3Ct/lwE3NuRDTq
gyOqN2c/NpXrNFsILHK1KHsSKoNIj5b4Epp+ikSNMoIcrTFObCCJJts/5nDxckBdvty0bfEL
ha3f5LphCf1wZZlDud/8tMR3/3mOWaIc00P5ITxwyU56R09EM5qCkKrNcUsM2bjSEQEV9LZq
Dz1Fv2jFXd0yj4geeXh5fPr69eHtr6vfko/vL/zv33hzvby/wn+eyCP/9e3pbze/v72+fFxe
vrz/bHchDKrhJJzv0KrhEuOecRjLRTDj5T1q9fL4+kVk+uUy/2/KXjgXeBV+LP64fP3G/4Dv
lKUn8u9fnl6Vr769vT5e3pcPn5/+1PpBjlZ2Ejt6e3ZgZZ6EAXasvuAZn+zNiYFVEEwgKpAE
AUHPRyXe0j4I9eNaCRQ0CDxsZZzhKAgj7LMoaAKC7R+mAjWngHh5XZBgY1bjWOZ+EFrTHl+6
kgTJC+ioVew0g/YkoW0/msnRQ3d/3rDtWWKiF4eSLn2oStb0RZ7HxnNkwXR6+nJ5Vb8zZ+vE
V00ZJXnDUj+zK8PJEbajWFDVHFASb6mnPRSferRJ41MSx4mdB9/T4/EQl2ommt2ESh4R2Tr1
kY96zVbwyBbWU594ntXL7I6kXojkcpdlHn6orDC4m+7Uj4E0dlf6DIbmgzZyzd4TtU4s4SlG
EskBqKR2eVlJw+4hQVbjjijykljNJckod6Cf/ypAhu11Jvw2TX2rXmxPuWgs9Soeni9vD9MU
qDhQNvJqWdb6+tmHYNp+fXj/wwxXJNvq6ZnPkP+5PF9ePpaJ1Ej12JcxV53RQwiVQ4yt6yT8
i8zg8ZXnwGdguLSeM7BGcxKRPZ2/5mvxjVhz7ALBMg2Wr75uZC7Xr6f3xwtful4ur+BCTV8b
TBnd0yRYleI2IklmuxOg0yL0/Z2v9bxG76+P50fZOXK9XDQCrksaZdDWPHbsxGspWbbv7x+v
z0//e7lhJ1l1RCUSX4CnqR71GKMy8WXJF96gn/FEOJ4S/Njf5FKHnJ1F4jvRLFVdUWhglUdJ
7PpSgI4vW0a80VEgwGJnjQXquArT2UiMb3oNNh+9PFCZIByS7yzQWBCPoBdDGlOkhTnQsdCJ
tWPDP4zoGpowZ1sVYUhT1MhUY4NxqL7MscVDu99R0G3heb5DAARGVrBgNUfiqlUVOuMjajnw
9eRztjZNBxrzBN1K7VSqY555nqOqtCZ+5BD1mmV+4BD1gS8NzNm3gecPW1cr/Nr6pc9bUX9a
rk5C75cbvg+52c6a/TyhiWOG9w++Uj+8fbn56f3hg0+2Tx+Xn6+bAH17Q9nGSzPlgdZEjLVD
PUk8eZmn2dcvZIeLoAmPuX70p2O7K2HfTBWk33FtIeA0LWlgmFhjDfAoHJ799w3f1/Hl7QMc
netNoe+bhxENCsCheSYtSFlaTVDDEHMXtkvTMMG2J1d0WZQ56e/U2XFaulyrCv2Vlhc4wSYI
kS8L1AEMpN8a3ulBjBFNAYn2fkg8TBYIepE+S5WHSRWx5U/IDCZ/BhFWP0/dLsx95Um/PFrx
xFKJPmQE9FRRf8zMpKZhXvpWySUkOyHAs8K0fPlpHhuPqq8diinlVzRBP0L3J7No6tZ4In/K
lzW34PCh5aF3oEJuNmmc+1jb8holtlYLAs1ufnIOQLWwfZomZq8DzaoArzRJnEWUKLGkE4QW
PSaYxr41sJs4xH2wXGusRloTB34js4Wcj7XIKg4MrCByDc+y3kAnqOGEVHJhpsYBiOPuOlWc
4N5KzXzXpdTMNY7zbaat70CrCkSeYcQGMX6fIPupJHyRxF4lLHDoq+4KgDywhqSBhxGN+UzM
y6lZqpz6HjlvMe1cdEvp87UZjlAPljzs+rSnt8a3i5QX03KzMmXDHIMfJlzbXX2XpFADbN5M
lr0cozz77vXt44+bnG90nh4fXn65fX27PLzcsOvQ+6UQ62HJTs5ByAWYb2mtEXcYIseDoBn1
zebfFG0Q+ZZUNLuSBYHnXtwnBswiUIHjXM+t2elRS5cR7xmLS35MI2KNRkk985ZxSb1kOIUN
koe/BFCqafnj811m9jUfkCkyIMWcSzxqiZ3ITVcX/uv/VQRWgFkHWbSPp38/fTx8VdUlvn/+
+te03f2lbxr9e07AVkVeD74YoAumgLLlzIRWxexDfT76EMHEhR6k58Vn6CAb7/9p9Hu32ZPI
ovVm0wqaIaFgtxF6kdncgoy+PbyixnCEnbo5QntiSihNd42VmyCv6Lo523B112GpMk0QcRy5
FOx6JJEXGfcXYmdErHUKZvbAqMb+MBxpYAy2nBYHRozbr33VKI/S2Ovr13dwI8x79fL19dvN
y+V/VjTvY9veYxPr7u3h2x9Pj++2i+N8pzn34D/BuSAeUYRj0iHus0qiNTVTwIOaSJPvHVO2
c6ddDlEdlLsfSRD3d7v+KO7uFIje1Qz89R40s6USicuUF/3NT/KCpHjt54uRn/mPl9+f/v39
7QFeliwXKW150zz96w2ugt5ev388vegnjsU+p3tccoYWwuRNkU/sw8i3h+fLzb++//775W0K
aK1MHVtFLdnWQyv8yfMNrGLWvuULeAsRoyuN1h1Yvb3XSKVuSs0pwisgXyvXrsEh/S3cxDXN
UBVKz0xAcejvealyC6jbfFdtmpoZmQI2QFzxeqwaeCN83tyj4a44H72neM4AoDkD4Mq5Hw5w
nHneVQx+Hrs27/sKjEArTBqh1oehqnfduerKOteCyojWY/sJQXseWPgfm+OK8zKypromb9Rc
u6qEHqy21TDwEqtm4FuYEYrjxmgHPhjAT7PeAm0OTybQ63cobV7cSg/6auLwwRQ7hGoAqxvR
ykwGbrLF+Y85uof1LgvEoB6Go169viXmb97728MZHL0fug6EQO+C4n5TDcR1lMUZXFHBOMQb
CN0DwuAJ1fM4aOCd3rpLmHC9zf1SvBfSiB0XuTpHSOazpitg2QhYHGpPqQkM9Ql/bg7jMUHd
W4AUVqkXqX47oGXzgY87iOXZ6Q+LICUzmJUuYmw4YBtyKF5eVqpTnYWEtMUELDV15TfxWW2m
SQG79wn+TkOijtknMCpOA5hEHcz5SXNOtZCQuk1AXhRobCngqA3RqunZ8CA9U1GXKSDfQuo0
iRfmSjCXiqBtW8c0AGzjFLyp3tR8hN+bclod+BRbO1ri9n44aIUPyu1oEWTtjYQFgNviQ8EO
h/Jw0EfmiaUxMfuJDXya7xyrWT7cGrOM+TmX/Zavp46e0R/nwHDYtOfdyMJIVfNEOwobeo3W
Vnx0dIdWFxTYdxBj3phowvZnpz6vUTDtAQFM4MMhL+m+qvTFMj8ezrd+5o0o1UOpehUphd16
otPaRD3YXAbquSlK21gNiEWTUzoF9dORJQgNkpz2FYLPYQE0h6BLWcQrEqQnlfSNmc5iAMNX
hDy9YnUg+jnUFRMOIFfL07dpFvrnu6Yq8SRovs8d8QmuTE6PF0pRyj5N1a28ASUotLzVwz6b
nlhgQgFW+V7u7CXcg5zC0qdRhLZ2D4q1GppeaSnLBPmK2c+5lHrM70FsYdOiKyjFO0XES5oe
r9+mjH3U0F3JcijGolPWRq6eUJYzReSbw059BMx/gUtECPzGZxQUECoOihTNkRHVgTs9HDvd
7QsQzmDS6Hw2SDvt/bIMal6X9hZyb/jSrcurr2w2VN2OYVHSOBtEEldWiCOkjjIqs4A87vh2
+T/GnmW7cVzH/XyFz111L3rGtmzHXvSClmSbZVFSiZLj1EYnnXJX+XQS1+Rxbtd8/QCkJAMU
lb6bShkAKT5BgMTjAS9VsEBP+kR6MStjut0NLCyqo9tQA6z9yUERjfvZqUZTudZAKtAwkt4Q
xMle+hQDRNqcM7yacCfhlws0D5oO7C4H2dRpBAzmNjMpXdjNSAd1+siaGis9PARozpgp/rH4
yz6+czu8jdVaDqQYN/iNN7EJoqC2Mqu4JGrgdz5miphbkaAjGGvV9q4wQVM4VIYicqZQlg7g
k1gXziCXtzLdCaeufZxiFqPS/UYSOgGBDTDubYskTrODz4PRILOtbFYtL9TA6+jTP5TEH3nO
WIqF00wCCCwqtU7iXERTi+q+h8jtajYeWi2IvwUJJPlgwRjZUWWVdgZZibsNHPa9/imJgSWy
jTf/LOIzTBAcOxtDVUkp20VD4KmJTsA+AJIKz+bOsHDAYNiYJCuGmE8elwJT6rj15pgkOhws
lQg00E9l6OzUvJBK9CrTQn7USi2UrlK/CmTwGEQamL/v4d3gS5w04KGx7n25SvPEG2oSsSAr
O7usiONUaMqUOpCzmkztShTlp+zO/QQjKuXgroBdruM4cjbnDnahcjtS7opKlwoOVm+ILiSp
8Mypcx3w+m6lVFkZuxUeZaqG2vUlLjLsEy3Twj7itV/uIjhzvJGdzHCZOGL1rlr3psliQuhi
pppfg18RSe555sCUrL4D3KSPNYe4pXt+Oz2OpN4NUJtrXEA3ZdrTW6/rbAfqzMCtF+J7egMC
QTaCqoSudyHLkQ04zyBVNuJSeyOFRNg8IgZ08Pz7z9fzA4gJyf1Pf+pJU9nuzjuMaZYb/DGM
pT/eDmJt2quhHIyGQkTb2H+/Ud7lsf8CCwvC+YGqrn/PI0GV5HIw/WN164/OrpTXFR5EgFKG
JAldC+mcfkj+Nf12fvjL78/SFKpSLTYxJrWpVP81gtayw/S/4TX9b9QL8tTWWcqNwuB4Tz3M
J3OEpHWw5BGTWnwx94b4vOJjTAq3N+uqqz2Nb3EKyKUo/rL6KjliO1jdHm4Usy5Q/E9BWsP0
6CGmU4+jdjCBoi+9mmKgaU2mNLK5hepgMZsL9xOhWgTTpQ86Z6/2Bm40Zv996hXvtx1t8YuZ
bzA77Gp67H3VOtUOlbKJ0Ka9Ug18KBiMoXETrNhmYHgS3wtWh6VKYwME/dNciymeb7HDel8y
r9jAU+Gi/5Ulu15qgUtuzHvtvTdRS4dmjvAG2oSpQNWyclepGwTTAN1rjg7YGyF7T8Lb2Ll4
Di+YdTRdjocXTBnMV+7QlaFAt10XmoTz1eTotrWNbORb6Pw111mSbSCjoabty2i6WLmjIHUw
2STBZNVf5A3KiZnr7HTzKv/H4/n5r18mv5pTqtiuDR7KvGOqN59yO/rlKvUw7zM7xCj3+VQr
g8XgHU4nQCa9Wa47ByT8evly/vatz4jw/NmylyEKNrlu3cpbXAZcb5eVAyVVyc56htvFIDKu
Y+FTCBih50WL4cO8GvyICEHolKX/7GeUH7GflqYNZGrCKJlBPf94QyOh19GbHdnr/Kantz/P
j5gM+8G8RY9+wQl4u3/5dnr71T/+8FeA5hnTVK28p8bdeQAJGo4MBwcijUsnmN/1KT8MYwwr
aR4JvBQS/k3lWqQ+LSgGSbcG7oCutjosKvLMb1A9abAow5pln0UARgVfLCfLBtN9GnHm4PVZ
bChhb5TJwr3C+n7MBHfwu/ACRf/9HoAg5m7Z4zzCuvA6cN6noHZxLE+ei5CMqOc2PS3IOduI
Rvvc6AQGTbEb1kYQB6jXXKNBZ6K05RgY5+Q4GY9r+5Wuzs9wAqJcD61SW+UXW680vqG/xSpD
J+5ZA722oiWzonyrueiqaU835qHNKE7sVfRdGtblsWbDAz8wZyAfVjs1dSFkRKpcV5vR5Qda
f9A0XljpRrI4sLcGSqoM2eiL6hhJDVq+f2fApvO+/lX0cR9+1KFkDgwIytGXeBunsvjsl+0x
lStIr/9EI4a0CwxXEBdhpn0yWdUkCO0lZEYEcAtyAhtSULpZ7BMEqs1i6luTuDOIy3kLXWfH
bYXz90QJ6UjZ33hqVz0gW0NXGKZwFOFdD7VGT3Au5DUY44c+0Gr8uHLdpjtwa6TTPGT1dW91
fni5vF7+fBvtfv44vfx2GH17P4Hm4wlgsQOtsPAzZIvCkHy52A7c2pdiK1OffcFxuSBu/y57
FGGMgTrY5ZmFySJOYi+bRfwu2lxnTSRwRhkrplt6bYRX5nUicntje+W6NvnYWmYDMRgQDxXV
YiCAcEeQeBOoNfVnyyWz0ENosS7ZAthUn2QJ3Mc20vc03BCYMOtknQol8XFxs5fUhHObR3We
hXu0ROKJwHZ53y6AIn2jzfDKF7ZDaXkd3ysDEhqvH3sY8/af9MDGN70/SwjOZWMw4Dtmoljk
IvKURHl1jygTWty7WNu0aJHwJqtpzqo4TbJbtjBxQX24MKHFbAniKlmrbOOegwgvd1UaxcU6
S6ijmXZqyGPxmUPwarIURW8gbSj0TO8ktdpqAPW67C2XFrUT1CKshfKthHWHKg/djoS70kRa
DzYs5l8jBKTleDye1ofBWNyWzrztHBzbCofmAFvnA7T8YCJzFfbCRaJ5RVH690Nz6T28K9VR
8eGx38nEHgRmyZ7k2ro+D7h6mZe+eqsqvwmxrbjwhnlvgiTjRXfY2LFdV82hlb57IyHzsD9T
JlBzEw9f+QLq6qrYYCTGvMiCel2VJT/JmuqrVJb4Af8VYHLsDoLB7pQVbAhjhhu4jW+jQNf5
bcNH284qK+9fC4S7IlNx9zXtYjJd55iMiy2JNs54kvuU8xYLA1ASAcGA92vz7EYUQ3JZmCQi
za49J1edybGIgbtmZZ5UJEFJmOwxUhIIC/uKBCTaYdBOwEEL4lxQKdfeHiGulTfDy9PT5Rmk
2MvDX9Z68t+Xl7+YaXFXZtioA5E7He19X7qGwHvyIHuBjQlOy3kw9ybSZTST2XD5gRythCiM
wvjGGyHDIVpN597uhcbAHlR5usoR0cSf/acGpEd/Fh9CYsP3fdxE5/aLYo5+Yx1KIkOvwxwh
OYQsduTuVucyxUQiPUnSriV9eX/xpUSAuuIDbP3ldE73Lf6ssToyxsl+nUQd5ZURmqQEufSf
AXpnL33gDPoHAlVWAxnTWgqHwXUEoNhYAl16hR3g7KAw0DZ3Yq3a+XhmHhIG3CrYtgpep0k8
T04TmJ+KXFNYV4rTMzqGjQxylN9/O5mLnjYsFnknM6VlduBqo4ospjexxenp8nbCGE79aS1i
fJ9Es862GcWPp9dvHsJcacLCzE+TsMGFGSV+izeHdSpKUMg+IACAi230MyI8ggyFElkXSOzy
/vzVBAfrXZt0tPh45dgoGTBabKTUiPCKsv4n7TeycPSL/vn6dnoaZcBlv59//Dp6xevTP2GC
Iv4iKJ4eL98ArC+h+1i4frncf324PPlw5/9WRx/88/v9IxRxy1xXeZUeZa0L4TtiMaFC2b1h
Hs+P5+e/hyo6SpiDIzAI78pWbTqh7obD/hxtL1DR84XFYWsSD5k0SSa0Sp2B4KtEShxOKBEo
m7irREpNMxkBWr1oOA/ZZRoh6CJHe9UzUpHQWh5itxO9x8Brf62cSm4Ujyh8tRXEf789wLlr
l16/GktsUgZ9AlHh2rkGwe0AG2AnSgez1aKH9WWJuKKCYO6z474SuG8YDaZ/NLkURblc3QT+
I6gh0Wo+9z7BNPj2HdvTdECFrcTlf0HNCnLDIumwYQbqdbXZ0NCVV1gdrn2k5pm0CTLO8Xvj
KwJUHNxcY6PQZ7/FsPa/G+0tw5vVflXjsu9IpkS0xluz2+bmxK8kWIqmbI/Bi4eH0+Pp5fJ0
4vERRXRMAprgugE0wfwb4FqJCc0GvFbhZD5u7Oy9UF4+EtMld4kVgd8TGRSZaMxDExiQz4TX
YLh3MjFWsc0IfJczZsgbUd6SNdd1bKZ02dYhjlIP4NB8xcHvjzpaOT/5cOyP4af9ZMxjTiiQ
0wZex5USN7P5fCiVAGCdSNgAWs7mfhEIcKv5QNpQixsI32QCIXmTvBzDxZQnQNDlHvQJb25T
wKzFvPMeFs/3cDYaL9PGcxmYJ3BMd5neTGnmYvi9WpHL4BCDF4wnTU6XbpFh5iVgLwwap4c4
yXK8Li1BXabJmHdHZpttk5DyOjHf8IxG4zIAGtTOAFjqGuDOwYLPtTiuFpOBOQjzwEn423G8
tP4yWS55i1JR8Ujjlm933b7OSWQOHZVF/XfzhgQzr0TheDkh9RtYm/31er/W5WgRXrelNoOH
Ym01elPQm5LDZjEZN71q5KUfjyBHEZEn/H56MvZUTWA4KqWIMoH+5juPYVq3PPSSRyiS4vOg
8fnhy1AeEMo42vtDtxprq37+2rR0BGUaVZybiTdsyrJ/pVyzXoJuzwPGgZS+5sKdXo3Tdd5+
1/1mw7Z4IT+uCX3b3CK8P9MIvF18AQwmabauf7/OWTZtzKpBDxD4PZst2O/5aoqv6tRy10AD
Gjwkz9AHhu5xPZtNWfRMtZgGXo0XNt2cB99BiD9DMWzC2Q2NSWCXqP20NVSEaf36/vT004lH
uHk5/e/76fnh50j/fH77fno9/x8aUUSRbkIvEEXaqHP3b5eX/4nOGKrhj3fqGJ5/v389/ZYA
4enrKLlcfox+gRowDkT7hVfyBXd+vv18ubw+XH6cRq/djunO6S2Ls2F/8xVBluD2rsjgHCUM
La+CMbXmaQBuAqBmVdnyeEb6juJyG5D4m7vT/ePbd7LJW+jL26i4fzuN1OX5/MZ6IzbxbMYD
qKLQO/bnK29QXbiM3fvT+ev57Wd/lISaBpznRbtygGfvIjx/fNdnzK5WyQg9Hq+DXGqWw9r+
diairKY8R7O88R/DiLjGe5WwtN7QlOfpdP/6/mIDj77D4LGFIJ2FIHsLYa+OC3YmHnC6F2a6
mcRNER7ekmi1iPRxCE6ZWHL+9v2NTAh5E8zh2Em8ry7RJxjogB7fIgkw4jIB5JFeBfQ9zkBW
XHZa7yY3c9/SQQTlYaEKppPlhANoBB34HXAHUoAsBlLRIGoxIJZt86nIYW7FeOxzfOhYuk6m
qzGNBckx1FDTQCaUw1HROekb6ltM7nfA/qTFZMrSQeTFeO5Lz97k3iLSUsEz0onjjMfbzPIy
YJEdc/jWdMxhWk4mVIsBKTMIaPg5WGnVQerp3APi67UMdTCbzBwAT+HTZXSHUZwvfIYMBkOj
2gFgNg9Ikys9nyx5PvRDmCZu9MwWFSsQnViU5GQx4UrVFxgqGJl+ADd1/+359GZ1P+++2oMe
7426ggiqHO7HqxUXpBqlT4ltOqSfiG0wGVTTsGBcZgqE8cLR1ohaEgbzqTfGQMNFzOf9elrb
Mhfdvf+qcL6cBYMIyplMaMofjyce296IY1Vn0iifHx7Pz73R9sh2aZjItOu6dytajb8usrJ1
L7OheRqTydFvIxsp8/HyfKJTKo1JCVRcVHnpuxWgg3SnN5pImUyO+HF5g5Pj3Ls4AJVgOaYh
YkFisuv7qiPkCR61fXs2p2roAT2VEpWvmliNVg7CqNbvLx5BRqzz8WKstnw95tOlb6UwLsZd
GHPWkTyZTObub84jABZwIj1fsEC75rdTCGDBTW99Oo2hUIcxzWe0nbt8Ol4weetLLuD8WfTG
25ynz+fnb2QEm5G9/H1+QukH48J/NUFXHzzjnMgITQ1kGdcHyuQ30c3NjKqeuthwSUwfV3Mv
P0PKZbeaT08/UBD2TjKZtzKmKedVclyNFxP2vVLlY++Ln0GQwS9h0dMDxPzm3Dgt/V4sBxW7
ni/tyUTzWMEPu7M4iOTd7tO3CbJJKxCMBpib0neZj9guISqDae3W0uY7HqwG0b1oCYgy9v70
jgOBoMvzxgPA+J226UWKzyYiu8eJq/gc7iR51RaFqreYE0cc67T4fUJOpgZzADZcevWHXIR7
85ZzlWIzUWDm0VBOeRw+dEEUaCWShaXw2UfCnotLnvboavJrcKLc3QxlyTP4o54MxEW0BOu4
SKTfhsUSSHUcSt+FaHTslH6ry4YgDyfLwXSRSKFinX3UglxqTBMzYKxjafrR8V0CfIL6AF/K
JvXvBzRf7tKPelrG20LU61x5beYU4Zzwo96IfWwTUxEgnHkHyeKoAPC2QEZnMzxxTJN8vjuY
dncj/f7Hq3kEvC7vxnYVnfvoAlqHqt5jQthKr6eu51+7jXZ3+KZfT5epqneaW84zJFbit/0F
qhA2bD7gw2iezUKa5KoxLxI52c8qZD6g8NPlHAznWMvY0Tm9/Hl5eTInypPV2n0Wp4XX+oGa
xf1sL4q/vlzOX8npn0ZFJpkrRwOq1xJLu0ZIreQiiBaaAjcnTFiXZMrhh41qyEE6q4omHW1G
AzQQXOdFwq5DrG2TP5bfJt96A8VpYl4MP2rrYew8EhLErmKOCoiBXeY7OowTO2zi41XmI+Jt
/3Uf85GJaHuzmhKVGoGuGxzClD9Zcq5AnSNLr0olRqMDLSwrGA/XMmNOTvgbufyQQ4xOpOIV
AMCaEZicg00HN+eXJxM2Luq/dceRX/nogiPCQlHCx2saq96K3EqG0Zon5ZQ6hKmQ600JFaYD
X7qtw83WCg2ez2yzbJvEXXuuo9gg8NbWhF00dsL/gHY8Qfw01DekoYBB6C38Hqqrh05hQ3XI
+5Fd4o0c/RL/DdrA6xnNWbppQm/wlz/vH06/9k1coFB9EAWZc4TEmjr1tDStoR995Oaozosq
khr77n/ThjJFlaKBUO1fCkiBJ02zWHhLULxpkb8v/8tT6W2BYSOpewJicSSTTCBHa2QT3mfg
5hoTAFoaXpYbFVlDUzjY4COlpCb4rXhTojilZCm3Vt9klaFFYg4iEPxTaPOlRnz/9nI/+rOd
NOc+/AwTao9Iqj2GIGFAf7Miajy9KJuDQ0pLDONGTqT4iIZQG7apWli9RvMyYC3esHPSDE24
t7EkWyYFRwU+gt0N4KHSOA2Lu5wHddloN/pp5AKkBVjfR8qKhUV4mvi5AvX+WoP5id4uxgDK
aPFodstkgQLADSEwg9TvdWHxTrL2zxtV1ocJc7wyIN+biakhLBOncQBpjPKJEF+V2UbPaqrw
bCoM/sM0kRBAng9lBxCMxV3NJ/gKhQXaxBeEPx+Wv1KK5FaYWKcJmvD/9JCimHD0YlJcAEdq
exfeP3xnAXS1WcP8tLXLGl2g/YYzLcUOZOxs6zfQammceWvB2foTdi6Rumta/np6/3qBHfh4
6u00tNtjc2IAe+4iZ2AH5QGikE6n3wDRAQhD40h8Peco0BuSqIgJ49jHRUq/7+jEoJjzOTeA
KwfwDqOlOQK7GghDUm1h96w3A64sFlu7fkztQm5jgmyBCQJftv2lBsL4B77PFzYwSDhPau/R
reD4N4wGOl/G1BQ9M0lrbWWUsxnW46/s02ajpzW1K2ohzZIZ9+BGpensobqvXPGAq2HxO+zJ
IdQgC4viIwrfpDACZBp4s4VJbTPDW8lYWJIvjq+thSZf/OqoxRZ4en6Er9YDSnfTLBOJOM3S
jyqxRMB5s0J647pSMi2/xP1eWNxGHEBNGOoRNNUsB58ZAzAMh5saCHq0+64zMtWuUgZBDwW0
WbtrPOEZEk0CKbQvOTUCE85TN59+VdQSQke9dC7VrKNiJ51FN5LlcHlje+y0GpRLos6hp6fe
sPGAMxZEkL1/a6btriS/D1PnNzNftxCXa1Eku6xEiL4Vfh8BS177HwQLlNHTAfZm220Oi0E8
nsvW5g0EGN+stETIvUFrjVLtdNS34OBAQ+8g4CMZWUEoW7k/cSTYQDYmMNdTokqLPHR/11t6
VQ4AHRtYvS/W3P7Mkg+Hbg7jfDewyaSzxXA7Dp/oBn0bC3TTqAdD9RuqKg9F4j/QDH6IdRpk
L27AFeq/CLri8RIjxziHH/Qg+g/ap9U6GDCACOU/LLowi0Q9sGBFj991qFXun6SUBjaAH636
9vu/zq+X5XK++m3yL7JcE1xgUWzkllngv19lRDeBL6YqJ6EPowyzpLYxDmbKm00wzAfHwf0H
LV4ufM8sDslkqF00WpCDCQYxs+EWL3wGKg7JYmgoFqsBzCoYKrPiOVidUj7NhpPMVkO9vOn1
UuoMV1jtS67Fyk6mgwsBUBPeFaFDKTl1+6HJUAuG+tXig6GCs8H11FIMzV+LXwxVPbxUWwqf
KTfrbjAwDLMB+JyP5D6Ty7r4/8aObblxW/crnj6dM3Paxs5mm33YB10om7VuoaQ4yYsmm/ok
njaXsZM5u39/CJCSeAHVzrSTNQDxDhAEQNCmRVhn00EKEKnzmHkCB3DC8ta8ODvB5WG8E5W7
1hAnqqiln+MYSW4hHzhV8DpiuW3tHzGCBVJzDhRctpZOgjNSlJ39YonV/fk2t53Y8mZjN7lr
M+tmZ5r7z89s98eX/V+Lp/uHPw8vj9OBtEUlgYurLI/WjXvD7e14eHn/U/mjn/enRz9dCpo+
tnhLzzqToeExBxvjNSgsej/4bTyCSb0SOM+j+GS4aECt0uWnLJRdJb0tI7gjTSfrSV6f3+Q5
/Of3w/N+8fC0f/jzhL15UPCj3yG1R/MyM24UTzAwZ3QJs9wcBrap88BtSYMo3UUio3l+ncaQ
H4nXAfWGlWgJBhuTLFFq50nUkgkvNGHRNS1kmDZve2ZSDVdFfF2dfRoNn00rq5VyD9zkhaVe
ChalykjdUAaSrpSaaQpfxZWpB6BkrXalaQNVo2Cq8RsGVtLGbaQilPokHErhwF5EbbIxW+Xi
1KBUZU6+8YF9riu03pn+JbCvXkcQUaHtq86EZRU4kJRCqdKI0SFVHG0z4so0aY7A0ZqtZuXr
2fclRaUc4u4YKJX/q5V1c5Huv308PlqMjMPNblrIS031BPCQ7oZOBIBfy/GBNCGB3MKqGCE1
xzZCQ/YMlbKKkYmE4cq87lnBilyOrN/WATNTg5q6rgklv1FU19SCHS1Kmka/3uGM+wR2ylQ3
3SQrz3K6Xi3gmPibYcCegK0zU3ZRqqMDOlQSdmkbNebuOXZzm1TXhgFQ/Rprgd+DuEAjsoBF
QIsfpOWlFBVdIffePnQ+0S3fOBmpVLgZLN0FxNF/vClZvLl/eTTDm+SJtKun+0DG1d+sDSIh
FsBB4qVVkgKFDe5ZcnSLerYUK2hA7khygKLCJKwhqwcxMWFikDgdmwyDE6XRxdpOFhKm0aUt
zeGHpvcbSHLSRg3NRrsrKTGl3Ewrmt1V2WAYpB05Ft7tkULCAFddO4EbOfCpa0lXQHvDRRie
8l06xfesTMcdw1l1UOmWsdoRYyr0Dq55jLJz8a/T2+EFrn6c/rN4/njff9/Lf+zfH3755Zd/
uwqBaOVm2rIbK4+gWuY6PYMLn8idFu52Ctc3kqPBgUc6sYES/WgotG1vkxQHg4+M+BZNOsxY
1VgMjKbbRI9SgYdEjTlDnNN8XXEf1VxuWXkGWwG1QLBWyUBSZWWD43NafeMY6BKoKAKYatRP
zUbgNi/HBBJLM5bKJeE/uOhuJ2o7Cg6z/P8aolsa5g2Qcuu4sp0jYk70zW2h6HjkUukJNiiR
WqaUrzxCfUoleUg6a9d3VoMgcwKERl9So3AMb+NAYX5N2bMlCexwcprkbAy8vlqa+GH2DBC7
alwJoNniSmtbwkvXCtXonDy4jtngeadOSnp0eyYERnX/rhRFy2Ze0GRUcZgTlSY3HNGo3k11
GS7XUqmpbmssVzTPlQIW1s+QJgOOCaCt+kc9m2JLOXxlcgtpyqbAnwZTrAzs5qdjRSVj7AsS
iRB2LaJ6Q9MMZ7XMWRcEst/xdgNZpRu3HoUukqqTGog8AVUidUjAS4prEihR6fcKkdxlZitQ
iZx0aapowyeKFSa2jBcgAt2cBgYQ53KHDgW7JCCZxneaQayF2mf1W6bwoMLy/MsnzGcKyqcl
lyCZbM2DD0oOES3AytAAO3kmQFGiSd1CGKsa4Ro06YCyQTFreqlr8vY2LEHiaTVJER8UInEr
mBZQVgikkBpFP+FM5mUC5EGwYrV7ff40t7VgzzbsBkzxVsA69rjFedQvodIeb6DbSsKWvICF
aLRcZM5oxry1ApEQ2HXmO78IEuC7UJFjdgEAd2duW3h9QI6Gd3NDrYtro2kQAwdN62MpGjYF
PJz4wylwiHMLD4eKTQjV16EFx2k5yHLJ8eAL8XpgncLIWuVBLLz64BAq5SCcVSVPw7UbHohu
biIIng4e0tTRap1aXnD4PXey7GLJHopF+B3KdfNrJNtFUixpwrLqyy5wlkKK+VMsBM32vFEi
hxlLCVYyxOgwHVY7Foq3WgwcZUGKRH47mN+6xkjFDdljtb6ExxIzI575lRVBYZaWxmsyWs+k
YRmnS1UvsaRxYjeobtGtZsfMTAijrIz39brtbahWQaxUYmnVSf7DrXVGm4PAlrxryHftYP1A
7K27q45FQANTBn4IMSeuIMkzsA8+E9Of3VyeTWcqFyfnf0njNAuuaCyEW3w9t5aIwkJ1ZP8N
CkaH0I4UnWe/dSmwemM6tEZjNtFsnVbc0UIMp+KAL7UOv7EM8S4FMKc8vfHSijZUhQ8qgqu9
F5ycKmdOUf+q6ax2Kicn7FMzLvGu3Kmw+UpQ1oUR7Zo2VeKJ/cPHEW6SeeZtlLU/zF9e6CDs
elIZAAOPxMNeaB1iY/0dJenh1S2WDpUYZmsMoNIY4kMJ7tMNvLat3u2zvm5Y0kGMDyQ6bzA2
FkUXLcw1LXWc1Cg7tAv1bhVfzZsqj4LbhDybYCCpulNAH1dhM4OdF+KKlPpg2Zp9NMbvfv3p
19O3w8uvH6f98fn1j/3PT/u/3vbHn1xmmMYhSnxWGbBffxo/xEGvhjWRHH+8vb8uHl6P+8Xr
caEqMdJFIrHcQ9aRGYpugVc+nEUpCfRJ43yb8HpjjomL8T+y1R0D6JMKk4UnGEk4upu8pgdb
EoVav61rn3pr3qsYSgBGI5rTRB4s9TvNktR4UkoDi6iM1kSbNHxlHaIVChYgGcxmfjjE3aMq
1njFr7Pl6rLocg8BWgwJ9Ltd418PDAFgVx3rmIfBP/5iKwLwqGs3zHy0QcPtEPyBOIa8ug7H
alzDC7/0dd4x/QEIfH+2hrdA1GWpj/cnuFv9cP++/2PBXh6AFaVcXvzv8P60iE6n14cDotL7
93uPJZOkIOZxnVBa2/DJJpL/rc7qKr9dnp9d+J1iV/yaWGObSO6F45W6GPPigEw6+a2KE28Y
k9YfvqRtPDqWxB5dLnZEL2tZTbibN8TalFsJ3NsYhn5zf3oK9cB6hmSQLUXkr5kb1Vm3cdeS
1vdvHB73p3e/MpGcr4gRQ/CYy9StAdEz0wxoOUY5xYsS2S7PUp75i3djPU83DHVorQwI1GzM
NFIDB6YU7MKHcbm81IMzxGCKIpVCJdxXwJvZcSbw6uIzBT5fnfnLfhMtSWDfNA07p1Cy9DDy
YrkKI5d9ERMd1WUW1AHSLrmIvX6pjwNNocDnfhGF39p2LZZfVkRjd/UFmTfQXEk9rr++5HoZ
D6nKDm9PdkLqQTvwmVbC+pb7YlmC9aKjvhhr9JBlF3OiFpF8IpgslqfmjJMnOIfCi4t18YHG
wptcec79fX5A/N2H0F3Z2+j65p9TrsKkEBRC9wRwPuci1KydIvBXJULnPkuJpSBh5z1L2dR6
d74y/Buere0muotSivOivJGbIn1UtEh05X+/wfp91ojQ4NsvGI9AUVsvutlwKWLYahpDr82a
ahro2R5O1Kt/QN6yQE57jd5V86yjCbykig46sEBsdH++i26DNNY6G4O/IFuNyuLnNl0eAcAX
Mtc751KIjbz8tPLakt/5My5hmzFlkbh/+eP1eVF+PH/bH4eMgwczMeQowhreJzUcajyuEbFr
wTcxWoPxuou4aG6ukITS4QDhAX/nLTzGDn64+tbDogGaOkkOiJ5UQkZsEzpujRTU0IxI8lyK
m5UdaDBgKN1T3a9N3acXKDJICZNEUTHOHvpimhnVFb5KEv+QqOF96ksJQDW1/opqBXynfs7X
KwupG7rqq8g/kmm4PJRefrn4nvhK7ECQnN+Yj7K62M+rMHIo+9rXVq3S5/Cy/OuMrMF9Qi5q
bouCgRUJLU9oXKSQdRfnmqbpYpvs5uLsS5/Axe2MQxTmdAtbE9TbpPltDHS172gnkA3yv3ge
POE7sKfD44vKuIRBqlZkn7oKZRrXhGWu9PENGIEmm5jCs5tWRGaLQwa0qkwjcevWR1m8VMFx
jm/sNG2waRMFsiBGVUxmKjSTb6+tQ672+/C7sEEu5iU0U7nZ/FCfw7fj/fHH4vj68X54MU9/
MW8Fg1cHrbCSydcz4Sl/JbbHjBYc8ss0rSiT+rbPRFUMt80JkpyVAWzJ2r5ruRlCO6DQP5dx
oRyIPh6eOOSV5VgcUA4Yewg3yZKivkk2KkpHsMyhAL9SBmqiTkvCbUGcSFEjpb8FWn62VZOk
V6dPUhTJdrVdbxdw7lir4Gg74xPRBJI/WXx7SXyqMCHlBkkisQtrAEAR80DV1jafmA9U89g/
6ifW6+tRl4L5H8ZZmd6HyaIjcTC6aX4spCoy3dZ8NqHgXHLheFVUboOg/UzdQKjWiYzu3FVm
GT8muHU/dIJuEqIlQG2VMjlL7gBB+1EQ1cfJ72Sc1FBav77jliNvROR31ruwJqLyGQVjbyIr
plQwCDis8srSXE0oeDYu6Q+gQgMVJ4ayE+PUl83gvJrIrNAHc09qqoTj4zxy4YjICl1pgMnN
tEkKBL7G3mJ+9BabY9Kscz+8EGJJdMoGJ/LTIsH3W+nQUBVe2/B1GUEAmcEqddcLq0nplSFK
yxyuXBrk+R24ZizerkRKRtumqRWpy8UV2K2ocISi5tbL0pChSrC13JPMiKAugSv2rb2dZRUc
xtzgKIRefl9+dkCQgkMyLQSKmd6s9cwtkQYygpFhbaNYVo84cSrQu4Y4AEvnngISVFqXHl3V
Q6aMoVII/EpZbb7QrmNgBpkjEf8HHaOzddinAQA=

--45Z9DzgjV8m4Oswq--
