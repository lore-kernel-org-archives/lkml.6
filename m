Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeCLRZw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:25:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57406 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932445AbeCLRZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:25:50 -0400
Date: Mon, 12 Mar 2018 20:25:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Shirish S <shirish.s@amd.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4765
 dm_atomic_check_plane_state_fb() error: 'crtc_state' dereferencing possible
 ERR_PTR()
Message-ID: <20180312172524.ic7ue6osoqx6ikkf@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=719
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803120197
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c8efd610b58cb23cefdfa12015799079aef94ae
commit: 36cc549d59864b7161f0e23d710c1c4d1b9cf022 drm/amd/display: disable CRTCs with NULL FB on their primary plane (V2)

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4765 dm_atomic_check_plane_state_fb() error: 'crtc_state' dereferencing possible ERR_PTR()

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=36cc549d59864b7161f0e23d710c1c4d1b9cf022
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 36cc549d59864b7161f0e23d710c1c4d1b9cf022
vim +/crtc_state +4765 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

62f55537 Andrey Grodzovsky 2017-08-18  4748  
36cc549d Shirish S         2018-02-28  4749  static int dm_atomic_check_plane_state_fb(struct drm_atomic_state *state,
36cc549d Shirish S         2018-02-28  4750  					  struct drm_crtc *crtc)
36cc549d Shirish S         2018-02-28  4751  {
36cc549d Shirish S         2018-02-28  4752  	struct drm_plane *plane;
36cc549d Shirish S         2018-02-28  4753  	struct drm_crtc_state *crtc_state;
36cc549d Shirish S         2018-02-28  4754  
36cc549d Shirish S         2018-02-28  4755  	WARN_ON(!drm_atomic_get_new_crtc_state(state, crtc));
36cc549d Shirish S         2018-02-28  4756  
36cc549d Shirish S         2018-02-28  4757  	drm_for_each_plane_mask(plane, state->dev, crtc->state->plane_mask) {
36cc549d Shirish S         2018-02-28  4758  		struct drm_plane_state *plane_state =
36cc549d Shirish S         2018-02-28  4759  			drm_atomic_get_plane_state(state, plane);
36cc549d Shirish S         2018-02-28  4760  
36cc549d Shirish S         2018-02-28  4761  		if (IS_ERR(plane_state))
36cc549d Shirish S         2018-02-28  4762  			return -EDEADLK;
36cc549d Shirish S         2018-02-28  4763  
36cc549d Shirish S         2018-02-28  4764  		crtc_state = drm_atomic_get_crtc_state(plane_state->state, crtc);
36cc549d Shirish S         2018-02-28 @4765  		if (crtc->primary == plane && crtc_state->active) {
36cc549d Shirish S         2018-02-28  4766  			if (!plane_state->fb)
36cc549d Shirish S         2018-02-28  4767  				return -EINVAL;
36cc549d Shirish S         2018-02-28  4768  		}
36cc549d Shirish S         2018-02-28  4769  	}
36cc549d Shirish S         2018-02-28  4770  	return 0;
36cc549d Shirish S         2018-02-28  4771  }
36cc549d Shirish S         2018-02-28  4772  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
