Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Fg9HvSJ2kGeC+x1afVgbfIVpDQK7ykNSO8HOx06V6sXur17P+mmIA3OOWMI8In4b96p1A
ARC-Seal: i=1; a=rsa-sha256; t=1523473370; cv=none;
        d=google.com; s=arc-20160816;
        b=Lm0g34+AWCHpladUHtbwqlx/1rprDUjBqdDTzGoq/TKCKXSF2lrjDJURJN8wXsss4A
         KzSMRk9cl4ENM5cK/1yLWgHXAoiyAQAh/pKMVAyw2Mde2JQKPVrkp29jnn+BA5ugLDPD
         LMeR7zFzhrnDimd/xK3sDgZZaizI/in4XC+ZLhfYGSLnup5Vj3cIbWLFOfQaf+n1As+s
         QNn4wkzg7TrdgOmett/rXkk67U60EbM0emwocgC6N3G33RTpyuPJyW+57DQx5Vj9bJ0n
         QUmZWinYU1C2adkXbY5TyFLfCaZcEvD+LrtEjcZ4GMRMx6GV5Zx0eUkNPNhZfALIBM+9
         0+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v/WRGLE4kFDrCrdxzub3QwzFlmpUGymms8Eo3dYanaw=;
        b=t3CjCJ78iVMi0+bEXCPZdAltsd5DpJJJmpfh4IctW2nMu7bMnOJv1vGrX0Tyv2MFIk
         I1eCBfeYr0tsKHbA67PHPGdqQlzmFxpyU5XAME5ElbnnGNDgsnG9plNaV860vMvgQXOV
         1904c8s9U6bqYlu7y29lW8kp1og6e/Nh4S1XCA56gVUoTkD2eq8XZqU9sNET8viJKlg8
         1N3XkJ+zRHs+h1dZIzInu5YE66YwQ4X2qvsO8b5adB6odUCgoaZqtkjboXeAHCokOpE5
         x+EMUc9RX4/TphvGEEvNJketGqbeImtszaqi3FVXOuN+/VPZHujVh1fSEiR6zQ1T86Q2
         AaCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	David Ahern <dsahern@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Wang Nan <wangnan0@huawei.com>,
	kernel-team@lge.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 224/310] perf tools: Decompress kernel module when reading DSO data
Date: Wed, 11 Apr 2018 20:36:03 +0200
Message-Id: <20180411183632.165676780@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477613219330133?=
X-GMAIL-MSGID: =?utf-8?q?1597477613219330133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>


[ Upstream commit 1d6b3c9ba756a5134fd7ad1959acac776d17404b ]

Currently perf decompresses kernel modules when loading the symbol table
but it missed to do it when reading raw data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170608073109.30699-6-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/dso.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -366,7 +366,23 @@ static int __open_dso(struct dso *dso, s
 	if (!is_regular_file(name))
 		return -EINVAL;
 
+	if (dso__needs_decompress(dso)) {
+		char newpath[KMOD_DECOMP_LEN];
+		size_t len = sizeof(newpath);
+
+		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
+			free(name);
+			return -dso->load_errno;
+		}
+
+		strcpy(name, newpath);
+	}
+
 	fd = do_open(name);
+
+	if (dso__needs_decompress(dso))
+		unlink(name);
+
 	free(name);
 	return fd;
 }
