Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE6C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7232082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfBCOcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:32:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:43120 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbfBCOca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:32:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 06:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,556,1539673200"; 
   d="gz'50?scan'50,208,50";a="123596286"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Feb 2019 06:32:25 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gqIor-0006We-7A; Sun, 03 Feb 2019 22:32:25 +0800
Date:   Sun, 3 Feb 2019 22:31:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@01.org, linux-nvdimm@lists.01.org,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
Message-ID: <201902032230.og6GVIra%fengguang.wu@intel.com>
References: <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

I love your patch! Yet something to improve:

[auto build test ERROR on linux-nvdimm/libnvdimm-for-next]
[also build test ERROR on v5.0-rc4 next-20190201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/libnvdimm-dimm-Add-a-no-BLK-quirk-based-on-NVDIMM-family/20190203-213444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
config: x86_64-randconfig-x018-201905 (attached as .config)
compiler: gcc-8 (Debian 8.2.0-14) 8.2.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/acpi//nfit/core.c: In function 'acpi_nfit_register_dimms':
>> drivers/acpi//nfit/core.c:2003:27: error: 'NVDIMM_FAMILY_HYPERV' undeclared (first use in this function); did you mean 'NVDIMM_FAMILY_HPE2'?
      if (nfit_mem->family == NVDIMM_FAMILY_HYPERV)
                              ^~~~~~~~~~~~~~~~~~~~
                              NVDIMM_FAMILY_HPE2
   drivers/acpi//nfit/core.c:2003:27: note: each undeclared identifier is reported only once for each function it appears in

vim +2003 drivers/acpi//nfit/core.c

  1944	
  1945	static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
  1946	{
  1947		struct nfit_mem *nfit_mem;
  1948		int dimm_count = 0, rc;
  1949		struct nvdimm *nvdimm;
  1950	
  1951		list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
  1952			struct acpi_nfit_flush_address *flush;
  1953			unsigned long flags = 0, cmd_mask;
  1954			struct nfit_memdev *nfit_memdev;
  1955			u32 device_handle;
  1956			u16 mem_flags;
  1957	
  1958			device_handle = __to_nfit_memdev(nfit_mem)->device_handle;
  1959			nvdimm = acpi_nfit_dimm_by_handle(acpi_desc, device_handle);
  1960			if (nvdimm) {
  1961				dimm_count++;
  1962				continue;
  1963			}
  1964	
  1965			if (nfit_mem->bdw && nfit_mem->memdev_pmem)
  1966				set_bit(NDD_ALIASING, &flags);
  1967	
  1968			/* collate flags across all memdevs for this dimm */
  1969			list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
  1970				struct acpi_nfit_memory_map *dimm_memdev;
  1971	
  1972				dimm_memdev = __to_nfit_memdev(nfit_mem);
  1973				if (dimm_memdev->device_handle
  1974						!= nfit_memdev->memdev->device_handle)
  1975					continue;
  1976				dimm_memdev->flags |= nfit_memdev->memdev->flags;
  1977			}
  1978	
  1979			mem_flags = __to_nfit_memdev(nfit_mem)->flags;
  1980			if (mem_flags & ACPI_NFIT_MEM_NOT_ARMED)
  1981				set_bit(NDD_UNARMED, &flags);
  1982	
  1983			rc = acpi_nfit_add_dimm(acpi_desc, nfit_mem, device_handle);
  1984			if (rc)
  1985				continue;
  1986	
  1987			/*
  1988			 * TODO: provide translation for non-NVDIMM_FAMILY_INTEL
  1989			 * devices (i.e. from nd_cmd to acpi_dsm) to standardize the
  1990			 * userspace interface.
  1991			 */
  1992			cmd_mask = 1UL << ND_CMD_CALL;
  1993			if (nfit_mem->family == NVDIMM_FAMILY_INTEL) {
  1994				/*
  1995				 * These commands have a 1:1 correspondence
  1996				 * between DSM payload and libnvdimm ioctl
  1997				 * payload format.
  1998				 */
  1999				cmd_mask |= nfit_mem->dsm_mask & NVDIMM_STANDARD_CMDMASK;
  2000			}
  2001	
  2002			/* Quirk to ignore LOCAL for labels on HYPERV DIMMs */
> 2003			if (nfit_mem->family == NVDIMM_FAMILY_HYPERV)
  2004				set_bit(NDD_NOBLK, &flags);
  2005	
  2006			if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)) {
  2007				set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
  2008				set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
  2009			}
  2010			if (test_bit(NFIT_MEM_LSW, &nfit_mem->flags))
  2011				set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
  2012	
  2013			flush = nfit_mem->nfit_flush ? nfit_mem->nfit_flush->flush
  2014				: NULL;
  2015			nvdimm = __nvdimm_create(acpi_desc->nvdimm_bus, nfit_mem,
  2016					acpi_nfit_dimm_attribute_groups,
  2017					flags, cmd_mask, flush ? flush->hint_count : 0,
  2018					nfit_mem->flush_wpq, &nfit_mem->id[0],
  2019					acpi_nfit_get_security_ops(nfit_mem->family));
  2020			if (!nvdimm)
  2021				return -ENOMEM;
  2022	
  2023			nfit_mem->nvdimm = nvdimm;
  2024			dimm_count++;
  2025	
  2026			if ((mem_flags & ACPI_NFIT_MEM_FAILED_MASK) == 0)
  2027				continue;
  2028	
  2029			dev_info(acpi_desc->dev, "%s flags:%s%s%s%s%s\n",
  2030					nvdimm_name(nvdimm),
  2031			  mem_flags & ACPI_NFIT_MEM_SAVE_FAILED ? " save_fail" : "",
  2032			  mem_flags & ACPI_NFIT_MEM_RESTORE_FAILED ? " restore_fail":"",
  2033			  mem_flags & ACPI_NFIT_MEM_FLUSH_FAILED ? " flush_fail" : "",
  2034			  mem_flags & ACPI_NFIT_MEM_NOT_ARMED ? " not_armed" : "",
  2035			  mem_flags & ACPI_NFIT_MEM_MAP_FAILED ? " map_fail" : "");
  2036	
  2037		}
  2038	
  2039		rc = nvdimm_bus_check_dimm_count(acpi_desc->nvdimm_bus, dimm_count);
  2040		if (rc)
  2041			return rc;
  2042	
  2043		/*
  2044		 * Now that dimms are successfully registered, and async registration
  2045		 * is flushed, attempt to enable event notification.
  2046		 */
  2047		list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
  2048			struct kernfs_node *nfit_kernfs;
  2049	
  2050			nvdimm = nfit_mem->nvdimm;
  2051			if (!nvdimm)
  2052				continue;
  2053	
  2054			rc = nvdimm_security_setup_events(nvdimm);
  2055			if (rc < 0)
  2056				dev_warn(acpi_desc->dev,
  2057					"security event setup failed: %d\n", rc);
  2058	
  2059			nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
  2060			if (nfit_kernfs)
  2061				nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,
  2062						"flags");
  2063			sysfs_put(nfit_kernfs);
  2064			if (!nfit_mem->flags_attr)
  2065				dev_warn(acpi_desc->dev, "%s: notifications disabled\n",
  2066						nvdimm_name(nvdimm));
  2067		}
  2068	
  2069		return devm_add_action_or_reset(acpi_desc->dev, shutdown_dimm_notify,
  2070				acpi_desc);
  2071	}
  2072	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBv6VlwAAy5jb25maWcAjFxbc9s4sn6fX6HKvMzUVmZsx6PN2S0/gCQoYsRbAFCy/MLS
2ErGNY6cleWd5N+fboAUAbCp7KmtMxG60cSl0f11o+Eff/hxxl6Pz5+3x8f77dPTt9mn3X53
2B53D7OPj0+7f8+SalZWesYToX8B5vxx//r116/v5+38enb9y9XFLxdvD/f/nC13h/3uaRY/
7z8+fnoFAY/P+x9+/AH+9yM0fv4Csg7/mn26v3/7fvZTsvvjcbufvf/lCnpfXv9s/wW8cVWm
YtHGcStUu4jjm299E/xoV1wqUZU37y+uLi5OvDkrFyfSqVnID+26kstBQtSIPNGi4C2/1SzK
easqqQe6ziRnSSvKtIL/12qmsLOZwMKsydPsZXd8/TIMM5LVkpdtVbaqqAdBohS65eWqZXLR
5qIQ+ubdFS5DN+CqqAV8XXOlZ48vs/3zEQX3vfMqZnk/nTdvqOaWNboKJtYqlmuHP2Mr3i65
LHneLu6EMzyXEgHliibldwWjKbd3Uz2qKcL1QPDHdFoVd0DuqoQMOKxz9Nu7872r8+RrYkcS
nrIm121WKV2ygt+8+Wn/vN/9/Gbor9asJnqqjVqJ2tHirgH/G+vcnX9dKXHbFh8a3nBCUiwr
pdqCF5XctExrFmeD1EbxXESuNNbAcSXEmF1hMs4sBw6D5Xmv5nBmZi+vf7x8eznuPg9qvuAl
lyI2R6qWVcSdU+mQVFataUqcufqHLUlVMFH6bUoUFFObCS5xyBtaeMG0hJWDacAJ0ZWkuSRX
XK6YxtNTVAn3v5RWMuZJZwFEuXA2rGZScWSi5SY8ahapGogxDGOpqgYEtmum4yypHHFm6V2W
hGl2hoymhJa9YrmAzrzNmdJtvIlzYluMtVsNuxyQjTy+4qVWZ4lo6FgSw4fOsxWwWyz5vSH5
ikq1TY1D7tVNP37eHV4ojcvu2hp6VYmIXa0uK6SIJOfkITZkkpKJRYYqYBZEKuJg1JLzotYg
o+TesezaV1XelJrJDSm/4zojN66gez/xuG5+1duXv2ZHWIHZdv8wezlujy+z7f398+v++Lj/
NCyFFvGyhQ4ti40Mq52nL6+E1AEZl5wcJeqr0YiBlxhxpBI85TEHewOMzlaGlHb1zh0KOkyl
mSaXV4lBDvw42dREKHTFSb80Mm5maqwQMNZNC7RBCPwAPw5a4gxQeRymT9CEQ/TlWOcZifLK
MdNiaf8xbjELMDTnFUpIwfaJVN9cXQzbLkq9BJ+c8oDn8p1ni5tSdVgkzsACmdMU2APV1DUA
FdWWTcHaiAHeiT0bZbjWrNRA1EZMUxasbnUetWneqGxKIIzx8uq9Y18WsmpqxxbUbMGt6nLH
roIXihfBz3YJ/3G1IcqXnTzKmxmCnfMgKGVCtiQlTsEGsTJZi0Q7swHV99kHjGXba5FQ2thR
ZeIinK4xhQN75862a0/4SsSc+AYcPjwM5Inrh8Fleo4e1WfJxscQ00AsAv4JzqMDBVBPlDtM
hBsltQqAGmTAC+tF85ZcW9Z+ZBmPl3UFCoRmFbyu43ysJiNENcN35YMngp1MOFhF8NU8Ib4k
ec4cT49qBEtvHKF0NML8ZgVIs/7QQb4yCQAvNAQ4F1p8eAsNLqo19Cr47WBYiEWqGkypuOOI
HcwGV7KAg+lrSMCm4B80SrRgsD+k4IRggoBSnBW31kIkl3MPTUJHMIMxrw2ygSWJedCnjlW9
hCHmTOMYnaWt0+FHaEqDLxVgqwUqjLebC64LsKhtBzBIHbZb/h0OnAXB0tuFDI6+C28sVra+
3Gk1Njf83ZaF43rgIDkMo5UZrBcD0Jc29HAazW8dq4U/4eQ4a1lXLtpSYlGyPHWU14zcbTD4
yW1QWWBOmaADF5asBAy1WzxF8oCoiEkJMJqYzRK7bQpnHfuW1sOMp1azNHhKtVhxT5vaEdBE
jTF+3p2b8UEZU864oGcJENGakdO4AXh/IEYMvXiSuO7B6jl8qg3BrGmEUbSrwgQInrGLLy+8
cM8AkC6PUe8OH58Pn7f7+92M/3e3B3TGAKfFiM8AtA7IhPyssdjUx3vUVtguvW/1jDDmBxj4
crmkbEXOvEBP5U1En6q8miKwCJZegmfvQNg0GzrDXEB8IeEEVgWJb6tU5B4cMUbI+AZnRebX
kRvJ3Jr8kffbte1KyyY2Fi3hMdhBxx1Xja4b3Rpzq2/e7J4+zq/ffn0/fzu/fuNpGEyuA3Fv
tof7PzFl9eu9yU69dOmr9mH30ba4WZYluKceIjkHEiLupZnZmFYUTaDdBcIvWSKutGHRzdX7
cwzsFjNEJEOvDb2gCTkeG4i7nI+iVcVaD/D0BM8mOo2nQ96azfRsbc+WrTmEVjqcPtv0vqdN
E0fv5Vrxor2NswVLACLki0oKnRVjuWBGRCQxvE18PHAyHhjz4ABvKRoDCNKCVnLjcgkO0FmY
UFsvQH91YEgU1xaz2bhKcmfNSg7QpicZQwSiJAbgWVMuJ/gMiibZ7HhExGVpUxPg2ZSI8nDI
qlE1h12eIBvsnzXwlbpIwHcwSXKYxWW54YTYYGC5g6AXdeOdA5FMfsh0nooeemiDKVNY63FI
cuLszCEsQ2AHfbbGJJccLUvBy3Mm802MWRvu6EmyAfALelJnGyVAWdrCZmt7q7SwQVUOVjZX
N9cObsPdVww1A080bj+PbdbImP/68Hy/e3l5PsyO377Y2Pzjbnt8Pewcm9+vl2eICyrQQTuX
cqYbyS1cd7sg8faK1SImLTCSi9rknwjJiypPUuHGdpJrAB7Cz1/gwc0Bv9JGHj/BbzWoFqpr
h4MmOa2svFY0zEAWVgxyupCJTkVUKm2LSEws2UkluoQnRIZ544MDG2VUBShpCoHAyUhRSc8N
nESASYDAFw13k1OwuAwzKB4s6NrGYdcwUz/B0iMk8Oq9/CGxvCo69U/pVTt97vuZmRNrnyU4
Cfkd1ierEGqYAdAocPmebq8VrX8F4jE6Fw+ul0QDJ/NdOx6xVx2JEU1nm20uZO6y5JfTNK1i
X15c1OhFAgiBScaV3wIuUxRNYexwCiYj39zMr10GszkQfxTKARldlgtDNp5zNweGckA77VkY
N4P+e1Cua842i4pSmZ4eAxZkjTOArOZWI8I2DpEYukWpPSybFILcqAUDdREVIBQ6wQAumMH5
GnH0bsw4MIXwD5xLxBcAQC5pItiQMakDmCPC0ACTN/PxE91GH/DCq0XrGKhSRTRKLgEY2ii7
u5WLqkpjylMFCuGH6F0T5uhyvmAxnd/tuOyuT9gspNvtDxrxVkFlYK7HJFH+brXL+h4n5vj8
vH88Ph+8VLATanS2uCljL/Uy5pCszs/RY8zYTkgwxrxauzqIA+/vEzpdxGvKAbq/9+wSuGg4
SXDsp1dVURbbnOW6EUm4Vb8Zjz7Zg6FX1xCwiNjZdjfgBD2N5aZ2ESvM8n8hgG02YDjanNTa
/wKaX+CXHDG5jystzjGu3EpkBMY7kWnx1hL1HhHvsPKAoyMFV3QiR8XOe/+IF0cNv7n4+rDb
Plw4/+euZI3DsOdhSHzS9MAAY14QopBKYTQvm7pTD28T8WSiLyv6EQ+sVsDE/to7PEyorx0j
Xmjp5qbhF+I7oYWXxfXbux04rfTFBBvuCSY7jOEaGTOzEoxQAwUAFM8m87PYhmwj6XBJVEHe
Hw+oqyn86/KBAp7wbM9BKxDp4hov+cY5HTwVrmD4CYfITyr0kIvHGGa63Nlde3lxQWGuu/bq
t4uA9Z3PGkihxdyAmBPC4rfcc3umAYM5+sqcqaxNGrc04xQvgJ0A2Hfx9dJXfogo8Ra5O55D
JspsGqZxMftFQbNeLsStixLkXnliu+h8lSgnqdydr8Ccet8NWfB2knbkRWLCXThadJIV7IVI
N22e6DOJVhP+5mDkarxHIgwoRu0YxoXGtTtOnaplcLzzJowGRzxgKKtVaAU7LlXnAOwxmq01
cSXWcemsBhezkL0Tsl70+e/dYQZedPtp93m3P5oYjsW1mD1/waKkF3sF26m0DaypHXWizbrD
8F4LS1aY708IUpw7A15/sE4UTlYqYoFZvwkD3wc9OFiHNvrVq4VRUwXmsFo2dSCswLRMV+6B
XWo3DWNaQA00WHE7NoMClJPaGhLMyGumuPCDK59D1bG0AyLW0g66FmPBCLRTZQcxLVzyVQuq
IqVI+CkHMvUdMAijogxDYOEKREyDQ9yMBhU1WpNw3VBXMIgqkJSyMmhJfKXFJhOCSA7qoMKh
DfFGiMcCsvDuQXxi0C7qQpDrbSWxxQL8GhbMTE1UZ1wWLAQZxgwYsjmCTQ3HLwnHFNIIbZre
7ToWmL2mo1i7khWES2DuJofeWaDO2ASD64mi8uMIq8eRGo038y8qg7E0CmJh+JLOqjNs0UKe
mZDkSYOmJGMyWSPkqMp8MzU5+Jd3kPA3+uZGCr2ZvCweTAGruWNQ/PbutswfHRKosrhap6f4
wO/Bb8Fq01tcY9quqkH3xPQZs/9Og9ANLGsQEiuDXfqamll62P3ndbe//zZ7ud8+2djJi8Xx
+I1ufLCneHjaOeWnwOqftL6lXVQrCFiTxJ+0Ry54ScXSFo11Ys2Ho9eX3ifNfgKtn+2O97/8
7MR7sVs0A6ciEdJLRmBbUdgfAacpnXPWz7JhCuTyIvPSXcAdl9HVBYz+QyP8SyeXi6NniJqJ
LBaORFFaghQjV4VfnTYDxgLQGBRJCAhyLEI6zdzrKarVpNRa0nkSQ2NKkEgAP8ki7pVr9kYE
ty1UKGy7f94fD89PTwBFHg6P/7VXhlbdtg87jPCBa+ewYR3cly/Ph2PPl+xeHj/t19uDYZ3F
z/AP5bNgO98/fHl+3B9dVccRA6oxER85upe/H4/3f9KD9HdhDf8TAAYhdqATuYq1gVI4lKRg
mKzxY+oy8ncsBqNHypbQNZm49zZB00al0Wh+0eN+e/g2459fn7Y93uuHxN5dkVkLbGdV45lV
k51/d0XMrEPz7m2JbQp/m3RUM7+2UQHYBfdCsasEDnvanOTKLF1VhwUgfYJ1YQCfmW/6ePj8
N2pJMt5CntArmwpZGD8DDjKIPJ2djRUcpiiFaQgSIqfrNk67Cg/n0sZp7eMSd10XVbXI+WkI
o/2DAHT2E/963O1fHv942g3zE3jz/nF7v/vZOQde3LpiZG0nkrjyYS22Scy0F7AIZOyNHClb
9mvkBcx4xXoiDleyrtA1aG8d3OwjPWa1avBqqgJoRAEYZNL2FsFWye4+Hbazj/0q2IPqlMqa
OvuVE63gFUEDGnfHwuTLCivYsZaL3HBLxV0/Q7Z16GBcBCuJjKn3WgKv3R+Pu3u8PXv7sPuy
2z9gPDaEYf1hMYG6n8m0kX1YEVLZcgMK+5t16OmDnL4Fgc0JPQz3Jk1RW9s+JXEI2prSnGIs
bYsRQxPZP6wl1aJsI3wOEJxcUVGJQbt74b2nbcX7PIpQ1XR7Jwafo6RUIVjalDb/A4EUhhIm
9+zZQcPm1UsN7wWMxAxCzYCIdgrxuFg0VUNUCChYYQONbHE9EU2AkdSYm+gK+cYMiusRkncG
Zp/t2JKRdp0JbUpWAjl4Aa5O18baVK2ZHoFIwKUQ35SJvR7uttr3YZZP8Q9T64vPfiY7erkB
05Kt2wimYMspA1ohbkHhBrIyAwyYTCEnaEsjy7asYC2Fd20UFEcRG4xhB4IqU2tq78NND0oI
8f2+zkl2i+an3IadGk7beSpRXWbXPG66yBLrkiaJouzfRox0yaq3LcvurhDD7bGt9vZpgpZU
zUQNRuf20a/bdyP9Oy6Ct8oTh59akS7f2hWrONBhot3pifuQg9IExFHNQ2+Bu7oIj9y/hei/
OtE36ASnqirDVbWzFjoD42h1xNzZh4qEdgRCR2NrlmIkZeKtQ2hox68cJuxZadL7XekMpjX/
V762bsLqQ6tgWIKzKka23+5JleJzB6lDK1ZUSX8DxGM4vI4uAKnBFB86F56n5mAQ0+W3QqPZ
N6+ocHkJI2q692lsanxeSVrAYD5AGnC/11DlRsh1StSmhLgshKiObNgxET/Wn3rT+wOdh1Sr
eJ1tGPs9WFthc8+nUj8nQrBhjm/P8QQrsehyyO9G6L+js8DLnsKHSNg7fmo3UIvCvaTaBiep
wdvq/iGjXN+6J3SSFHa3CjfBI7GisnF9VN9iSqWpadSwqhBbddcqsAyqh7WLuFq9/WP7snuY
/WVLbr8cnj8+hlkbZOtGTiWL+qEZth7qeSXIGKXjI0IAr3F88+bTP/7hP5HFd8WWx4PqTjP1
SAFWCsu+XQ00ddEKK31vLr17FzzBhIz+bGvwZaMcfuRfeuArCBOOSf7Br2Dq30dEakE22neh
QTumohaYLXRn3BOxuI2K9syDnu6ayTg36QteRzoUB02tokq4e2LxYTyCca2UuwhY81Wz04vV
ens4PmI4MdPfvuz89AUDWGnxWHdTQ22CSio1sPpBHtFs9mUUs+PIig9+vq5rQ58lKr/ZXC3Z
B7fVTN3/uXt4ffJqykVlq9vKqnLfzXatCZi3LqgOKHHqrefpjV3XgcrhdiwTPXEAZ3p13715
c//xP6dTBZOeHqlDXG4iV4X65ih1cHVTmtJSvA+EM9yU517HYUkaQHtZrAMOdJ7mWXVixJg3
tNMsck0xGBPZv1FoI57ifxDy+m+JHV57YdtlAZzsyOl5mU12fN3dvx63mOfAv7YwM/U/R0cV
IlGmhUbvPXIgFAl++HF0x6RiKdzalq65EMq7T8e+iN5HIX2x+/x8+DYrhlvVURR/tj5lKG4p
WNkwihKior5sgSs/bzZU0dziFTKnSCubsxkV2ow4xh+1J9yUKnp0+6YA1gtipROfo9h2uEJV
YXLRCMaSF/ys+eMSpaczU5fmfns3dHezAob+UFblxFmfvnnvbtu1NW5Yn3cddIqwcNszhLbB
6iIFcII295q+N9DZxlQUyFafnocMvgBgRUzNwtbKVojGXP6loupR+zUxymBfpyfy5vri/+be
tk6XG/urQJQhZ2uIy5V5r4fpFGIME4HGSQIZYLB8zTaUEyS5C/sKjEx5YI2En44KRZiKDlOr
NPB47xeWztmMIaosA+bYr4SHn5O3kCea9ycT8JYAQLu6+aen3U7IRGYk7+qg2qVvjxqvcPBO
2fdXZwqWzSuDPkfn9jWpK7PIfVB6DobahwGjl8JOM5VGN+XrqyCsHmrJzB8vAOzfpjlbUI6p
7gq6BujDpaksnniMv8Anx7yMs4JJKpSoNbexqGunS37KSJe749/Ph78AqVMlNXD0l5w6CODM
b91R4m/YXUbfAeqcGvpt6r/TxN/GD9OXREg1VY8pm3iIYFhUE7X4dGKq+hd5rAE7J+RUeUry
4Atq2Ce6fwJnFP+MBrldwi79oJK1fY6Lf4+Dvrmph+IkUxZNXTMAU1266NL8bpMsroOPYbMp
2Zz6GDJIJmk6zlvU4hxxIfF0FA1Vx2g5Wt2UpX8BC2gMHE21FHx6vUW90vRlBlLTii6K72jD
Z+kP4La0LJumcTWxYnZo6CUndnuYrtto1RCBibXg3hvEkOO8gIjzsC8exKBJx3Xf7A++Serp
g2s4JFt/hwOpsOuYLqQPBX4d/rk4F76deOImcvNmvd/v6RChvP7xeP/Gl14kvylB2XPQm7l/
CFbz7iQhIKX/WINhsm/i0Aq0CaPvXnH283OKMz+rOXNCdfwxFKKeTyjW/PtKNP+OFs3HahSM
b6CbJeueCRrwNz3o4KC6JCX0aDOgrZ1LSiUMuUSgbnC23tR81NvO68wKonmt8c7KVFieYTQz
nKYrvpi3+fp73zNs4I3pEgtY1NEVpUvEv3KHdwLozScsaK1r/Dt5SonUy/n0vQGKm0wk+LCi
DjCOy2xvHEhqVJ8hgilN4njSgah4wrnIhF78/2fsyprcxnX1X/HTrZmqkxrLW8sP80BJtM1Y
W4uyLedF1ZP0rek6PUkq3XMr8+8vQGohKdCehywGQIqiuAAg8BG+Dt1XrKbTF9OF5wlRJZK9
9zxZLVSSOV2GJPqIPGV5G84XwSPJTnjsO3tP05jOtGM1S+mQrGaxpqtiJZ34Xx4K3+M3aXEp
mWd6cs7xndYr36jQuZj0K8dUEFeSozMZTOWzfRwfwedjyl9HVlaUPD/rcCS6+wkdyppFIj/6
d6Ws9Gz0GvuGfuRB0gNe9YpqKaj9Xol0iXnLuKvcksp9ERkdPJCa4JUnTsqQ0QsAtWaqHbtB
k/ra2tgl0WPqaP2z9+e3d8dJr1pwrH24Y2rKVAVsuEUunIDjsSdZVjFftFfsGZuRJ6Z2B69T
+ZaIXXuMKWfBRVQ81YEd44N3exz7wcQhNjC+Pj9/eZu9f5v98Tx7/oqevC/oxZvBaq4ERgdZ
T0FLAe2sg4oiUgAF8/GJFwFUejHcHQWZtoH9uy0tUw1+j65n60NsCTwpo5+FB4mKl4c2FfTC
ku/oni4l7CY+rD7UgXc0j9ow+5UDQ5Bs7wMMcGhemsrJKs3POOMpTxi7KpdvJ2EWRBcPphp4
44EQ5+ajGGzh5Pn/Xj6bsXdjBNTL5448K6ZW8knjvxx4WpIPg6bVWWl6SXoKzCLrDA5GU56w
1DqrByVVVT/E+SmUu9/diMHXb09fzFiy3aULSzMcyg3oiUM9BsrWIKsjP/SLWD1JCUD/pmnE
yBQ/9NFc1BFU74a2jyTwYCipBP1xOjY/VzbGgqZjPF1XttXOzxu+IBVhcKoLD9Qpss+nFKE0
IpGKWpiHgBXfW15j/bsVJrhgR5OlGYfTEbPMPCzqS5vgoxhvpRA+EgQV3JnfClk7nsd8wAEb
uwGjtGzg3CEE/YsawtbohH9y5Y+iuik3Y9/wF6xh1Q400Eo7jMYzVOSdoqZjUROxNuIJ4Acm
Qqi8bTx6kzRLB8Erp7RywX8IvBWomD118myjA04FMWTAk3OBwsa5p9ssVj0MZOdI8vvTjzdj
UTjBj1n2DQ/7NJhU/ePp65sOUp6lT/9YR4BYdZQeYUA7z4tc7IddTe4JOxNRDn+1lXEwJmx+
tUvanY1HLOUuoTymMmutotimQgcqW/07HJ7CQNVKzmTwVSz7rSqy33avT29/zj7/+fLdCEM3
e9/OUEXSRw7KtJqgni8Gs9VNhO6qQvVS2elFPmk0svPCBXOeiESYBY5OUhr1uRdLDbFpM/a8
yHhtxjQiR4e2gJ6qoC7bwG2hw/fAc0wFaeWdEPSAhBBN2/xbSTKIvu8GMXlFRfW/mGL7X0ex
/S/huDHdgpijA1seMWgyUD2SKR12XzalnmrhTBEY6w6hcAgs6g469YHr0/fv6GDvJoRSKdUM
efqM+ETmYq0eWqCm1WDPo/1OxpvgpDxcZeYOxo44iWoweX26dGinS5siKc9/Jxk4EjRw68Ju
tM6IOmOgIW0TqFpShkCfk8VDPr/+7wdMYHl6+QoqN4h2GxmVyqIqyuL1OvB0jEwnH6g8TEjw
x6UhikFd1JhRjoq8ebTYcUFPkB0OWTDGxw1L+ULvgVqZfHn774fi64cYP/REszRKJkW8N+LN
IhUbl4OOk/0erKbU2jjPxTmQ8xx0RnfedWSMWcVw7Eslat/q2ot2OpGvJt+ZgSmzaHCd3juf
2BBUUty8CsKkwn5EcAjZyExot2rQHKtxipdwjPh3M7ymcvvSY7UOEtBFxeHW6yVCHovchskn
mHpHGxzi/042qdCmnd8XxXNGuiNGySiqJ+NiWiBmO9/IUXz8y0L7HzgGFquaEWkJ7Z/9j/53
MSvBcP9Lh6KQmoISs6t9VCEXhCogMZW2qNwZHgY/f3Z068U6cWU3rpS/FXRQap1FQb2yydLS
WyyGO6xomQlmL7bkFIkJob2kBs6QswopgYhH3V0ki7n9ZsjdgYZGp0H1Evv0xKkHT/TRYkfU
4mIS6AB5+/TBR2hLG7a1o3qNirEY2K27giqLN3Cc1A0DtOOiE2NNGD5sqcOUXgJW9NW0wXnR
Nbqnmwet6pRVWaUZTMwOTKPHHnz/9vnbq4kum5c2/kMXpWl5TbvAzfyUpviDaG4vYsLwxkll
49BA64UHqakvj2nAUuI0EeVy0dB+ql74lHFqTe/ZqRXcaFJVpI6ONA5dvoJiKrqyk0cmVUT7
oYc+usOXxzv8hlYtez69jamuRg9pnJzdL9CTO2veiHu32Zfe7WUeDShUjJbX1Oai3X/YMrPQ
SPVn+g0vc6ezKmmPAO0mPmfcyM/sDVCgTrL5ho+CRQgTFsvoozhmov4r+o5FlQXypamxQwC1
dW8edRvE1h1EJs/2aGqN/OXts+Er6RdsnkvYB2Bplcv0PF9YWhVL1ot10yZlQcXDJKcsu3bO
nfG0JcpaJulDrPLAcgd3cdxc9pj4HtN2US12mep9+oAnltvlQq7mlHLM8zgtJMKXIvaWiG3v
2qFsRVpQ632ZyG04XzAzC0PIdLGdz61LQzRtQeNC9Z1bg9B6fVsmOgQPDxSEVC+gmrSdWyFI
hyzeLNeUeZrIYBMaCd4nGXUHOu1Osu0qtLCtpDPvx09mZOL7LvzCINy2qqWRchEv7J1Q/4YR
A89hVbsIFLSWjiDmoNtkBnhA/+EUHRaJxcpsaUeeZu7a/Iw1m/BhbfiBNX27jJvNhArGXRtu
DyU336HjcR7M51YT4ughmE+GY5fr/PPpbSa+vr3/+PsvBbr+9ufTDzDv3tFVhi84ewVzb/YF
5uLLd/yvaeXVaI7fGAE4R21XLMMTawUaWFrOrx45jV4fB26beWbUIFA3tMRZu+XPGQEfgXnu
r7NMxKD3/nh+VVfxOdgQowg6cJM+JdxtgMLxlpMHyFjsPAWRRZY5F6WnCHDIEmMbD9/e3seC
DjN++vHFYar2eeW/fR8gmuU7dI4ZlP5LXMjsV/c0Bts+bTfYrpdH+uvw+OCx6Pqp6lHfRz6s
F+Mw04l6NhKSo2p1Lw47cufFmExolf+TFdYGUzGR4G1wtCESm5cuqeIW/ruu8HGKRqYYiBTV
7gbdVDWta5OGxv4FJuF//zN7f/r+/J9ZnHyAyW5g1wwKk6nvHCpNq6e0QlJZTdIODxio7RkW
VfJ0YnjGnniubeir1xz2N3pzQZEYfSgYS+0XSYv9ng4NVmwZY1QD5o9Y3Vn3i5oNSadKIOyS
+11tkV18T0IjeNwaHq1ENC8UmHQMclIRwT/+B8iqvNeGtLhMIFttiYSOrFC8QiYKGVi4OGWm
EkzNw2Q6lmxk5kzfUKTT3cka1P0BrHIK4YyjFZGOSXoYO9bcMJ81abXeWDRT3TVrVjOU2q+j
iVmgKd4I/I7djXo5oBdObSnKkunUYzvHqI5BBZj4AZCK6ZgeGxvZpdcEQS4eG1OqGerteIQ8
KveGNomjRtPJencn6YQh6u2Fcz4LltvV7Jfdy4/nC/z51ViBx+Ki4hgmQtfdMfEEiTxIZDHs
ywVikqqTaPv0icWITJQhiHtUU8BoOa91CoFp9IzfYvx+RZ74QviUyUFveY8KMsYTv5dPTCKL
VXOP+gtvhTFxtArU+DhQSnrgpuBpuBwXnqiS+kTXCPT2rDpLwdd4Sp8dQ9o1mn3Rc3maeUJb
WeVG/OnRhGE2o0rrAIQlL6D+vvzxN+p9UgN1MQNJZ+r55IjUmJtmbpaYYQT44nrDbJex7fM5
g1nBaTdOfS0PBQnRZ9THElbWNiZvR1JHRjtnrhAV7Lk9fHkdLANfJkBfKGUxeqGd/TwVoP75
bq8bitbcBkViMc+FJ1RMmwc1CflrVpqxT2Zmm8WyPQJZEgZB4LpsDHsRyi49oaCwDzR78sTb
fCBM5Bw2TOupj27wNVGuiukXwMFV2KCYdeoLVk0DL4Oec8jxdf69UXCqisp+T0Vp8ygMSTRp
o7C+0daeDNGKdp9EcYYHXfTkj/KG7ozYN6pqsS/ypbcyejZqtF70AvgKUlqM/cKxA8Ya5ZTu
ZJTBAs6VhrA2UxG9VqGzOFn9Wh9OOcaB5XhhDx1faIqc74tEe8+aZchUe2r86NZhQLzZwlQ8
nlyoQeLNDjyVdkRlR2pretwPbPpzD2x63I3sM3WmYrYMFB+rXe6SRhRB1K3cTtxsWryWk9Yc
cjKnz6gwsbcBncaUCupMySzlBmAm6YKOd5fwaRmdE2zUh+iO3PLxRXxxt+38k332arAONt59
ScPdmwVO7GIC7BosES7WTUOzuvtkxi9IPwjJhhmhfnL3d3u4mGFqYh9ZP4Cd2XsgED2zTsCO
QzQDySYABf4kql3NPQ6yPb00fqQPAsZuylgFxqTVUdk584WNy+PeY9cfr5RlYT4InsLywhpJ
WdqsWk+MO/DWfhc7cOXlJnt3udMeEVf2ADnKMFwHUJa2rY/yUxiufI4qp+aiG/7jgsjyh9Xy
zgasSkqe0YM9u1Z22B78DuaeD7LjLM3vPC5ndfewcZHRJForl+EyXNyZrPBfPAW2Rq1ceIbT
uSEzhezqqiIvMk72SG63XYA2h7n7OejAiA3bujrGtIZwuZ3bi+zieP8L52fY26yVfldUMU/o
c0OjYHG0rwapD2QSvVFCJ3/Dm+xF7hwVgZIMo4zs2CvH0O+duKOiPqbF3g42ekzZsvEcQz+m
Xg3sMfUMQ3hYw/PWW45MQjVbCEY0KJWW9vMY4ymIL7mvyu5+9Cqx3rnazFd3RnXF0XKxtlXm
CcUKg+XWk5iHrLqgp0IVBpvtvUbACGCSnAkVJmpVJEuyDHZ6yyMl1e5yd7RKbkJymowiBVMU
/tgXCHocGkDHLIX4nsEkRcrsdSPeLuZLyv9nlbJdrUJuPZfiACvY3vnQMrPxe3gp4sBXH8hu
g8BjXiBzdW+1lEWMAd1mfKzJrdWGYL1enSnH1t1Pd8rttaIsrxlnHq8xDA9O+5tizHDLPfuB
IG+4MxpxzYtS2kgaySVum3TvzN5p2ZofTrW1WGrKnVJ2CbwiBNQE5nNuOf6yaX1ne5WHn211
EJ4rg5B7Rlw+QTqWjWov4lNu+1k1pb2sfYNtEPBd+bRLEvozgSJS+jEbZOS5KAp1wMlVZYro
AAVpGrqXc+FblLWMqCPm8aMqAZgyMehAwuP6RJHOHiXaWx6uGppPx5YIMQPKjQhmdRffgfbd
9i4fv4AUjZ9Zh/Olnw1d9QBb7C1++HCL3zlavAKxiFnib3tnp3r5CRj0t6pPSlQDFzf5dRwG
we0aVuFt/ubBy98pDGcfV8RlepJ+tjrJby7s6hVJ8RizDuZBEPtlmtrL62yqu3xQ3v0yyjy5
yS50qPFdidr/JQaDwyuhr9Fm/pY83izeKU43+Eqn8fNBr7n5mrjP+pk1mO8NrYyhIxoWQBH7
H34WNZeSe/mNSEXetHtYbBYV/k1KlakHq6csabqkfTwYMKUTvydnXciKWU2vvcg8sovPQY7s
ku+Z9FxEg/yqTsPAEy428mmvLfLR+A09VgXy4Y/PG4xsUR5ohefiKIx9wnl7SahTCxQfz1ky
rdBTPPu0GH7eumGrPqx9JqNdaWYiv5gsw3VOcHtXJMFy7kx2WZUUzhU7GJdFj8VKyMwGpCAq
HZ1FFJODTezt04p1fkmKN1hXFNOMuTEZZniLSa898p+uiWk8mSy13fNcOW91DKDCHZhdXhA6
4JcpPNuviE/w9vw8e/+zlyJUjIvvoDZr8FCK3ttOH0UtT60fhAszWD0qkjpVJvLtx81PJqTG
a952Aj/a0gly7mnTedAFk33/+90bZyXy8mRhIsHPNuWJdGm7HYIUptZVIJqDGBpOkL5maBDP
I51poUUyVleiOeosvSFv+BUvsXzpL8CxPltXDAMHfCgiWuRjcb0twM8O3+HqQBGjC30parrA
kV+jglVGKE5PgeUsJqnleh2GXs6W4tTHiHrCIyhED3OSsQg2lhNtYCUdQEy1CWlonUEyPR4j
yhU0CGBOGPFwJKvRwak21zHbrIINzQlXQUi2Wg+YW41Js3C5WBLVImNJMWCFeFiuqf7OzJj7
kVpWwSIgGDm/1ObJ+MBALB/0h1O1jS6gSf8VabIT8tBdZUKVrYsLA22ZYp1yPVamfVhni7Yu
TvHBQWh05RrPaMvqo7rY0F0I1Kw07FH82ZZyYRmkPREM/5JeRkeR6EqnZIwS6COFf0syl2uQ
ktecld0t6UQlAxsUVvp2t1E2vpaVtQaOLAWZ6lxrM3J5ituYk3w54U5bQLWXo2ohKCeN0Rr1
gQXZlh1e9+JvzDlT//dWP2BfWFRWlilXT53WCmbzevvgSWNXEvGVlWRsY6FvAwF9QMeyO+V6
Dv65W1z37rSSswSbn9EoZ1rCzXq1+2MYP1a4vcvUQdLTbQrxE+lDYC2iYPk82KdaADtdgknK
Kf2hm5sa+9yihWGZhfOmLXKY2i6TJQ/Bqpk2WNM93d2JVOITmKXo2KytrCXNjjKmMzrsDXfZ
zLu7iCcKRizLYzVZbVgTbhdruvVZBlvI9CEwxhyIR6TuywWbvqjavSLOacQiQybhcWGhCHXP
qlOwnaM6n3QAWO0Kl6fmi+ljEd0YWtkJ3Pjqx6b+SB1K9ErZBe8zNm+F0owrd5R9TY6zYL51
iRXf4+2ReMyvPuWUX5/a8lLRn4015QJGV8knDzuRWmfJ0gy9Db76yni3nm+WS9h7TtN+A264
9iwxxseqippVVwyELxKfHq6kE7adrxd6dN0TW/8rsc1yKmYJXUBBCXA6Tudiky7pyagYN2ej
yKBPY6LH4owtafdyVzDhMF8QLQL+F7HJAJdF3E1YmPEVm8zBpDovNjAADtO91xDYrHuBW92n
JB8oSXtAqpuPSmsMje6qTKzoRKzD048v+tLN34pZn6LQlcLNzrwAfZra7Uion60I56uFS4S/
7Uw3TY7rcBE/mPHymg7mk6PCdfQYdR6iEzQ7FZGjdGl6xaioC83rYj91OfthcpHZ+TK6QBVT
0lrlt59+km7qecfYs4zb/dFT2lyCBUTQUyu3biDz7BTMj3RU2iC0g82OgDb88+nH0+d3vBTY
zXat7SuDzj6Y923YlrV9kqYzDhXZ0+csxRvnNJydaTWqw+K665bxXOAapyzx+B2yomHa3ZR6
tBTgy4y5AImYouNiBk6YHuzlnt3uPVHixafCE6oiyJuz8/aQpHZMXbsnr7lQcG8dQPXYb5oq
nfi6wYSqPbcqJPxMJ+4D46jvaekAeH68PL1Oo9G7T6luVIjNlbtjhIv13J2KHRkeAbaEgmvr
Ebr8Y0UVsJAVTMYOv/6R5sU6g4BmWpc4mQzesIrmZDwHuziimXnVnhQ83Iri9rcF3xDhTc3z
hE9WveHpLEfU1sqXn2aIKtxAzDi/K6nzolxR6gUko987udD0ql6EYUPzwP6Vni4W/veHuTxZ
w/JvXz8gFyhqlKo8i2lKpa4GOz8VNSee0LP6MePvjUFy+OCBI2EnTRlEY0C6z/9IzveOKeM4
b0qilGZQbZ5KBhshHzyHHZ1QtxV+rNke3+xfiN4VqzyxN5pdlb69HJg7mcJAwScQbz4y/83b
48T9FCzX/oepW/RO00GpoEjqKsVV1N2ZgIQHFHlNIbEohrlKpyX1+cuSdsUeznF3ojbW0GUn
TVY1UWYCVLI8SS1TDKlgTuGlN2frZi2Dg7dB2jFYiqnjK+gbVUw5KSZFEXreJ35hiJNd7N2m
oMFW7MxbiC/dFaYESV/uLQr7JrGB65w9jQxm5oqOZB1KQ5Dt6/zyswUIVy23G0sfQxcQhidQ
OsiFmXdwqRsznC+L+NCKjiigi/XGOBsryahB+Nr7+MAxN9K96ryO4U9JH8RA18SYvklv+u74
bkSaXn0+uf5jVCep7uqdHr6AYTY9c7EdWQh5pLxTBagDezp1CdnK+Yr4XtZwW8QdlKGnVIzX
XavTGYOYnZpescn+fn1/+f76/BM0YGytQuMjkkG7Yn78t14grePVck7eydFJlDHbrlfBpEkd
4+eUAf0yJWZpE5dpYjM64GXMdrYZvevPILF0X0QjuDW+/WAJIvqDA0NRxjOoBOh/IsIDgjH+
+Pb6iobD9HRRVy+C9ZI+Wxn4G/qkceA3N/hZ8rCmYUk7NibfefnCsYZspvTcOqCZmccdCcxS
iMbjhQFurmKx6WAExVfB2zDI6MuK1IcUYBtu/d0K/M2SDofo2NsNrQAgG1bCW7yyKiZzHOfv
1DBQz4pVAP+4Evzz9v781+wPhKHukE5/+QsG0+s/s+e//nj+8uX5y+y3TuoD6HQIgfqrXWWM
9zLb521IBtNQ7HOFsmIrXg5zirHnCMhUr9PWi5sVkLEUKMQzfl64JT1+c2QdeTaZvUV/SGYP
qZgNDb/xXbPak0aNbB0ONPl2/CdY/l9BZQaZ3/Tsfvry9P3dP6sTUfw/Y1fWHDeuq/+KH89U
zbmjpbU9qil1W7G2SOrFeeny2E7GdR075Tjnzvn3FyC1cAHleYgd4wM3kCJBEgTwNuHg2cvK
yprS6HhTZq9/agtHV3olHixZknbNthl2hy9fLg1oF6rchrTpQcHRunUo6lvVNYsYxTBBTlfV
vHXN+19i8h8lII1PYwUQc66liuTg4cTRP5JdZNxFoN1p18yCc/YHLLbFum9pH5Tyi57rXv1D
WXTFWWFfSHP//Iydk5+f0IvT8sFiBrj+Llm2qutw+HPFeqkeWuQwBi3SxrKolRozZWWBb2xu
uGJEGxUtXCXGj/qIaRyiH7HpH/xc4W8YJOLu/fXNXFeHFprzev+/pqaEkZzcII4vbPS3IRsA
CaPiK7QVsUZ2kiyB7h4euKN6+Nh5aT//x1bO5Ub+kiAf3PsoBKE/SQzwP+m0coydsADScROO
0DFLWpYCw+Wb2lCNaMVaz+8dxUZiwvqzGzj0CjexbNPboUuL9RqAat11t8cip46NJybjJedc
RNecB1KXnfNP67qpy/QmN4R9YXmWdjDf35hQltewbdDO9idwn1dFXWCea3VmOV1qmZ+Kfnvo
9qRYD3VX9Dm/4F/rGQwCkhIt6jdRGQcWIJEO//ETUgLZjwTutha95YyebQPXkzkuquvUKVHR
fVZf+4ohqKoQPH1/28sRWDhtcXktU7nBjLNsIYSP4u93P36AAsNnAGL5EHWsspaSnrhIPaWt
ckXOqXgSaUsxf2mLWqMmLixqLAfL2/psdKfKUm3jsI8oeyMB5/UX14t08cAccmiNuvRFQ3+V
HD2e4yAwZ06YDv89ChYvpzThyhnsIlc5ahTtH+LIrAij7HUnyHfds5HkVNToacde/VPvhmwT
Gw1AtZdX+vHvHzBTk2NCGMJZZcwHm0MNQU9v7kjV3YyKWyncXPorPSBukK19PbQF82J3dkVZ
7bIPWyYMIazjnV8xGxUVV8rWRKBcaq3WNWkxuNs48k35qJOTaDe/d9eIHQuGIPY16tD2YeDE
IUVOXL2PDmzrboyeE7fcJjFJNpNocZPxkWhXdrfCcmOwGbULScAy0KzMDejKFH1k2AJ/TEy5
4PLoLa8QZcZ8zzX3HqCZf9TKRVcnsz/R7edHiZf0SKvBAoVtFnmmJlAMEV9KF/oy1fSh1uKD
JuSgZTDO0WnGMOThkHe0uzBhzcPzWQoeTSLQAdqhNcgTs3S01w9mVUYQNfE9CgbmGydUArGM
9bpkvRfF9NmBwkLLXWGhdoATQ7+V48GP1RLE5VKXv5Tn5JWctp89fK9GtWWELLYhc12nOWik
T0Y7ajcgFbVjUVWDvjvkoHqlh72kU00FQMe6kbNxrIgyAU7CmGx9SDlPTEXfYgarPHxcOev5
4FTpRass1lPPpRzeXevlDMwPyaAsUm2jKEx8SiS8Jcl6NQUPtZROHDAqNm5wNocfB1R/CzLk
BeslI09kOeyUeII4oT+v+Suotv4mWhmwfJihKL1EPkKe4fHC30S6IXBk8++pxG5INoGkl09+
XeQ/YSJWbmQFcTy0uFZfhIkb2bt30NEoc4HRPXcWbVwploJCV3Z1C1K5jkcNHpUjsCemVzKV
h7IoVDh8l6p1lXgbhwKG6OxagI3r0HVFiJ5hFZ6QvjaVOCJ7ARF9DTpy9CwKPZdKfBOjY7LV
yt24zoc8u7Ryg+uVVXPx496WeV/ZLpCn+m6tfhBmljYn/XnMDMO5Jbo260OP6D90GO9R7Ph0
tq8qAhH2lMpbGAUjB24R3ICqRwdinWUJGx8noO5bZY7Y2+3NkndR4EdBTxW9g70QeQYzMwz9
kB+GdMh7M+N9GbhxX1EZA+Q5lqAHM08UOvRFhMSxNv6vi+vQ9YmeK7ZVmhP9A/RWdSU2I6CI
8glvtT5FEHwwBPF098MPAzesqwyf2Gat3fBFda7nkR8+d3FMOjWaOfiyEpjS4UBCiBNvO92A
nCoQ8ty1eYZzeJ418YZeTxWecC0KhOAgvlPUvUInJL85jrnJatGcJ6Sjw8g8CbWUSwwhOYtw
wE8slQvD1RHAOXSjOwmyqFASj+9GFi1lZmKtry3GBs/AQvLN7pxHXu88d1sx05Pc3H2V5Xp4
YYj8te6vImosV1FEUmOKGtOfEmzAPqhZvDryq5isA/mJgXJBUn26Zkng+fSmQOHZrOlSgoP8
PFoWR364Pj6QZ+Otjf16YBf0NVsV/aCGX5s52ABf2Fr3IkcUkZUECDaya58JciQOoYLWLfeB
YgL8fCxRprrW+lptStRfD6tTIOC0ogWA//dHWbP1T3DNVGDWParcjfy1rsor5m4ccrAB5LnO
Wh8BR3jyHLqJVc82UbU2DicW6gsQ2NZPiC8JdJcghM0/umej5xbOsTpEOYcfEpkPQx/Rax6o
fjD5rurlzPXiLHaJySYFrdJxiRkLgCj2qBQg3ZhaQYo69RxyAUHEagA6s/jeh7O75a3RzHBd
sWBtbR6qFvZbVBU5sj69chZqny8xbOhRh8gHjUNnWaw9fKisAV8Yh9T59swxuJ5LVuM4xB7p
Pm5iOMV+FPmEzo5A7GY0kFgBzwb4Fjo5sQoE9m/GDa7JWEZxMBB7AwGFNd02+Civd5aiAcuv
13Y68+E6ZZlkbgrR8tB2XLpsDG8cV97D82UrVS59RxJ6wR+K3vJEa2LKq7zb5zU+jxltXnHb
mN5eKilw68SsncZMZAzLis9iL0NXtL2Jj1F+LvsGA/Dk7eVU9DlVY5lxlxadeDVAjnoqCb5t
Qj8X7J8nGU/ny7JhepwXLZVaJ7OReuMIGH268R80vFSfxrW6mkzogJo7oVog4cOLp2RlWin3
oGOw14ZdsqGfMjEOz/iwBVZ/45zRdOPtu/LyRs4NWah8tBJbdr3KJd9REHwjl2m5PVE0o7uZ
XDen9LaRn7rOkDBVv2ybBh3I4lhWThhnPn4rb4jodPd+/9fD6zfTKcnykTe7Yc6GaM14IGM2
anzSSgOhLwNzYRzy1opbtjtUerxId8KEzGCRSZZCizL6un68ElqpwegRjCr+S1Hwp6Mrqaen
pVTyMXLAqrRPdLthR+qf6WrPTPyZ9UreKft8wEg8IBrpagbDZnOXEoI855aWRYV2yVZJIkME
ipjOMML5ll2YH2/U4vghXJzrhfUtOs0EbYmyAu23GLN4aJlHyiY/dM3UAPrb3kaQN11LPOZS
46md0h3MZda8Qt9x8n5rZ8hRn7ai0MIVMI5cb7eKW8Hrdq3rxdW/2hU9aNhCLtIFLm5IXV/v
nvqod80MhY7Z3Gm4t4dAKxId/Y22IybiR9tItFAuG5VM68c8qkGWCgAcR9FOLQmIiUFEL9xf
tBrBqMtb2Br5xBRXFwm6B9XFVLDIcWNrdfFlVeoZH8xky/DvP+9+Pj4sczYGgVSmanzQzT6Y
+oaWCJ556LcfZg48dObqQtK+Pb4/fX98/fV+tX+FteTlVfeXNi5ILUxHRZU3B67OUJ81Oi1s
+r7YKq9OZTtkZOnbTn7axFOxAt3g0aknVMslK5qVNBOsUsXLI8yQP0iUki4Tl8FG74QWNoup
+5ZVKVkCAkZ38Nc4X3+93KOlqukgdxpvu8wIhIa0tPcjy80Z+msSllaW6MM8fTp4cWRGq1WZ
hsSFQaW9eZQYuLMfRzVK4PQsCSK3OlFjhmfMTQ+kb3emGa5/sP0dmryTPn922WLopKQRVN0i
Qs0WrTHJN5IzKhtxzkT15pxLG3UiMqjEjMqGF5jTqJKpXoQmemDSQiJ96OutBqpLnkRwUJiT
qWJirk9YjixL0oAvFvqCUQdfCEJCYZCmZCtU8c+HtLsh34bMzGXLrIabiFnfJs27C5TwP2C5
sOvh9E8ZcWtARsGdm6Y+6Fbpk3UuIREOa7O7wvYprb9cWNXQIZuQQ7cARJrw7uToZQoyfSY6
46HFflx8RGd3E0TUyeEITyYsOjXemNQ4cSKC6AUEMaE4k1gjDqFvME57D5WsvISR6Khvq5TJ
HEn5xid3RLBppKfcicGyMozmkeRMTtgMyqhmysJpusEmEvucaVtTTi02UXimgCpQzwxnotUB
GjLc3MYwIoxpBFU/eoOxPQeOucrISW97Jp8pIG0oLmnl+wHs93uWZsaCULZ+sqFPTQUcR6SR
8Zh3Wel9PpnFLqc5bR+6TmAJxsZNY11qnhVQpC1tki2tUlFBt1xATgzxJrLN6NiWyfbXzDgO
bYNKMuI1kyWuZ/OwJ1hgpvGVoTOcyo3jr+gSwICxXdaGwal0vcgnBmpZ+YFvLHSGCb2sSAhT
bE27GB3VUeoFLuoedX/LK1YF2tn9RHXt/cZtnOnL5xmmb9RHeEPHghCgYlO90Ki2IRI4K/05
W2OPtOnsQ+2I2TucnP/iMs7+rm3hEcECjk05pJYYRQsvOiM4cB8idX+wvWpb2PFok59s/tME
sPDtY8vLYIWrosNtLjwpG+JYta2QwCzwSQtNiaWGXy0h6HnAllnjruGgsqCxtqUGXKf+oJ2T
Er9aUV2H1ZDAhoTWNKFvQTz5BkJDSFHs0jrwA7oO4+MnotlFXya+Q00iCk/oRW5K5QwTUyi/
upAQWJ4isqYcISXCDZPPdE0RI2c7iWVgvvAjTaVHY+SINglduFDZgzVjtRhUw8JNQjWAQyHZ
c4vuRxeLOuDHlYuTgDJy0HhkfVCHYgukKbESBgomPeQQ8axp6Eroj28kZNE5TWx3+ILBL0ns
GMeO6vNbA+P16YvzJGTePLqb+mJ6ARcNlChYqKyr5fZe1aYOKVmEelrofVDFUUjKVlJMDQxU
lsCF7rJgoefTw1ZoZ3QvS3oeIYFJ31uVAWdy7dXSFTQF5TrYB9+M0ApW66Cv/mzZRCwZMqve
hpEm+FMh4edgOdb6/vjwdHd1//pGhCEQqVha4fnMklhBYVksG9AbjxKDdASLLFmxLwbQERYe
aw27FN9tWYrqs84GoTSs5cMfQ4cO76lr3WOR5Txq15KlIB03pafT0uw4P7RSAKEyVUXN43bU
e9n4WHAMh1pxmAW5Y+gGD/4RpW8PO7z+JKjHil/8zn3Iu888i+QNx0gwWp+fHv+8v/tuetVE
VlFRVqbygYkGyGEaVKZ937JUJVVBqOrjvELD0QlXItvsy9hixzeXctnmNe0/cGFhGCSQ2t8v
HG2RukQbLtnAekfdyCxgPjQVZUexcOyKOm+LM538U473nZ8+qPyn0nOcYMsoQ/eF6wYKYgPV
gpumLvTOEEiVdj1J75LIdx0yTX2K5RPgBWiOgZtYAH9DC4BDF+pBy8IDGwRPPoBSkMh3PCuk
WjUtYJ9vHMqsSeKoEyhUNmfTMUuP9iDrMxWfWmP5ZEkOPwJy66Lz2JrGQUrn1HlCsm0copuN
UEh+IvjDDSzS+gy7DCvALK34DBr++vfao8nThsx4uHFdny4TZ5vYIaFDjWHvKGgIXcvnD1vA
jj4fl3kO7ZBTnuwknmMc+OQ4PjJHeUIvIfBNVxRwLjru9ZcV5GzwhflnY/C2liP2ca6HuZFS
4THll84PN2aG0AmnfAs1tEqn9zxybySKBI7hOC1T6cvd8+u3q+HI32Mbq5VI0R47QJUFRgFM
Kx2F6zoDPn2ZhnTHoteicQuIj7LQGa13V4S3byLHUY6UpDb98fD07en97vmDtrGzBxrhWa/e
SL6kZT9H3hJL+u+Y4b/ulDJ+00rQ6gnah/YaXzhVfv36zr3tPTx+fXp5fLh6u3t4erVlhR2b
Fl3f0p6cEb5O2U23M8rBDK+zqrgC5W3y72Vk3R7KPo9Rv7OMxi4t6v46zZoTMpnKH7oMsGud
oIbNbkqoMIGj1NNdfmGsoOowcXBbo6W78I5KKM5ydgt13XUaVmtWDkWtLJXnb+utFT8W8Htl
pB4LKMPaKJhvmkyVKerZurwoYwPQ1AmxiuEldhkwrqqK/YGmAGTni51AmqXtYGn9/EFsXOM7
GY7CtZlSdxEkCPSzrkKvebY8Qcv2tEPVhU7sCjgdeqppdaVfpKAU9ruX+6fn57u3/y4uB99/
vcDv36E6Lz9f8T9P3j389ePp96uvb68v748vDz9/0zX8/rDNuiN3rNnnpdAGxWTzC7/Zh8f7
1wee64+3V/hwMWPumuv709/KfkFIrepbX3ENMsq4D/zS91KdDltS8dCFl9hl/Vze5ETs+PTw
+CpT1Qk1TSN3sYsWzFi7O6XyxNQYxBtHTfb4opbM7r4/vt2NwpTmLQ7unu9+/qUTRT5P30FS
/3n8/vjyfoWOHmeYC/QPwXT/ClwgTbQGUZhg3F/xflTJ1dPP+0fo7pfHV3RU+vj8Q+foRadf
/UKrIcj15+v95V40QQyQiVECprYZr9mXSaYaksrRHhyoqM1bi8o2uC7tHVRlOzoe+bhpYQLt
P1R9SyhgFHmUDqjwJKHypl2BIgvUfQo2tU0MwylJyBtC8YlpG3eJiN4tW9m2ScaGLI09+bzO
AJWrRxV0AXWtaBLLz/QUME+DKLSl5KAlZTV4ztlSobO2MVIx2LxYWnlmGytWsc2mj/n7LT6u
h9fX55/oGBC+ysfn1x9XL4//t8x70+jfv939+OvpnnSwmO6pcHPHfXpJO8nIbSRwv9b7FtR/
V3JpjWB/KgZ0stdQN+uZ7KQ1w8Wthcn3bPpz5hj3RFHpKTgVZusdrt0qdlP1o69keawistui
u/fZsJ/8GJGvbNLsAnLOyGVOYYWq02oVgsMwB9nAG8lxer2C+UabvqQ0wrE16L6h2irhCLZ0
VbfkE4JRAnBQJzF9JmTwWaIqIx8oDfmKcNIq2xPuwFPWXv1LLJjstZ0Wyt/gj5evT99+vd2h
2d+8DlTZVfn05xuu3W+vv95BQ1b0Fiynbg7HPKWdJfPmJOTrS4SO+1wbL0cYFLrcjtVpv7OL
a19ZjhQQPGSlnl3a0xa0iFX7dO9ZfAggzooONluXzzA0rTyfz/QDD8S2Dbum1DveTBFVAPpM
FUk7xovjcs+efv54vvvvVQvL67M2Irddkcnuj+bEC6LkUUzRba+2b08P3x617MRZdwHbr/qM
0bl1OV7DzhF+bC2OQfh3VdS3mUXr598vD1FkkYeoetOhT1c+DVzwicFNrzYQ/UvOIQqEvvMG
GsPVn7++foUPN9M3nLvthVUYd1YSFNDqZih2tzJJ+v84t/CZRknF4N+uKMtOOZkcAda0t5Aq
NYCiSvf5tizUJLB9p/NCgMwLATov2Inkxb6+5DWsQcrmHsBtM1yPCCF5ZIBfZEooZijz1bS8
FcreAIgVbKzGmV4FhqLklR9E7Auz+/6afOETT69QmvxzJIcXoG1Fq3GY8Habdx4deQ7gtGNa
01OY0qHR9MzB+7QfrCAstBYXfgjmPe1lBbB8R1tk4oDV/BMtyPVeHSZE4F/sKDfjFrZaO4Xz
e1uhsLe1YgWoozaszGMniGjDIhwf6dBZ/JJiofZlDjtmuHU9a86pJeQWCsASXx2Q9GgzBUK0
sA44m+N+lGvewJda0FMl4De3loNWwPzMsvphkU2TNQ29q0F4iEPP2tABloXcPqbTjg7Lxj8t
a6Ys7SqYXS3Tg27dyWk9O9hbCCu4dchtYfU/Dxt6+QcG0xMb7yVuxKXVosphDNZNZe13dMPr
kcZIfFCMeyO1YZFLu2BkN9zL/qVkmXnHi0Rx+yii/8i5IkadpRk5axkYuOFUWarUZNhoILqt
1YIsBtNzVReQ+w8jxbrwtFWcbNzLqSQdhC18fQp7j5Sqgm5/KJWftXEsm1JoUERClL21IqTQ
p+71pKoaph+S+BXX11K2x8BzorKlC91moevQjgnnBnXszOqaynu0oFwgPI6Whl2zVwzS8G90
V4VRbuDDIPtP4jHWOJOFlYfB82R3L82hlj0iaH/MIZUkUssqlZBVaV7vYcIxoT7/bHwBSO/S
UwWrnEr8lLIbkzLFfuWb3eU4BdCm73F/Sp8TiYpe7JEPeM1v6xTfdXA7CosHm3qeHy4wlcGX
RIaPwOK6hl1k1+lIPOLTAgyoDqAdw7hpmkxVo4+ZNCXSZYFtPXeH2rS3lQusYOOldyf03qXf
bw87o+cOeMPQ6SXxLj1UFbVnmHDsWz3SmoyZVFgRTKBqDxvHvYxh7yQgZUl0me4K5LaY9xKc
vFJd2GDJRrZcTGRdhjY96qRePWEQjRGREd0woP2+zO3SvioYYFVae+cN0dTR8bISO40AJwcT
i/8MMTQKvZJp5saxxbUbl0nv27z4CXjjrOJFsAksx7yI98V1S2vVHB6K4mzxOPP/jF1dd6M4
k77fX+HLmXN2dgyYD797+gIEthmDIQhikhtOJmG6fTqJs056d/L++lWJD0uiRM9Nd1xPSQgh
lUqlUtUI8w2NJngiMFWep/HBH2DNBcgB1uSO4vBRY5sG7L60LI0yDHhQeq4m7BBDib80lpr4
rACnse6CGJeH9R3TKfSl6crUhKzuYZ2XFIfLWrMT4jPMLxJ/pke3PBKTFk78u9niXfWaSEtD
9Xq4q16Pp0p0fhnU7CgAi8gus/DbDQDHbJeuyVN0hTW3H68MIe68Jdag/2xDFXqOuaTZAj5T
wYEalqv/eB0+8wBqrC39jAFYF2KSwZN03hK6C6lekgCoFyFMZzFc3SnUgM8MKn6r06v1/TIw
6Juwz4qtYc60IckS/eBMamflrDTJwvnI9iPKdlyaEGN86NfanLYMPqSmJvFgt+zUO73mVcR5
yXa+ejyNLP17M3StfzJHbX1pGmnu93AQPBlv42Cm3+b27J3+4Hva4HJX/CdLGN8jZ1QvHW5r
09S/5F26wUJF7MLf+MGDFCKIz4U+d7xGZQE8LyLuWcC22vfRF2cl1wDeNRqNMFPUNDgL5aqL
nGW4R4YoTHPbiowntoTb1DhA7tma4ZrGOq3XnmW7PAKIlrUobWdlIzx+mXbXv1VNfEyEGJtT
bVNMk5hOvgA9k95Z4q/zZbG5tO3748NzuyB5dXUmOL+8nF8F1vMbHAm9I0X+JZzD928F+aB9
WiCdDgj1VfV7AKgOyMNY3R30UNTVpswg0sRpzbSoMK3Q03UQfiYEp3ZMY9l34aSCLUrkBeMD
/swOzSrM8Urkyv2CDWQ42ajUDUrPwV+5e44W1RbOY1qyoQR5lyBp9AEiv/kEbXIXXoCW4OaZ
sA3TNAoaLdPT4+XcPrePH5fzK5xFMxKTjax877cyTfHeV1+Xm3zryx18XzdliEwnnisW/s7H
XKV8g4W4e4gzGNmEcSz0q6Yq4wT5tIAZrrr/uSK1FnFmEDlchoi6S9F/e0T2q5XtYR+FITYe
svnK0LnrIvQV+ijbEpMlCXTb9hB6QmzHtLC2BaGptSaPPGVD8UBbPQOhlp1YJlZ/B6GRbCWO
1bTVHWBjwMpMsH7hgI180x7AP2kHaqtD+pkDLtqfAOGBagUGJX+EiBia69MiU10j37gHtK9o
dVH7sadaKzQ7x8gAvnPLaaXdeojQ0xhpQkRdw5oaNzpECZqNsHgWaokUGUykVzq6ell9VAzK
1EEvVVzF6SFrir21tJBRkPpMFVh6yFM5wpQEXwPZS2S4c0R0bpKAtalDLHwgdtXpDEacg6be
2nCaIwl7vwDkCQJPfwluysSUEsPxDKwVALne+ieDmnOta7xmBuCDGkDP0ZRigLaUtXSQ4dwD
+lLsHZEPOiDacrZh/q0F8FJFwkQy2p+gWGqOnUUWPACywLBCxCrdlonsCjci8Tb1Q4qoxgOC
v8eIFhH7I8deqDtkY3pznsSbGA8YPLIWG9ABmRo08eoeeUCRmu0eSlPT0sQpEnmcpS4yicC1
srEJy5Q16f6LSLdRIUzLmKnRqB96z1H61LRtdIllkOb+r8jhytk3JcicExOMgykhiMAq2QKw
MtZorRt/7blzq0qZ3Frm0o+Jieg9AqgT3SMLXCb5J8+xJobwCYwP4isL8klLavmm6UYY0q3I
GsRGGnNMPdtAph/QsW7idE09Hl6PayDaEdCxxRPouBjiCBrjX2BYaR6FTwGOzOuh3Ft/XvgB
C5oiUWDwsNW3o+tGG1xdx9MxCAyO7r3WzozpqGdx5/YHnAH/QGvPxp56z3fLayfH3dkFHcG1
ERUO4kpgevTBrzx7hQytQ3c+ogFMRLnuAFQhLHMfckz5M73WrRpEl8AUeGpUJApWos58FYeY
K/ZOvnR0ve2Fs/M7YjHm5cCobPseDo8b6gjOjC2/nD/Oj+fn6Y4Y6tsHwsk5v4ueVXT094Sl
SdMY2Hhj7QfX0OdFTHfagtx4wBg07wKNyHYkln0G5UZOPF+AOGYLEWh+QdhzfNrsiPyeMpty
1shLMqW8grDYh+jY+wJMA5nLF1ag23uLl/rZhhD64McYa7yIOZ/2ZF/snXKrtpaRmuMuZj2r
1K7wBAl36qBls6sCrJINxbyDuoGh9O1x0o1H/hkCf6PWPALTc/7rgD2/f4Ar+cfl/PwM/rfY
cCWOWy+Xk6/Z1DBgcGoYbImfIwDy0Tv63I1D4Ir6h2kZsroyjeUun2WC/K8G2z/stNELNuyD
gKVx8l4Z+rYDFXuxEaMUT0coV/CzHqiQHhBhwzKn7aOJZxgzZNYjmQwVnu84NhOlXSF5SM03
YXf0sVJIFygovygKRxyiMO3zFJDnh/d3XI76JFWfxf1j0L0Gb3+oXFEv0/Hu4yEro38tusvi
WQEepU/tG9zvgStvTK+LF3/++FgEyR4EU0PDxcvD52CDf3h+Py/+bBevbfvUPv03e2wr1bRr
n9+4Pf4FQtmcXv86yy/S8ynfqCOq7j0iBIcsZbQXO6En8VuXuU6sjFX7pb/xA7zyTRFFJEtx
MKahuVziGPvbL3GIhmGxXOsxOaWniP5RpTndZXopPjD6CVOP8JNOkS07RGVWyWGBEba9X6S+
rk3DpV3Wi0Q3vAfe6MA6JnBMW+m0yqfioI9fHr6eXr/iMXDSkCjheTk1JpD1AHf+ZQxxro+o
ycvzWRgWuLMzXyCPBFffexDX5vjSsYuZihRh+Z4Gcew6So/0xKnQ6gCjqcJJnI6xDMR1LzKN
/6rIufXDbTTlRThDCCEJfOJ3AgULF0oVpa6pzgzu6DUZRp37F6NQfSt6pokDsICpNz0FyI8L
4gc6sNhbbDVEsSBK9vLRmdjinYWmQhRYuF60iyZyoEPB3sikN4mSaKpSDg/J2TJc41A/71IP
haM0jybKWo9tyjBmHYYGV75y3bJVsUDrjnP/Bgdw/oiNMu0rDmBTxii+8QxTjcNyhWwL750t
9+jXtP6I06tK01/76I7m/qHJ50SqxPpTtoRiXrEiRxbEbFSTUtOmlJRNZWpcPkQ+uCMw/6g0
o65mtnaYYcMJsPYLAo+30pSvKzXkm4Ae/NsUvZUl8OSJaS0ttPKsjB3Pxsf/DfErfGjcMFEG
OzZNm2hOcq/WRWsamPxNpCsPoUhyPwzRWwGSxIqKwj/GBRMAajy3geUuDbIEhTSzhV8Sk/3C
BbRmknCizPSy6ujrJF2WqxeaEZ70EDNlAv9MrDxR93BDiyBdXpPqBsiR7daDDL2ZI3YTrYyJ
HtZ/7BIXHVUeut5m6Vp4sUHdHJc6eb+N3Ozj27M01pjCetTETDZciQ+rcjpcb2mk6LxFnNnq
mybRNivBpVkhq5rDsGCQO5c4k+BZ5I4ncNOpAeFgnRF3ibCMRIlqIuFXZ0KmOCT+ndIkpUVl
4R9IdBsHhZwljz8xO/oFe12F3N/IV3bFlCkxfPu0ieuyQgPHdMoMXCrZKOL/jhVQuj665+9X
K2NnV4FmE5i2UU9MGDsaE/jDsjUpSEWmlbPE/SB5L0GgMNZ3PCDEjMWG7PyMsvUGtWnk3z7f
T48Pz4vk4bNFQpDwbeJO+D6HLOfEmkSxGjcyj7PmVnI9K/3dLQ/FJXbDSOw00OBuMD7N6qGW
Puwf106VtnQaK7Id7BHkuodaDq4sR9oIkRKjGnuufwbriyZksvuLiaDDZudQpU1QbTZwv8IU
vkx7Ob19ay/s21xtTqokGQwwlSZHBn9cocKioOgNGIq1sfZNdxIXLr2dfQ7Alm4tg7TFa2Wa
BCHptyddJq/nhw+27X8Z4krJgxCYMSNoGtq25ehfkC02pulOYpf2ZPCF1L4Q5/FmIphmezxS
AhcNW3Ops3PyazOY8af7c4N7yJZ3uT52GtsT0d5wDSZCZduc5LHsEjqU6WOkCMAxkH6AmUpq
5bEzbGHtYFBsrLylmOhDygmTkiZIMlHnGEm9PfmLNyAQTky5oATMvVzvbNs86lgXeExvmx2b
DsX1SRMApSH+ZoAdAypnXILGxJsUjFt4CeGCrlSKBK4uiwVDb3l45DRFc0cAXgWWFIonhZVi
R1RKuIsd9oWX6tMHk1eF2hh5+2528jzjr5rRXRz4+jxKKZyWYZEy0yiFjMWS3W2gaYztafty
vnzSj9Pjd0yFGktXB65EM22lStFY2ZADbzLk6EiZPOyfjKLh4fzjp/hUHZn+4PamQ2NpQuKM
jAWTjjOdJ342YS2OjkyrC4V5Db/GuM/jU67UZsP+xcx4nCUoQO85gPK3O4LecNhG45Ed3F6e
qAe8GL9UvVQaMU0hM5CdFfamHFUj/HNiTvy1LXtVivSZPGfApUms1DUGUhqtpm1kZDTtQY/a
dl1fz/LUsrZtYorKFUU6hZGdmQd6SmCB6+vbmM/HCDtykiJO79PWQCbxCtNtONN4GV4uO8aw
1w6gkK2X03JJadlrzG2AoyXxIay/8tXLhNhrKW5qN0LGfBOTcWXbf2vHlZCgTBnM/KThz+fT
6/dfjC7KarENFv1V/R+vECqLvrWPJ6aGwWnwGOQRDrTLXXzYpr+K4qHrBlDN8bOprjlJzbpS
11jIrKO8NSRI9YJabH15OX39qsimruPYJN7igTbBiAiJMuMkLu/ELozZvwcm3g/YWhaFPmnY
V4dTX0qKShBAHJocdUedU77I0wVD6sL4ig/moO5mdQ+Ck1uTyrEiujaloYNvjzgcubaJS10O
x565djXJxjoGS3cXt4d1wbQ6OLKMWYZaczWvK22vZiu355sGSaFnYNfCMyyVBEJOXT8dEFJi
rBzP8KbIZJkB4o4wTeEOXxUBZ1iZ7TDlBtBhuyYVOdym0fS2D0MWpyHIlxxvtuT3PzbaoNEj
A8QOUJ/GgTDCkqjyFha3kg4K/ifQlMnKODB3Ca1quet4pNcgsO8jamFIjZYIKdsEu2qDr0hD
okNZFXhUIJEVdbISGBwpXVJPh1TqayklzhWYZBoSIV2eIZFHk5hN5sEc7QaOgtrEwpod04TN
Q08HmEiRmtFt7HVysgEPxJlmcA45y5aIWLI9TcIc3Bwk8XjzPOnKKPHkQz1DcGOZe7QFPE3S
bOVDepy5iXHNU6h+HiR3UQ9Rpieul9ih58CxSftLG2qlbJoo6XquiO1hWphYVMyBOtCj1FqK
NwxGfsjZhDffRm4i5rFeKCD3wYAfoiVPhQkyfS3lMGc6TkzDRGdjcctebi0fQMuWl1lJRtKM
okLJFO9gCXTbQEYC0G1kfoDY8exm46dxcqeRcYzhZ7LN0UTfEFhc00PzugkcKw+d/wB5Py9s
4mXNlcaYO7JwrfvnLLMNmKSoHgdquTfc0kdTI47ywyuxbwl0C+0RQGzMv31koKlj4j0S3KzY
JJybpLlNlsgQgmGMiIMxSBYmO3m4q8nAP7/+RvJqfthvSvbX0sAWviHr3OhB2wX/1s3hEPKj
426aDAqqjeCb2RehdwfCzdDXp9Mjp0pGub44ovFX9fWEZeTfhauVqzFs7il7V2yQwAVcn5I4
7k+MxhI5xDLF7IFyEsgK7qtoLqUAlkOXbqNDXGgSQjGeENIo/ITHjzQmakhHFhUk0wRH5G0g
8eA8ouU5RCWa3QaKF5WsEQMx3ThonlsIQ4DmewiyeltFqJNsF0b3Ohb6sLpseyu5JPTkHDVm
9mAAEQfU5Cgc4WHB9AXTVP6uAnmIPjvjjfx4Ob+f//pY7D7f2stvt4uvP9r3D9Tz/C6PCkwL
p6W/7UKqjrwkg4DkuOD0XMPErfRFSW1THuqdSh9ni/eP3rNsnMVdyOjHx/a5vZxf2g+R2qW4
gZDnfUaYx/MrK/YhyRM/dB0xnnb3u4k3kEN3uDj/Rc6aM9T35+m3p9OlffzgeQrQykvXMqTa
OaG/yNEnUnh7eGTVvT62/6Cthuh7x3+b0m935XwZYy5D09h/XYX08/XjW/t+Gvvn0H783/ny
nb/U57/by38u4pe39ok3hKBPt9fWGE/eZ2/9v+2ifW0vXz8XvOfhy8REChkfRq4n3y3vdont
+/kZrDy6Fx5r6GJaaiKSM7DeTmN+0Lf24fuPN6iRPaZdvL+17eM3QXp3Q7ULly8OWH6fuMtZ
EKf1Er/0kkl5G5T0310CjfuskN1i+sHzdDmfnq7tGE4iuluD18+4pQ3EMQiyTD4rP8Rs60zZ
mMQs0pl8sA6/G6JsmGWUSUxNRc0QJVEuwF9OV0RNuA20SuMzvqfuUnPWsi2iu0ATX5lHLGdi
WNuOct+fbF2bwUh+FDX7sEqx7AV9kQZ817NknOfbh/fv7QeWjWkYO1uf7qOy2RRsKByzAjth
qeOk8esYQmxvhK8bFdmGSkfTA0U9Fh/ptV+WUlzCEckzCtHSCR4UcmSjEamKuMRiAo48FY2a
25Tt6fOmELOg9Qz8Fkp8+CMiZSw6A43lYbHx66aIyiKO6Bd7wnAf50gxklQQo5GJ2m3UJHEa
l18MrGhzgCRQZBeh/QAMHIVZwr6kj0diQviDGfbac4QsS9PFc9C00s4QK7ZsnNt5nOOOvGRX
sPVxrF93YpUk/iGr5yLwkmQP3vxMbdhXYqhVCJDIMAhjxGSGoKp2ZySAjWtQF3+HPJ8fv3fR
0GFluEqqawlEnRdAuLG30uwGBTYa25aN2QFkntUKazObqyRyxSVbxChEWG9Irmlgn1F5/tFj
cuqr1nOkeXyA48mJVO/6jJ5/XB7b6W6FVRfdlmDUFjfX/Gcjn38yziAJVc7UjxMm8SS9nmBm
WjiGhCVJYY7ZW1VYerZ+GX45f7SQuQq1bURpVkKSLzIt+Pby/hXZm+Uple3EQOC5W7D9JAd5
bu0td5o6+GUsRvycMDDCtPZO0UWHHF/GwENzqiKwl/qFfr5/tC+LjA38b6e3X0FPeDz9dXoU
zpe7hfuFKX2MDOGpFM0zuJwfnh7PLxh2qPPfr7Grbs6X+AZjO/1XWmP0mx8Pz6xmtWpBDSlH
S1V9ej69/q1wXsUYZMStm1uCK9w5l22bIrrBloe6JFzc8wqjvz+YUjXcakKO4Tt2pvcRHstY
W2HjF/F9dhACVgz0OjfFmCU9WQ5e3RP7C6GH0lqtnQnKZJFlyXdxrghPc69vHefwVhZeWLV5
qyxTq62MF6W3dq3pu9PUtsXQTT158OETpAKbmYXg/BeLYAy7SO63htEaEqBkcCzIDuCwoRTb
g/bSSOGSgdwfZ0Yh+qzuT1HHEcpMWPlTKVxxHVlMkYUeJzG1e/K1RnwfKGxE6sRydSEzgtQ3
xIgEQUrYPqu73IFTVXU39HUeaaFvoetNmPpFKF4j4wTRnsV7p8hoE5H+od1x7ZVjX9NwrfyU
o0Tsa/LH3liK0btSYpmW4n/kuyvb1nQOoI4juTb53kp2Q2Ckta2JgNxh2GRLef4ywdzPCI4p
T1la7pm+gUYJYEjg22Oawp9s94Wh4Jpr7IswYL2WVk8QRssapBn6Zp2sUuFhPScG00QMQIVv
nBxMmbKrXTmlNkT2rfXPTEpirlzUkwUQ2UDOSej5HJNihuVIika9duSWpCS3VmiAhjQ6NPdG
9+piiYNfubjtuBOJTIxJL8+X9ltYLKZuOxyjeRo3Md7BV4bbaaWczsjC4Co5YekZRKalbJWo
5Y9yy3T2IsjYfOzp4gDbQM68RSQkzfNf3p6Z3iAmx/zWvnD37T7tpDT+yoT1RL5r4OoE6rMT
pJEjiyP4rYocQqiHSpbYv1GSq95769FJZXd6GuzhYFHrNP+rXgFCJ6V926hop6I0HwpihcBq
IBXCsb5l/a7jx6tosBssVR+QpJT3tW4G20sHs80wwPIk0cYoqxUaaCO07bVZNIEvXovgVKuQ
CI7nyL/XjvyGIV2t5EghqWNa6Gkgm2W2ISaIJPnKlXOYsCEZ+sS25Tk+WkCffry8fF5Tll7F
BnRzF3ZkEv3/P7ocV+3//GhfHz9HQ+C/wWEqDOnveZKMA5fvZrZg1Xv4OF9+D0/vH5fTnz/E
BH35t4f39reEMbZPi+R8flv8wmr4dfHX+IR34Qnqx/36eTm/P57f2sX7dG4E6dZwNE64eWUt
7aVmkepH2fauyBoLjC6TAcghOOQd4GvXlf/f2JM1t5Hj/FdcedqvamdGlxX7IQ9UH2rGfaUP
S/JLl8fRJq5N7JQt1878+w8A++AByvMw4whAs0k2CYDEtbV9htROOd7/OH3XtvAAfTldVPen
40X2/PR4ejauSONotdLz96ASOpub8c49zLX3Jm8/H78+nv7WZmZoN1ss5xovC5NGN+ImIQob
zTUlaerFYm7/Npdt0rQ6SS0/GrIYfy9G4SphQZzQ2e7n8f717UWV732D4VufT87Xvk90k+31
fKYyv8VvuqZvauivOoLhJGmdrcN674PrLCt9/Pb9xMxmUEos6qBv689hVy/1ORXpEvNqaYAy
rK8NH2+CXBtVfpK5lT8KIazvR5AtF3MzKyGCWLYBCMP/Fn6v15fGs9tyIUr4YGI28ySYG5hz
nS6uZ3POlGiS6Cm3CDLXPTM+1wIzteuH9Wp2aSyovjW7tlPaVJe6+Ti9hc2wCmpj06zMwrZF
2Sxn+kMlvH0xW9qll+V8zidzBYSRU7C5WS6NfFBN197KenHJgGzB2wT1cjXnfQYI95FVV/vp
aGAqL3XNiwBXFuCjGRoDoNUlmzWxrS/nVwvjrv42yFO7XsmAirJ0PTPzu96m67nn7HIH8w7T
7Eqi7P7b0/GkzlkcHxc3cMLlrwHFzez62lMTuz9hZWKb20xE455b2KfeQI3l5WLFjbxnEtQ0
LyCGt7oCYvh0SRZcXq2WdtfUjLz9OD3++nH8SxN58unhx+OTM0uEG/yEL35Do+bTV1B3no62
QE8qKuc0HHM9w6JkMVVbNtpx2GimwfABLPvzTkPkmGmfqQe5/ev5BDz/kT1bXy4+8v4xYQ1L
iz36geIDTMjUhC51F7WmTFFI+roBk3bSAx6y8nquWIbSUbB6PMgphvlvytl6lhnXlJusXLBM
OilN7zLQr+Zz70G5TGFlGspcVl+uPWsdUWyOwn45UrCvs0hVCLAhFpvLlR5fn8CRda2h70oB
QmXtABw5+YTmW2uVli/Pfz3+RJUE/eC+Pr4qM7UzqSQfTK4uQ1FhJraouzXdjGI0Us88yfOq
eMYaXffXRtw00l2ZTOxymc727NZ819isNuTx5y9Ues1FM32udH89W3u4vkJ6kjk0WTmbcUcQ
QnzU+f6h1qeQfpusPW94g+ptFnU+q2m5cz0h0VEH64u7qfQFVreWlHuxy6vJFCdLLE2nghWn
fUNH5KYM5IIVN2PGjiJozNQxsIyjBu/+mqpIU5YjxaYlF352sbiJfCZtxAPruoUXevG7Ctdj
hDYNPgwEifpK886clcnhon7785WMBpoRv6/eoaKxp6kJsu6myAUFnCOSuxRJDhjS2y2u8oxi
yzX9RkdhEyYqKANR2vHbiKDLDxWqzi8Gk0byMhapGqAADY/7rFSAzUiNJ0M4dyrjsM7Sje7B
T4/rE2LScgo4Pr6g1ytxmp/qiOWu00roTq+i7gIz43KTtHmIlzipa/aaHDEmGZaHVcFmlUzl
Jr8NpZlvZMigVlohEMM2DZHCeMBTqTkUnNMahVbow6Mqmv3CHS9ydhenl/sH4tpOQYxGr3jR
ZBhS0aBzmVpk2u3qgMIi2p4KP0DjLSgIuLpoqyAaMkCZr+1xSSSqZmMkUtKwcVMJM4xIGXYa
LiASHWOMCx5l9yyr7lyKMCoLkm2rgTy45ZxBiMquaN8bz+AFGPLUlqluwKAnqmhreEQQMIxT
FwL8xSzYq8Gxe/6+D0Sqd+/TqT75xohUIm7ZrvgiiZX3kcoqtWFDFGtZ6Omk4RfKC8t0Vacy
M6sgAUCxpKCpRgec+BH9tojVampGqFw2dgVezFLQnDbH6IFiZXGP9s2iY2ONALM0fXAUYHKo
cVGDE42BWXVW5ByC0JUmLip6P//ylf9dqzPvivKgOpSWA07/iIEz++OL5Pu8CQ3dDH97ieEV
2WbwwBnFuAQZb7kzjUAgDay8jj2GSsfKPOa8uLQ2XccnHcn6PjF07lx+Hno8jfxdX6rP592o
PmvuW+YzjWgkBovzAnlPXWEa3Mb1wuokVtT1rOdNUzljGmBnJ2okoo9FnHdbWWGoIw3W261F
DmgKtvN3xJkJBRY1fBReykzviGJMAiNjPl4ul6l3EuKFMwcEwk/QebJ39M+oleZrU82NvsYJ
TCZtoZulVWuOq9z0ttoj8X3cAN12bAajYH1+jqJkZ0KCPoZ45ZE96Fmg5WCY+MGDt5nICM6L
Br7HBAltgFSAIUZ6Gq9QCM581xaNIckJgE6p5OpDlxrog80rqJght39iJ6ochuF7he1U+SXO
mu7WuDZUII5TUwtBo32SAYIWy1JXaDBXbVyvjFWiYPaSJOnAfbUC1n0qDkYTEwx2RigrWFNd
KI1J5khEuhMgrWM4XBW7s6/CiqnR3tPeHj4sjeJ8E1kEc1KUh0+jS/vDdz3va1w7nps9iPam
Z2f2FAlwz2JbCU7RHmgcfjMgig3uws5Obj5duSOVk09KDSL8DbTtP8LbkLQRRxkBReh6vZ7Z
gqRIZcS/6w6eYL97G8aqFXXTVdR/xKL5I2/498bEzLRdXcMTBuTWJsHfQyJ5DNtHX9tPq+VH
Di8LPADD6fzTh8fX56ury+vf5h/0HT2Rtk3MmRHyxlIICGBtQ4JVu/HM93p8+/p88R9uwFOd
eW3/A+jGVvd15G3WW5rNZxS4dyfqPE7hRAnKrrHxCUhOylkBElBPbEeoIJFpWEUa37yJqlyf
hiHLQv+zyUpzUAR4RwtRNI6wGvFJuwUGumGXGZwp47ALKjiH6SbvodDBVm5F3kg1yAmv/tge
67G8FZX1UTJZq6A4TCYQZVwXgLujs7xOpS0Je9nA79uF9du4jlUQj2ZDyJVNXu8EXyBZkXf8
ZW1VFA1SeJ/s+Y0Xjzy/T7YR5uzM9ES4aODsC0RWz7m7iW1FQUqgLRVaakaU6/ZPNRPau+ya
F3WbV2Vg/+62+hELAKABI6y7qTamm5Yi9+fxCqIy4aVeIM1lhL+VWGBNoYjFGLkdCC7Sx6PJ
Lc5sYxeJm67c4eJO+D4hVVsG0Jwf71MMCenInQnKXwZPeGI+lG/4DOE/6N+5lQe8XvgUX+Ec
PEbUdcl/qVw3mcOPQRDwkgIJBmHTrZa8x6xB9PEfEXnsigbRlSdgzCLiv5FFxIV1WyQfzWmZ
MGbNJQvHmXMtkoW34aUXszrzyvfHsl57G772Nny95OwbJoket2g97Bvl9era15mPzihBucIl
2PEZS4yn54tL7lrbppnbr6Awa2/zQwd8n3XAL3w95+OfdQrONKbjL31N+z7PgLcW8AB2vvg4
Rs6maxCs+BbnThdvCnnV8crMiG49b8tEAKI50zMYD+AgShvdoDLB4WDZVgWDqQrRSLatQyXT
lGttKyIeXkVmRZMBAVpnyqfzGinyVjbcozRQyaZbH0iatrqxMlsiytbTJ+tDyiRJOT68vaDF
10l6gLJK124P9XQInrRsVacKZhkp4Ji+5WXMpm+CRfa3EFHoJwFEFyZdAe8TeF3BUw0Xdpih
oCarY1PJgC2X7lwSDhBTOxlb7FVZ7viA/KPBihW47FNhXwKNTcDUcSYOCtwjI2QOM9BScoTy
QEpP0CfanvR9m4w7JBcVXc4oc4s2QLyZDOhJLFuURGmp2zZYNPX504c/Xv98fPrj7fX48vP5
6/G378cfv44vH5gh1pkVBeSSNEVWHDzxWwONKEsBveDZxEiVFiIsJbdBRpKDMCvhjPedzEPD
MXdaRHr+PBv76cOHAbUvKnU7p18FUcoQ0y9bweBYFpQHG7rXD5gKVH6xIZWQ4RpWdVBoKb9p
6xTjVczL379OzxcPWLPp+eVCfSktPpGIYW1tRSntNnrwwoVHImSBLukmvQlkmegLy8a4D6HG
zgJd0kq/wJxgLOGorzpd9/bkpixZoNsEskJDtA/vrbkcWj0yTJgnoiDk2EKPBSEgtsx09nCu
C7iF322wC2VNPItu9p3mt/F8cZW1qYPI25QHuvOG/PJLG7WRg6E/zJJqmyTKAwdey8wl3qYt
WpqJS+2vxiwY4u30HT3GHu5Px68X0dMDbgjM1/G/x9P3C/H6+vzwSKjw/nTvbIzArM42vCrg
3UeGhxI4kYnFrCzSw9xXzHncNVuJqbr832egcGeZMIvLNY+AR+AfdS67uo64ZTE2rJG921V4
3T8kB3bd1mvWGdOioE/nLugB23efwULnZ37M0CzbMSKwh+CjE7d7twd19EU6bBc2byJkTggV
IEwBFSglX93FtXGXdhBvXFjjbveA2aOR6XDTQ9OKMwD0yCLmHimhZ/5n9syrQR3bVWR8V74p
96/ffYPOhDvqRAHtfuytftj4W3jMUWDDx2/H15P73ipYLpj5JrDyOOGRTL8IDrOUAkP0zxNQ
NfNZKGOuXYXp23B5GSsBB37iRVDCivXK3RIhB3PbySSs3ijFv678zMK5HhKggdfuJgSwYkyO
OMzCJVvPfdhViZi7Ww2AsFnraMmhkCV5kZfzxdknPc9w4CUznDrjTsI9stlW82tu/ezKSzak
Vf/6Ha2MDhjtsDaVPkfFR9xtBTyZEQO1UWdKA3sWCqK0N1rIvN1I5i1V4DYE6u+uL7LAI5wL
aBs/9tDZfAKTosgzWtVA4RvliFeCDLj7+2+baBc98bn3Y+4lfnyIczceQd/rSN3wxeV1Aq2N
M1pnVDMvAOiyi8Lo3cdj+uuKgETciZDbIyKtxbk9P+hL7rT0CN+HrKPI1QNB2S2jvOE6ojAk
9t8d5UBsfBQvycJLk7mwJhIubFew+6WH+5bTgPYuG5OgW+4E71djkfPLaMgV9AujK1REqLuK
4lQ0HnNEr5Dc8af9Hn3F1qEYn+UGCVA2d3mPvqubsVxGdf/09fnnRf7288/jyxDoyg9F5LXs
grJifUuG4Vab7ZDnkcF49BqF85qlNKKAtz1NFM57P8umiaoIHevLA/NuPAx2cKp/9/0jYd2f
jv8RsTVbXjq8LThHmOxYrKgPGZbElAHdAGLtJXeBYqjqf+jA90plJF4fvz2pwI6H78eH/z4+
fdM8pckKrZW3728ttXswm4KkM/5Lu/LZyFxUB+WXFH8aw2r+fLl/+fvi5fnt9Pik68Lq4ka/
0NnIpoow56juXUlXh0KTxEOwQd1UeVAeurgiV379OkAnSaPcg80jdN+QukFvQMUyD+F/FZaA
k42Lx2Ssg6ethbLA5FqARu0gK/dBokzRVRRbFOh8EKPIBH2nkWUqzduNAA7hsKYN0HxtUrh6
NnSmaTvzqeXC+gkcPI3tkoQ9JpVBtDnw53KNYMU8KqqdnwUiBcwr364pQAK7cS5cLJUb92gT
aIr6ft8fJiZvBpGHRaYNn2n2DtpFD93UcBYhaM/iJygwdLIEmBFrCEWXeRe+YqlXLDXyboac
wBz9/g7B9u/+QsiEURhL6dJKoX+GHiiqjIM1SZttHATm6HTb3QSf9a/QQz3zP42t2xqJEzXE
BhALFpPeZYJF7O889IUHrs3EsMt1Q8SwokAR6+oiLQwdRYdiq/qu3ejV7cjZ8xar4sIj2ryJ
qhIHxRY0nlHXRSApVVxHBBMKOQnwID12RoGoQLXBmxAe6pOUU2cpDVMHfHPbJBYOEZgcE+0i
tv8U4kQYVl0DGpPBNRHT+2QWpe4MtpNFk2pLp96mama1fUxux7Xc5gKromqNftFlQloYdzj4
+9zOztPeqX54S3qH1iqD1RRVKPmbFxgk06asvgz5U3tIVkqjMk0hQwpKAbGkV5UN6gVKKtMN
uUAd3a5eRNCrv/Q1RCD0ToXRGpFnNcao6YWXRzmjshHqlcVHFMZydYYVZES1Ktiki1Ms6WeG
QDhEWdBXlx4604DiEEZloXcQ1oixHEFxyKjk6MZKO64mh/2epGPcHF+ejj8uvt8Peg1Bf708
Pp3+q4J2fx5fv7nGXNJUsFpeZvr6YQwXyOltCspIOhpMPnopvrQyaj6txs8OM0CJXO0WVprp
F53p+veHUeo5kISHXGBpK74UIR5CHn8cfzs9/uy1ulca7YOCv7gDVk5XGHOic7oBhp7TbRAZ
x1cNW4NW4gngm4jCnahiPkB4G26wRpcsPb7OUU6ml6zFiwPc9ZwZF1MNk7f7p8VsdWUukRLY
Yob1xtnCSqBrU/tAo+29HFSzsK9RbnrX4hcsdjlrNXIr6ybQPObvG8J9DMJaBUGgc2gmVElT
3XBr4GhwXZGnrBWbhl8WJCus3dWB7JChY2jvu1pgkKFyBsT8hyXnTZIJDHoGVb/SdHINOJp7
1Zf6NPtrzlGpgGd7DpRP53AqUIUtL8Ljn2/fvhlnEZr3aN9EcPDU5ahqBbGWgLAQwzKazJzm
J4XJqws7VsKaLSIEHf0MSVXAVAu/4oI0yu++dr9Gj2AZmoc0BqXgvRcRI6tqe2oGLFoefbgq
aGkJ+/sKywZWDfC+Ftfeu12xvsLc2hCp2DibBGCgdAitj+QE0i8fEEw90urggPF2Se2OtjY8
uhXqNnMhZFAxxduIqpxeA7DcwlFgWzPSsCeRVdO6G8IDVmlNgZnqClQPpDgiOBl2UVUVlRNr
rk0XjRmDU+K02LlzZqB93jc0jBtRC05RuDHdLQKlWIgcwCoerCuNSx+kP7PM68Qqm6KsWMge
LjDJ2tsvJdqS+6dvesYTOEu3JbTRwETounhdxI2LNKQvlrXIdMJS5JJNjOolRpbbAh+cpq0K
e7xSW3FDwlxnRkCuRjX0zTMziOySNsey9DW3wHdfQFyA0AgLTXVUXQORUhjKtgHuez43kdjd
om2mAdUwjNB18CawP2hJPaW2XZSHXmGuPj2+9CaKSqX+qjsjNBePsuHiX6+/Hp/QhPz674uf
b6fjX0f4x/H08Pvvv/+fuRZUk1SbwNGdywoWvBbvN3aXHsTReLuI56a2ifaRw1uHjOjOLubJ
dzuFAWZX7MiLzCKgvlgCjmIXotLdxT3C2+2hLmoa+Z7GiaLbzV4QsUV3sUuwRvH0NZSXHJbf
OJzpCqlHKR4Am9rijbQqrIBR0nhg0FgzGw6ZsHbU5QzD65V4OcNIegqQ3iATar/IhP9uMTNG
7bB5utS0tQs5gG2+dU6NGNg1N6uKIgCNO8obqfLwqbv5oGXVIlq9gNSmmP0mKMlBVscM2P+A
k3wCgdGX+kwsS7+gv/SqZeUolRalitQFxQ7jztgjOSfcDBWwzLwScHL1jRrMScLSsb2zApVZ
Grzpy4NDU3B7jW7zp2XtMp6cco4BSpNPJGDjNle6/3nsthJlwtMM58PY2lEMstvJJsHbh9p+
j0JnpNmRH2UVWiQYBoj7kyjp9OE0graWgwUM+tZU0xZvqCi7ktVv1ZXA5Kh09rcTrMO5Om+I
3rg2gT8NrrEaRhu4k6Y11cdPYSicLiOiKCsbvMlhx+q8b7gOtF/UEzI3OHawvG8N+D7/dJqZ
+kqTwXEZQILOEjNPKxmt4OyaT3aw6hkCYxzDyqidj1vnoqyTwv3qA2I4h1pfYAOsHz4csDsK
z8+L3I5fJbjIYYcLdI5XD7AlaZQGYk/skLZIS1wwNt9C+5uImU/nRkaNn+cow5frO+vJaNNP
YCOAKZfOQXKkw9p1zrusVWZe6qJ5bii0rg9uWtHdBthZkgnWc1/fIyOdIRs0gne7r0YZ4b02
3hvjfHjpsF019ZQvh6VDOSjDqCuSQM6X1yu6W8bDEv+18EoahLcvnUsFfAnvHLH7qhiabsRO
b0I9hRQSkRoA5wB9SxO8B00njEkegG7kuyeoNnjZbwlkwxBg4ZRKt14xGpfuDW/pYtjBJNpj
sKXdbXWzqjyGawt5A9hGT2dE0NG8O327SJlJM8HJxwEL4jgNncfaVvImcMIq44evUe18q4Mr
NPVR6InzNq+5n7Ay5PypyBQM/Tc2g/5YLKsMVFj3bSp63tf7lq59nYeMywHfsxguAdzZ0OoB
5llldC+Td3RhBfIYs6Ta0TgCk6ZzPFS7CdiGhn0EfzMPTKaATS36TDnyLkJxa3BaxJ57HFg0
2iJkH+is+ziZZwtXxqLPTq/c0+FdLwgWiSrtXRQMpqbDu3Cz5VayQRPF0vs85hXch6z7MFVT
ayjs2YyDmRBaZ2PZldum66G27r3neV7RwtIntfaMOo75EdCQ4/vko9hxpxdr3eLSJceTbra/
mk0XBjYOPtucx/XLf8FjSe4vp06PWHwdp+hMeNN+MSJav5VlpMG3nomBMroI47JPOGTSwYsi
TzR7Kc6cpwrYlBluFJmn8p37aVK2vYfKPJOsTweusN4a4DmplS1sVpIxZzra5jvMllN1cO7j
jkMD2rZV/D9rdRTFgN0BAA==

--jRHKVT23PllUwdXP--
